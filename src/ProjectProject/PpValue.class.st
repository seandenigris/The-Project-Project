Class {
	#name : #PpValue,
	#superclass : #PpAbstractProjectContainer,
	#traits : 'MATPropertyOwner + (PpTMutableProjectContainer - {#masterList}) + PpTMaterialSubject',
	#classTraits : 'MATPropertyOwner classTrait + PpTMutableProjectContainer classTrait + PpTMaterialSubject classTrait',
	#instVars : [
		'title',
		'note',
		'tags',
		'log',
		'stakeholders',
		'supportMaterialsvalue'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #examples }
PpValue class >> exampleComplete [
	<gtExample>
	^ self
		given: [ self exampleIncomplete title: 'something done'; yourself ]
		when: [ :p | p beComplete ]
		then: [ :p | p isComplete should equal: true ]
]

{ #category : #examples }
PpValue class >> exampleIncomplete [
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
PpValue class >> fromString: aString [
	^ self titled: aString
]

{ #category : #accessing }
PpValue class >> inactiveStatus [
	^ PpInactiveStatus new
]

{ #category : #accessing }
PpValue class >> label [
	^ (self name allButFirst: 'Pp' size) normalizeCamelCase
]

{ #category : #testing }
PpValue class >> peCanHandleFromString: aString [
	^ true
]

{ #category : #accessing }
PpValue class >> statusOptions [
	^ PpStatus allSubclasses collect: #new
]

{ #category : #'instance creation' }
PpValue class >> titled: aString [
	^ self new
		title: aString;
		yourself
]

{ #category : #convenience }
PpValue >> addToMaterialsResourceLibraryLast: anInteger [

	| resources |
	resources := RlResourceLibrary uniqueInstance resources last: anInteger.
	^ self supportMaterials addAll: resources.
]

{ #category : #accessing }
PpValue >> addressBook [
	^ MpAddressBook uniqueInstance
]

{ #category : #enumeration }
PpValue >> allChildren [
	| roots branches |
	roots := self rootChildren.
	branches := roots flatCollect: [ :p | p allChildren ].
	^ (roots, branches) asSet.
]

{ #category : #spotter }
PpValue >> allChildrenGtSpotterFor: aStep [
	
	^ (super allChildrenGtSpotterFor: aStep)
		title: 'Projects - Add Child';
		send: [ :result | self ensureChild: result ]
]

{ #category : #actions }
PpValue >> browseSupportMaterials [

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
PpValue >> childrenDescription [
	
	self flag: 'The problem is the child''s due date. See https://github.com/seandenigris/The-Project-Project/issues/15'.
	^ super childrenDescription
]

{ #category : #accessing }
PpValue >> childrenLabel [
	^ 'Steps'
]

{ #category : #'gt-views' }
PpValue >> conditionsGtViewFor: aView [
	<gtView>
	
	^ aView list
		title: 'Requirements' translated;
		priority: 25;
		items: [ self conditions asOrderedCollection ];
		inspectButtonFor: [ self conditions ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #status }
PpValue >> defaultStatus [
	^ PpActiveStatus new
]

{ #category : #'gt-views' }
PpValue >> dependencyLinksGtViewFor: aView [

	<gtView>
	
	^ aView list
		title: 'Dependency Links' translated;
		priority: 102;
		items: [ 
			self myDependencyLinks asOrderedCollection ];
		inspectButtonFor: [ self myDependencyLinks ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #printing }
PpValue >> displayStringOn: aStream [

	self title ifNotNil: [ aStream nextPutAll: self title ].
]

{ #category : #accessing }
PpValue >> displayText [
	^ self isComplete
			ifTrue: [ 
				self displayString asText
					addAttribute: TextEmphasis struckOut;
					yourself ]
			ifFalse: [ self displayString ]
]

{ #category : #accessing }
PpValue >> dueBy: aDate [
	
	^ self newFromChildrenBlock: [ {} ]
]

{ #category : #accessing }
PpValue >> dueDateString [
		^ ''
]

{ #category : #accessing }
PpValue >> ensureChild: aPpProject [
	self masterList addChild: aPpProject to: self.
	^ aPpProject
]

{ #category : #magritte }
PpValue >> eventLog [

	^ PpEventLog uniqueInstance
]

{ #category : #accessing }
PpValue >> gtDisplayText [
	| result |
	result := self displayString asRopedText.
	self isComplete ifTrue: [ result strikethrough ].
	^ result.
]

{ #category : #accessing }
PpValue >> gtSpotterText [

	^ self gtDisplayText
]

{ #category : #accessing }
PpValue >> gtTextFromString: aString [
	
	^ aString asRopedText
]

{ #category : #accessing }
PpValue >> gtTextTitleWithParents [
	
	| string |
	string := String streamContents: [ :str |
		str << self title.
		self parents
			"select: #isProject
			thenD"do: [ :e | str << ' < ' << e title ] ].
	^ self gtTextFromString: string
]

{ #category : #'gt-views' }
PpValue >> gtViewGraphFor: aView [
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
PpValue >> gtViewTimelineOn: aView [
	<gtView>
	^ aView explicit
		title: 'Timeline' translated;
		priority: 10;
		stencil: [ self timeline ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #accessing }
PpValue >> import [
	PpProjectList uniqueInstance ensureChild: self
]

{ #category : #accessing }
PpValue >> importDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		gtIcon: BrGlamorousVectorIcons down;
		comment: 'Import into Singleton Library';
		action: #import;
		enableBlock: [ :proj | proj masterList isNil ];
		yourself
]

{ #category : #initialization }
PpValue >> initialize [

	super initialize.
	self ensureUUID.
	self status: self defaultStatus.
]

{ #category : #testing }
PpValue >> isAction [
	^ false
]

{ #category : #testing }
PpValue >> isActiveDueBy: aDate [
	^ false
]

{ #category : #accessing }
PpValue >> isComplete [
	^ self status isComplete
]

{ #category : #magritte }
PpValue >> isCompleteDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
			accessor: #isComplete;
			label: 'Complete';
			priority: 150;
			beReadOnly;
			yourself
]

{ #category : #accessing }
PpValue >> isNextAction [
	^ false
]

{ #category : #testing }
PpValue >> isProject [
	^ false
]

{ #category : #testing }
PpValue >> isValue [
	^ true
]

{ #category : #testing }
PpValue >> isWaitingFor [
	^ false
]

{ #category : #accessing }
PpValue >> log [

	^ log ifNil: [ log := OrderedCollection new ]
]

{ #category : #accessing }
PpValue >> log: aCollection [

	log := aCollection
]

{ #category : #'gt-views' }
PpValue >> logGtViewFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Log' translated;
		priority: 25;
		items: [ self log ];
		column: 'Status' text: [ :p | p gtDisplayText ];
		column: 'Timestamp' text: [ :p | p timestamp printUS ];
		inspectButtonFor: [ self log ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #accessing }
PpValue >> maGtFormFor: aView [
	
	^ (super maGtFormFor: aView)
		priority: 5;
		yourself
]

{ #category : #accessing }
PpValue >> moveChild: childPpValue to: parentPpValue [

	self removeChild: childPpValue.
	parentPpValue ensureChild: childPpValue.
]

{ #category : #accessing }
PpValue >> myDependencyLinks [
	^ self dependencyLinks select: [ :link | link includes: self ]
]

{ #category : #accessing }
PpValue >> note [
	^ note
]

{ #category : #accessing }
PpValue >> note: anObject [
	note := anObject
]

{ #category : #magritte }
PpValue >> noteDescription [
	<magritteDescription>
	
	^ MAMemoDescription new
		accessor: #note;
		priority: 400;
		yourself
]

{ #category : #private }
PpValue >> parentLinks [
	^ self dependencyLinks select: [ :link |
		link dependency = self ]
]

{ #category : #accessing }
PpValue >> parents [
	^ self parentLinks collect: #project
]

{ #category : #private }
PpValue >> parentsGtSpotterFor: aStep [
	<gtSearch>
	
	^ (super allChildrenGtSpotterFor: aStep)
		title: 'Projects - Add Parent';
		send: [ :result | 
			result 
				ensureChild: self;
				yourself ]
]

{ #category : #'gt-views' }
PpValue >> parentsGtViewFor: aView [
	<gtView>
	
	"Don't cache parents and use in #items: below because then we won't be able to update the view"
	self parents ifEmpty: [ ^ aView empty ].
	
	^ aView columnedTree
		title: 'Parents' translated;
		priority: 25;
		items: [ self parents ];
		children: #parents;
		column: 'Item' text: [ :p | p gtDisplayText ];
		column: 'Due Date' text: [ :p | p dueDateString ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #printing }
PpValue >> printOn: aStream [
	aStream 
		nextPutAll: self className;
		nextPutAll: ': '.
	aStream nextPutAll: self displayString
]

{ #category : #accessing }
PpValue >> removeChild: aPpProject [
	
	self masterList removeChild: aPpProject from: self.
	^ aPpProject
]

{ #category : #accessing }
PpValue >> removeFromMasterList [

	self masterList allChildren remove: self.
	self dependencyLinks
		select: [ :link | link includes: self ]
		thenDo: [ :link | link unlink ]
]

{ #category : #accessing }
PpValue >> rootChildren [
	^ self rootChildrenLinks collect: #dependency
]

{ #category : #private }
PpValue >> rootChildrenLinks [
	^ self dependencyLinks select: [ :link |
		link project = self ]
]

{ #category : #accessing }
PpValue >> stakeholders [

	^ self maLazyInstVarUsing: self stakeholdersDescription
]

{ #category : #accessing }
PpValue >> stakeholders: aSet [

	stakeholders := aSet
]

{ #category : #accessing }
PpValue >> stakeholdersDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
		referenceDisplay: #displayStringNoProject;
		accessor: #stakeholders;
		priority: 200;
		default: Set new;
		classes: PpStakeholder withAllSubclasses;
		gtSearchDelegateTo: self message: #stakeholdersSearchNewFor:;
		yourself
]

{ #category : #'gt-views' }
PpValue >> stakeholdersGtViewFor: aView [
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
		inspectButtonFor: [ self stakeholders ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #spotter }
PpValue >> stakeholdersSearchNewFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		title: 'New Stakeholder';
		priority: 50;
		items: [ {} ];
		itemName: [ :result | result person fullName, ' -> ', result role ];
		filter: (PeGtSubInstancesFilter new
			rootClass: PpStakeholder;
			yourself);
		send: [ :result |
			result 
				project: self;
				link;
				yourself ]
]

{ #category : #status }
PpValue >> status [
	^ self log
		ifNotEmpty: [ :lg | lg last ]
		ifEmpty: [ 
			"We don't lazy initialize because it is done in #initialize"
			nil ]
]

{ #category : #status }
PpValue >> status: aStatus [
	
	"This guard was added because Magritte was adding duplicate statuses"
	self status = aStatus ifTrue: [ ^ self ].
	
	aStatus timestamp ifNil: [ aStatus timestamp: DateAndTime now translateToUTC ].

	self log add: aStatus
]

{ #category : #magritte }
PpValue >> statusDescription [
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
PpValue >> statusOptions [

	^ self class statusOptions
		add: self status; 
		yourself.
]

{ #category : #accessing }
PpValue >> tags [
	^ tags ifNil: [ tags := Bag new ]
]

{ #category : #accessing }
PpValue >> tags: anObject [
	tags := anObject
]

{ #category : #magritte }
PpValue >> tagsDescription [
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
PpValue >> timeline [
	| points aPlotter projectAddPoints |
	
	points := SortedCollection sortUsing: #ppTimelineStamp ascending.
	
	projectAddPoints := [ :p |
		p ppTimelineStamp ifNotNil: [ points add: p ].
		points addAll: (self supportMaterials reject: [ :e |
			e ppTimelineStamp isNil ]) ].
	
	projectAddPoints value: self.
	
	self allChildren do: projectAddPoints.
	
	points ifEmpty: [ ^ BlElement new ].

	aPlotter := GtPlotter new.
	aPlotter verticalTimeline
		withProjectionAxis;
		timelineData: #ppTimelineStamp;
		projectionData: #displayString;
		timelineFrom: (points first ppTimelineStamp - 7 days) 
			to: (points last ppTimelineStamp + 7 days);
		with: points.
	^ aPlotter
]

{ #category : #accessing }
PpValue >> title [
	^ self maLazyInstVarUsing: self titleDescription
]

{ #category : #accessing }
PpValue >> title: anObject [
	title := anObject
]

{ #category : #magritte }
PpValue >> titleDescription [
	<magritteDescription>
	^ MAStringDescription new
			accessor: #title;
			priority: 100;
			default: '';
			beRequired;
			yourself
]
