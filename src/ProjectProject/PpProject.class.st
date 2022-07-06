Class {
	#name : #PpProject,
	#superclass : #Object,
	#traits : 'MATPropertyOwner + PpTProjectContainer',
	#classTraits : 'MATPropertyOwner classTrait + PpTProjectContainer classTrait',
	#instVars : [
		'title',
		'dueDate',
		'children',
		'note',
		'links',
		'tags',
		'status',
		'completionTimestamp',
		'context',
		'supportMaterials',
		'requirements'
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
PpProject >> activeChildren [
	self flag: 'This was cut and pasted from ProjectList>>#activeProjects. We should unify. https://bitbucket.org/SeanDeNigris/the-project-project/issues/7/unify-shared-projectlist-and-project'.
	^ self children reject: [ :e | e isComplete ]
]

{ #category : #enumeration }
PpProject >> allChildren [
	^ self children, (self children flatCollect: [ :child | child allChildren ])
]

{ #category : #enumeration }
PpProject >> allProjects [
	"For option description"
	^ PpProjectList uniqueInstance allProjectsList projects
]

{ #category : #enumeration }
PpProject >> allProjectsDo: aBlock [
	aBlock value: self.
	self children do: [ :child | child allProjectsDo: aBlock ]
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

{ #category : #accessing }
PpProject >> children [
	^ children ifNil: [ children := OrderedCollection new ]
]

{ #category : #accessing }
PpProject >> children: anObject [
	children := anObject
]

{ #category : #magritte }
PpProject >> childrenDescription [
	<magritteDescription>
	<gtInspectorPresentationOrder: 10>
	self
		flag:
			'The problem is the child''s due date. See https://gitlab.com/SeanDeNigris/The-Project-Project/issues/3'.
	^ MAToManyRelationDescription new
		accessor: #children;
		label: 'Steps';
		priority: 300;
		display: [ :e | e displayString ];
		default: OrderedCollection new;
		beOrdered;
		kind: OrderedCollection;
		classes: PpProject allSubclasses;
		gtSearchSource: (MessageSend receiver: PpProjectList selector: #uniqueInstance);
		morphicClass: MAMorphicTokenCompletion;
		initializer: [ :s | 
			PpProject new
				title: s;
				yourself ];
		reference: self magritteDescription;
		yourself
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

{ #category : #GT }
PpProject >> gtInspectorLinksIn: composite [

	| list |
	list := composite list.
	list dynamicActionsOnSelection: [ :pres |
		| actions |
		actions := OrderedCollection new.
		pres selection magritteActionDescriptions do: [ :desc |
			| action |
			action := GLMGenericAction new
				action: [ pres selection perform: desc selector ];
				title: desc label;
				shortcut: desc label first lowercase;
				yourself.
			actions add: action ].
		actions ].
	^ list
]

{ #category : #accessing }
PpProject >> gtSpotterNewStepFor: aStep [
	<gtSearch>
	self 
		gtSpotterNewProjectIn: PpProjectList uniqueInstance 
		labeled: 'step' 
		for: aStep
]

{ #category : #views }
PpProject >> gtViewFor: aView [

	<gtView>
	| tabs |
	^ aView columnedTree
		title: 'Steps' translated;
		priority: 25;
		items: [ self children ];
		children: #children;
		column: 'Item' 
			text: [ :e | e gtDisplayText ]
			width: 400;
		column: 'Due Date' text: [ :p | p dueDateDescription readToString: p ];
		actionUpdateButtonTooltip: 'Update'
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

{ #category : #magritte }
PpProject >> supportMaterialsMOEDescription [
	<magritteDescription>
	<gtInspectorPresentationOrder: 25>
	^ MAMultipleOptionDescription new
		accessor: #supportMaterials;
		label: 'Materials';
		priority: 650;
		default: OrderedCollection new;
		morphicClass: MATokenCompletionMorph;
		readOnly;
		extensible: true;
		initializer: [ :text | 
			| resource |
			"This doesn't work because #openInWindow below returns immediately, making the window the initialized 'resource'!"
			resource := LlPhysicalResource new
				description: text;
				yourself.
			resource asMagritteMorph
				addButtons;
				onAnswer: [ :e | e ];
				openInWindow ];
		options: RlResourceLibrary uniqueInstance resources;
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
