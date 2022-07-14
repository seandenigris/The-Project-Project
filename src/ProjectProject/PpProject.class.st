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
		'status',
		'completionTimestamp',
		'context',
		'supportMaterials',
		'requirements',
		'dependencyLinks'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #examples }
PpProject class >> exampleComplete [
	<gtExample>
	^ self
		given: [ self exampleIncomplete title: 'something done'; yourself ]
		when: [ :p | p isComplete: true ]
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

{ #category : #accessing }
PpProject class >> neverDoingStatus [
	^ 'Never Doing'
]

{ #category : #accessing }
PpProject class >> notDoingStatus [
	^ 'Not Doing'
]

{ #category : #accessing }
PpProject class >> statusOptions [
	^ { self neverDoingStatus. self notDoingStatus }
]

{ #category : #'instance creation' }
PpProject class >> titled: aString [
	^ self new
		title: aString;
		yourself
]

{ #category : #accessing }
PpProject >> addChild: aPpProject [
	^ self masterList addChild: aPpProject to: self
]

{ #category : #enumeration }
PpProject >> allChildren [
	| roots branches |
	roots := self rootChildren.
	branches := self rootChildren flatCollect: [ :p | p allChildren ].
	^ (roots, branches) asSet.
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
	
	self flag: 'The problem is the child''s due date. See https://gitlab.com/SeanDeNigris/The-Project-Project/issues/3'.
	^ super childrenDescription
		priority: 300;
		reference: self magritteDescription;
		yourself
]

{ #category : #accessing }
PpProject >> childrenLabel [
	^ 'Steps'
]

{ #category : #accessing }
PpProject >> completionTimestamp: timestamp [
	completionTimestamp := timestamp
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
	^ self class neverDoingStatus
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
PpProject >> gtSpotterNewChildFor: aStep [
	<gtSearch>
	self 
		gtSpotterNewChildIn: PpProjectList uniqueInstance 
		labeled: 'step' 
		for: aStep
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

{ #category : #testing }
PpProject >> isActiveDueBy: aDate [
	^ self isComplete not and: [ self dueDate isNotNil and: [ self dueDate < aDate ] ]
]

{ #category : #accessing }
PpProject >> isComplete [
	^ completionTimestamp isNotNil
]

{ #category : #accessing }
PpProject >> isComplete: aBoolean [
	completionTimestamp := aBoolean ppAsCompletionTimestamp.
	
	"Completion implies completion of subtasks, but the inverse is not true"
	aBoolean ifFalse: [ ^ self ].
	self allChildren do: [ :e | e isComplete ifFalse: [ e isComplete: true ] ]
]

{ #category : #magritte }
PpProject >> isCompleteDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
			accessor: #isComplete;
			label: 'Complete';
			priority: 150;
			default: false;
			beRequired;
			yourself
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
	<gtInspectorPresentationOrder: 20>
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

{ #category : #status }
PpProject >> status [
	^ status ifNil: [ status := self defaultStatus ]
]

{ #category : #status }
PpProject >> status: aStatus [
	status := aStatus
]

{ #category : #magritte }
PpProject >> statusDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #status;
		label: 'Status';
		priority: 250;
		morphicClass: MADropListMorph;
		options: self class statusOptions;
		default: self defaultStatus;
		"			readonly;
"
			yourself
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
	<gtInspectorPresentationOrder: 25>
	
	^ MAToManyRelationDescription new
			accessor: #supportMaterials;
			priority: 650;
			default: OrderedCollection new;
			classes: RlResource allSubclasses;
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
	^ title
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
			label: 'Title';
			priority: 100;
			default: '';
			beRequired;
			yourself
]
