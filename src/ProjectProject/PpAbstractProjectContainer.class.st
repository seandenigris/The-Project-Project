Class {
	#name : #PpAbstractProjectContainer,
	#superclass : #Object,
	#instVars : [
		'children'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpAbstractProjectContainer >> activeChildrenList [
	^ self newFromProjectsBlock: [ self rootChildren reject: [ :e | e isComplete ] ]
]

{ #category : #magritte }
PpAbstractProjectContainer >> activeDescription [
	<magritteAltFor: #projectsDescription>
	
	^ self filteredProjectsDescription: #activeChildrenList
]

{ #category : #accessing }
PpAbstractProjectContainer >> allChildren [
	self subclassResponsibility
]

{ #category : #enumeration }
PpAbstractProjectContainer >> allChildrenDo: aBlock [
	aBlock value: self.
	self children do: [ :child | child allChildrenDo: aBlock ]
]

{ #category : #accessing }
PpAbstractProjectContainer >> allChildrenList [
	^ self newFromProjectsBlock: [ self allChildren ]
]

{ #category : #'project compatibility' }
PpAbstractProjectContainer >> children [
	^ children ifNil: [ children := OrderedCollection new ]
]

{ #category : #accessing }
PpAbstractProjectContainer >> children: aCollection [
	children := aCollection
]

{ #category : #magritte }
PpAbstractProjectContainer >> childrenDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
		accessor: #children;
		label: 'All Projects';
		priority: 100;
		default: Bag new;
		classes: PpProject allSubclasses;
		gtSearchSource: (MessageSend receiver: PpProjectList selector: #uniqueInstance);
		morphicClass: MAMorphicTokenCompletion;
		initializer: [ :s | 
			PpProject new
				title: s;
				yourself ];
		yourself
]

{ #category : #accessing }
PpAbstractProjectContainer >> childrenLabel [
	self subclassResponsibility
]

{ #category : #accessing }
PpAbstractProjectContainer >> completeChildrenList [
	^ self newFromProjectsBlock: [ self rootChildren select: [ :e | e isComplete ] ]
]

{ #category : #magritte }
PpAbstractProjectContainer >> completeDescription [
	<gtInspectorPresentationOrder: 8>
	<magritteAltFor: #childrenDescription>
	
	^ self filteredProjectsDescription: #completeChildrenList
]

{ #category : #magritte }
PpAbstractProjectContainer >> filteredProjectsDescription: aSelector [
	| label |
	label := aSelector normalizeCamelCase capitalized.
	(aSelector endsWith: 'List') ifTrue: [ label:= label allButLast: ' List' size ].
	^ MAToOneRelationDescription new
		accessor: aSelector;
		label: label;
		gtView: [ :aView :desc :me |
			aView tree
				priority: 8;
				items: [ (desc read: me) children ];
				children: [ :proj | proj activeChildren ] ];
		"default: Bag new;"
		classes: PpReadOnlyProjectList;
		beReadOnly;
		group: 'Projects';
		yourself
]

{ #category : #'gt-views' }
PpAbstractProjectContainer >> gtViewProjectsFor: aView [

	<gtView>
	| tabs |
	self flag: 'At first, we filtered out empty lists (i.e. returned empty views, but it had the side effect of caching the item list, which prevented refreshing; not sure whether empty tabs should be hidden anway'.
	tabs := (self magritteAllDescriptionsFor: #childrenDescription) collect: [ :desc | 
		aView columnedTree
			title: desc label translated;
			priority: 25;
			items: [ (desc read: self) asOrderedCollection ];
			children: #children;
			column: 'Item' text: [ :p | p gtDisplayText ];
			column: 'Due Date' text: [ :p | p dueDateDescription readToString: p ];
			actionUpdateButtonTooltip: 'Update' ].
		
	^ aView composite
		  title: self childrenLabel translated;
		  views: tabs
]

{ #category : #private }
PpAbstractProjectContainer >> newFromProjectsBlock: aBlock [
	^ PpReadOnlyProjectList new
		projects: aBlock value asArray;
		yourself
]

{ #category : #accessing }
PpAbstractProjectContainer >> rootChildren [
	self subclassResponsibility
]

{ #category : #accessing }
PpAbstractProjectContainer >> rooteChildren [
	self subclassResponsibility
]
