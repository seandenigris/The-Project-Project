Class {
	#name : #PpProject,
	#superclass : #Object,
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
		'supportMaterials'
	],
	#category : #'ProjectProject-Core'
}

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
	^ PpProjectList uniqueInstance allProjects
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

{ #category : #magritte }
PpProject >> descriptionChildren [
	<magritteDescription>
	<gtInspectorPresentationOrder: 10>
	self
		flag:
			'The problem is the child''s due date. See https://gitlab.com/SeanDeNigris/The-Project-Project/issues/3'.
	^ MAMultipleOptionDescription new
		accessor: #children;
		label: 'Steps';
		priority: 300;
		display: [ :e | e displayString ];
		default: OrderedCollection new;
		beOrdered;
		glmPresentation: #list;
		options: self allProjects;
		morphicClass: MATokenCompletionMorph;
		initializer: [ :s | 
			PpProject new
				title: s;
				yourself ];
		extensible: true;
		reference: self magritteDescription;
		yourself
]

{ #category : #magritte }
PpProject >> descriptionDueDate [
	<magritteDescription>
	
	^ MADateDescription new
			accessor: #dueDate;
			label: 'Due Date';
			priority: 200;
			"default: Date today;"
			"beRequired;"
			yourself
]

{ #category : #magritte }
PpProject >> descriptionIsComplete [
	<magritteDescription>
	
	^ MABooleanDescription new
			accessor: #isComplete;
			label: 'Complete';
			priority: 150;
			default: false;
			beRequired;
			yourself
]

{ #category : #magritte }
PpProject >> descriptionLinks [
	<magritteDescription>
	<gtInspectorPresentationOrder: 20>
	^ MAToManyRelationDescription new
		accessor: #links;
		label: 'Links';
		priority: 600;
		default: OrderedCollection new;
		readOnly;
		classes: {ZnUrl} , RlResource allSubclasses;
		glmPresentation: #list;
		yourself
]

{ #category : #magritte }
PpProject >> descriptionNote [
	<magritteDescription>
	^ MAMemoDescription new
			accessor: #note;
			label: 'Note';
			priority: 400;
			yourself
]

{ #category : #magritte }
PpProject >> descriptionStatus [
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

{ #category : #magritte }
PpProject >> descriptionSupportMaterials [
	<magritteDescription>
	<gtInspectorPresentationOrder: 25>
	
	^ MAToManyRelationDescription new
			accessor: #supportMaterials;
			label: 'Support Materials';
			priority: 650;
			default: OrderedCollection new;
			classes: RlResource allSubclasses;
			glmPresentation: #list;
			yourself
]

{ #category : #magritte }
PpProject >> descriptionSupportMaterialsMOE [
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
		glmPresentation: #list;
		yourself
]

{ #category : #magritte }
PpProject >> descriptionTags [
	<magritteDescription>
	^ MAMultipleOptionDescription new
		accessor: #tags;
		label: 'Tags';
		priority: 250;
		default: Bag new;
		options: PpTag db;
		morphicClass: MATokenCompletionMorph;
		extensible: true;
		initializer: [ :text | PpTag ensureNamed: text ];
		"			readonly;
"
			yourself
]

{ #category : #magritte }
PpProject >> descriptionTitle [
	<magritteDescription>
	^ MAStringDescription new
			accessor: #title;
			label: 'Title';
			priority: 100;
			default: '';
			beRequired;
			yourself
]

{ #category : #printing }
PpProject >> displayString [

	^ String streamContents: [ :str |
			title ifNotNil: [ str nextPutAll: self title ].
			dueDate ifNotNil: [
				str
					nextPutAll: ' (Due ';
					nextPutAll: self dueDate mmddyyyy;
					nextPut: $) ] ]
]

{ #category : #accessing }
PpProject >> dueDate [
	^ dueDate
]

{ #category : #accessing }
PpProject >> dueDate: anObject [
	dueDate := anObject
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
	completionTimestamp := aBoolean ppAsCompletionTimestamp
]

{ #category : #accessing }
PpProject >> links [
	^ links ifNil: [ links := OrderedCollection new ]
]

{ #category : #accessing }
PpProject >> links: anObject [
	links := anObject
]

{ #category : #accessing }
PpProject >> note [
	^ note
]

{ #category : #accessing }
PpProject >> note: anObject [
	note := anObject
]

{ #category : #printing }
PpProject >> printOn: aStream [
	aStream nextPutAll: 'Project: '.
	aStream nextPutAll: self displayString
]

{ #category : #status }
PpProject >> status [
	^ status ifNil: [ status := self defaultStatus ]
]

{ #category : #status }
PpProject >> status: aStatus [
	status := aStatus
]

{ #category : #accessing }
PpProject >> supportMaterials [
	^ supportMaterials
]

{ #category : #accessing }
PpProject >> supportMaterials: anObject [
	supportMaterials := anObject
]

{ #category : #accessing }
PpProject >> tags [
	^ tags ifNil: [ tags := Bag new ]
]

{ #category : #accessing }
PpProject >> tags: anObject [
	tags := anObject
]

{ #category : #accessing }
PpProject >> title [
	^ title
]

{ #category : #accessing }
PpProject >> title: anObject [
	title := anObject
]
