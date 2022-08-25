Class {
	#name : #PpProject,
	#superclass : #PpAbstractProjectContainer,
	#traits : 'MATPropertyOwner + PpTMutableProjectContainer',
	#classTraits : 'MATPropertyOwner classTrait + PpTMutableProjectContainer classTrait',
	#instVars : [
		'title',
		'dueDate',
		'note',
		'links',
		'tags',
		'context',
		'supportMaterials',
		'requirements',
		'log',
		'stakeholders'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #examples }
PpProject class >> exampleComplete [
	<gtExample>
	^ self
		given: [ self exampleIncomplete title: 'something done'; yourself ]
		when: [ :p | p beComplete ]
		then: [ :p | p isComplete should equal: true ]
]

{ #category : #examples }
PpProject class >> exampleIncomplete [
	<gtExample>
	^ self
		given: [ ]
		when: [ 
			(self titled: 'something to do')
				dueDate: Date tomorrow;
				yourself ]
		then: [ :p | 
			p isComplete should equal: false.
			p dueDate should equal: Date tomorrow ]
]

{ #category : #'instance creation' }
PpProject class >> fromString: aString [
	^ self titled: aString
]

{ #category : #accessing }
PpProject class >> inactiveStatus [
	^ PpInactiveStatus new
]

{ #category : #accessing }
PpProject class >> label [
	^ (self name allButFirst: 'Pp' size) normalizeCamelCase
]

{ #category : #accessing }
PpProject class >> statusOptions [
	^ PpStatus allSubclasses collect: #new
]

{ #category : #'instance creation' }
PpProject class >> titled: aString [
	^ self new
		title: aString;
		yourself
]

{ #category : #accessing }
PpProject >> addChild: aPpProject [
	aPpProject status isInbox ifTrue: [ 
		"We assume that adding a child project indicates we are in an organizing, not a capturing phase"
		aPpProject status: PpActiveStatus new ].
	^ self masterList addChild: aPpProject to: self
]

{ #category : #accessing }
PpProject >> addressBook [
	^ MpAddressBook uniqueInstance
]

{ #category : #enumeration }
PpProject >> allChildren [
	| roots branches |
	roots := self rootChildren.
	branches := roots flatCollect: [ :p | p allChildren ].
	^ (roots, branches) asSet.
]

{ #category : #accessing }
PpProject >> beComplete [

	self status: PpCompleteStatus new.
	
	self allChildren do: [ :e | e isComplete ifFalse: [ e beComplete ] ]
]

{ #category : #actions }
PpProject >> browseSupportMaterials [

	| folder template |
	folder := Tempfile new.
	folder ensureCreateDirectory.
	template := 'ln -s "{source}" "{target}"'.
	self supportMaterials do: [ :e | 
		| command |
		command := template format: { #source -> e file fullName. #target -> folder fullName } asDictionary.
		LibC system: command ].
	folder open
]

{ #category : #magritte }
PpProject >> childrenDescription [
	
	self flag: 'The problem is the child''s due date. See https://github.com/seandenigris/The-Project-Project/issues/15'.
	^ super childrenDescription
]

{ #category : #accessing }
PpProject >> childrenLabel [
	^ 'Steps'
]

{ #category : #accessing }
PpProject >> context [
	^ context
]

{ #category : #accessing }
PpProject >> context: anObject [
	context := anObject
]

{ #category : #status }
PpProject >> defaultStatus [
	^ PpInboxStatus new
]

{ #category : #accessing }
PpProject >> delete [

	self masterList allChildren remove: self.
	self dependencyLinks
		select: [ :link | link includes: self ]
		thenDo: [ :link | link unlink ]
]

{ #category : #printing }
PpProject >> displayStringOn: aStream [

	title ifNotNil: [ aStream nextPutAll: self title ].
	dueDate ifNotNil: [
		aStream
			nextPutAll: ' (Due ';
			nextPutAll: self dueDate mmddyyyy;
			nextPut: $) ]
]

{ #category : #accessing }
PpProject >> displayText [
	^ self isComplete
			ifTrue: [ 
				self displayString asText
					addAttribute: TextEmphasis struckOut;
					yourself ]
			ifFalse: [ self displayString ]
]

{ #category : #accessing }
PpProject >> dueBy: aDate [
	
	^ self newFromChildrenBlock: [ 
		self activeChildrenList rootChildren ]
]

{ #category : #accessing }
PpProject >> dueDate [
	^ dueDate
]

{ #category : #accessing }
PpProject >> dueDate: anObject [
	dueDate := anObject
]

{ #category : #magritte }
PpProject >> dueDateDescription [
	<magritteDescription>
	
	^ MADateDescription new
			accessor: #dueDate;
			label: 'Due Date';
			priority: 200;
			"default: Date today;"
			"beRequired;"
			yourself
]

{ #category : #accessing }
PpProject >> gtDisplayText [
	| result |
	result := self displayString asRopedText.
	self isComplete ifTrue: [ result strikethrough ].
	^ result.
]

{ #category : #accessing }
PpProject >> gtGtSpotterAllChildrenFor: aStep [
	
	^ (super gtGtSpotterAllChildrenFor: aStep)
		send: [ :result | self addChild: result ]
]

{ #category : #accessing }
PpProject >> gtViewDependencyLinksFor: aView [

	<gtView>
	
	^ aView list
		title: 'Dependency Links' translated;
		priority: 102;
		items: [ 
			(self dependencyLinks 
				select: [ :link |
					link includes: self ]) asOrderedCollection ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect Dependency Links'
			action: [ :aButton :aTab | aButton phlow spawnObject: (self dependencyLinks 
				select: [ :link |
					link includes: self ]) ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #accessing }
PpProject >> gtViewGraphFor: aView [
	<gtView>
	| nodes |
	nodes := self allChildren add: self; yourself.
	^ aView mondrian
		title: 'Graph';
		painting: [ :m |
			m nodes
				stencil: [ :obj | 
					BlTextElement new
						text: obj gtDisplayText;
						background: Color white;
						margin: (BlInsets all: 20);
						padding: (BlInsets all: 5);
						effect:
							(BlGaussianShadowEffect
								color: (Color gray alpha: 0.5)
								width: 5
								offset: 0 @ 0);
						yourself ];
				with: nodes.
			m edges 
				connect: (nodes reject: [ :n | n rootChildren isEmpty]) 
				fromAll: [ :n | n rootChildren ].
			m layout horizontalTree.
			m ];
		actionUpdateButton
]

{ #category : #accessing }
PpProject >> gtViewLogFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Log' translated;
		priority: 25;
		items: [ self log ];
		column: 'Status' text: [ :p | p gtDisplayText ];
		column: 'Timestamp' text: [ :p | p timestamp printUS ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect Log'
			action: [ :aButton :aTab | aButton phlow spawnObject: self log ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #accessing }
PpProject >> gtViewParentsFor: aView [
	<gtView>
	
	"Don't cache parents and use in #items: below because then we won't be able to update the view"
	self parents ifEmpty: [ ^ aView empty ].
	
	^ aView columnedTree
		title: 'Parents' translated;
		priority: 25;
		items: [ self parents ];
		children: #parents;
		column: 'Item' text: [ :p | p gtDisplayText ];
		column: 'Due Date' text: [ :p | p dueDateDescription readToString: p ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #accessing }
PpProject >> gtViewStakeholdersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Stakeholders' translated;
		priority: 25;
		items: [ self stakeholders asOrderedCollection ];
		column: 'Role' 
			text: [ :holder | holder role gtDisplayText ]
			weight: 0.10;
		column: 'Person' 
			text: [ :holder | holder person gtDisplayText ]
			weight: 0.90;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect Stakeholders'
			action: [ :aButton :aTab | aButton phlow spawnObject: self stakeholders ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #initialization }
PpProject >> initialize [

	super initialize.
	self status: self defaultStatus
]

{ #category : #testing }
PpProject >> isAction [
	^ false
]

{ #category : #testing }
PpProject >> isActiveDueBy: aDate [
	^ self isComplete not and: [ self dueDate isNotNil and: [ self dueDate < aDate ] ]
]

{ #category : #accessing }
PpProject >> isComplete [
	^ self status isKindOf: PpCompleteStatus
]

{ #category : #magritte }
PpProject >> isCompleteDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
			accessor: #isComplete;
			label: 'Complete';
			priority: 150;
			beReadOnly;
			yourself
]

{ #category : #accessing }
PpProject >> isNextAction [
	self isAction ifFalse: [ ^ false ].
	self isComplete ifTrue: [ ^ false ].
	^ self rootChildren allSatisfy: #isComplete
]

{ #category : #testing }
PpProject >> isWaitingFor [
	^ false
]

{ #category : #accessing }
PpProject >> links [
	^ links ifNil: [ links := OrderedCollection new ]
]

{ #category : #accessing }
PpProject >> links: anObject [
	links := anObject
]

{ #category : #magritte }
PpProject >> linksDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #links;
		label: 'Links';
		priority: 600;
		default: OrderedCollection new;
		readOnly;
		classes: {ZnUrl} , RlResource allSubclasses;
		yourself
]

{ #category : #accessing }
PpProject >> log [

	^ log ifNil: [ log := OrderedCollection new ]
]

{ #category : #accessing }
PpProject >> log: aCollection [

	log := aCollection
]

{ #category : #accessing }
PpProject >> note [
	^ note
]

{ #category : #accessing }
PpProject >> note: anObject [
	note := anObject
]

{ #category : #magritte }
PpProject >> noteDescription [
	<magritteDescription>
	^ MAMemoDescription new
			accessor: #note;
			label: 'Note';
			priority: 400;
			yourself
]

{ #category : #private }
PpProject >> parentLinks [
	^ self dependencyLinks select: [ :link |
		link dependency = self ]
]

{ #category : #accessing }
PpProject >> parents [
	^ self parentLinks collect: #project
]

{ #category : #printing }
PpProject >> printOn: aStream [
	aStream nextPutAll: 'Project: '.
	aStream nextPutAll: self displayString
]

{ #category : #accessing }
PpProject >> requirements [

	^ requirements ifNil: [ requirements := Bag new ]
]

{ #category : #accessing }
PpProject >> requirements: aCollection [

	requirements := aCollection
]

{ #category : #accessing }
PpProject >> rootChildren [
	^ self rootChildrenLinks collect: #dependency
]

{ #category : #private }
PpProject >> rootChildrenLinks [
	^ self dependencyLinks select: [ :link |
		link project = self ]
]

{ #category : #accessing }
PpProject >> stakeholders [

	^ self maLazyInstVarUsing: self stakeholdersDescription
]

{ #category : #accessing }
PpProject >> stakeholders: aSet [

	stakeholders := aSet
]

{ #category : #accessing }
PpProject >> stakeholdersDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
		accessor: #stakeholders;
		priority: 200;
		default: Set new;
		classes: PpStakeholder withAllSubclasses;
		yourself
]

{ #category : #status }
PpProject >> status [
	^ self log
		ifNotEmpty: [ :lg | lg last ]
		ifEmpty: [ self defaultStatus ]
]

{ #category : #status }
PpProject >> status: aStatus [
	
	"This guard was added because Magritte was adding duplicate statuses"
	self status = aStatus ifTrue: [ ^ self ].
	
	"Translate to UTC because Pharo's Date offset support is fatally broken. See [Pharo Issue 12147: Date>>#= fooled by daylight savings time](https://pharo.fogbugz.com/default.asp?12147)"
	aStatus timestamp ifNil: [ aStatus timestamp: DateAndTime now translateToUTC ].

	self log add: aStatus
]

{ #category : #magritte }
PpProject >> statusDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #status;
		priority: 250;
		morphicClass: MAMorphicDropList;
		options: self statusOptions;
		default: self defaultStatus;
		yourself
]

{ #category : #magritte }
PpProject >> statusOptions [

	^ self class statusOptions
		add: self status; 
		yourself.
]

{ #category : #accessing }
PpProject >> supportMaterials [
	^ self maLazyInstVarUsing: self supportMaterialsDescription
]

{ #category : #accessing }
PpProject >> supportMaterials: anObject [
	supportMaterials := anObject
]

{ #category : #magritte }
PpProject >> supportMaterialsDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
			accessor: #supportMaterials;
			priority: 650;
			default: Bag new;
			classes: RlResource withAllSubclasses;
			morphicClass: MAMorphicTokenCompletion;
			gtSearchSource: (MessageSend receiver: RlResourceLibrary selector: #uniqueInstance);
			yourself
]

{ #category : #accessing }
PpProject >> tags [
	^ tags ifNil: [ tags := Bag new ]
]

{ #category : #accessing }
PpProject >> tags: anObject [
	tags := anObject
]

{ #category : #magritte }
PpProject >> tagsDescription [
	<magritteDescription>
	^ MAMultipleOptionDescription new
		accessor: #tags;
		label: 'Tags';
		priority: 250;
		default: Bag new;
		options: PpTag db;
		morphicClass: MAMorphicTokenCompletion;
		extensible: true;
		initializer: [ :text | PpTag ensureNamed: text ];
		"			readonly;
"
			yourself
]

{ #category : #accessing }
PpProject >> title [
	^ self maLazyInstVarUsing: self titleDescription
]

{ #category : #accessing }
PpProject >> title: anObject [
	title := anObject
]

{ #category : #magritte }
PpProject >> titleDescription [
	<magritteDescription>
	^ MAStringDescription new
			accessor: #title;
			priority: 100;
			default: '';
			beRequired;
			yourself
]
