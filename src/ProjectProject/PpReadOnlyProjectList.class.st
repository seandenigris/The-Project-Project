Class {
	#name : #PpReadOnlyProjectList,
	#superclass : #PpAbstractProjectContainer,
	#instVars : [
		'links'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpReadOnlyProjectList >> allChildren [
	^ self children
]

{ #category : #accessing }
PpReadOnlyProjectList >> asOrderedCollection [
	^ self rootChildren
]

{ #category : #accessing }
PpReadOnlyProjectList >> childrenLabel [
	^ 'Projects'
]

{ #category : #accessing }
PpReadOnlyProjectList >> dueBy: aDate [
	"Recursive through steps"
	^ self newFromProjectsBlock: [ 
		self activeChildrenList children
			inject: Bag new
			into: [ :result :root |
				root allChildrenDo: [ :e |
					(e isActiveDueBy: aDate)
						ifTrue: [ result add: e ] ].
				result ] ]
]

{ #category : #accessing }
PpReadOnlyProjectList >> dueToday [
	^ self dueBy: Date today
]

{ #category : #magritte }
PpReadOnlyProjectList >> dueTodayDescription [
	<gtInspectorPresentationOrder: 2>
	<magritteAltFor: #projectsDescription>
	
	^ self filteredProjectsDescription: #dueToday
]

{ #category : #spotter }
PpReadOnlyProjectList >> gtGtSpotterAllProjectsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 5;
		title: 'Projects';
		allCandidates: [ self allChildrenList projects ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
		itemName: [ :e | e title ] 
]

{ #category : #magritte }
PpReadOnlyProjectList >> gtMagritteFor: aView [
	"Suppress GT4Magritte's form view"
	^ aView empty
]

{ #category : #'gt-views' }
PpReadOnlyProjectList >> gtViewNextActionsFor: aView [

	<gtView>
	^ aView columnedTree
		title: 'Next Actions' translated;
		priority: 15;
		items: [ self nextActionsList projects ];
		"itemText: [ :p | p displayText asRopedText ]; doesn't work - don't know how to convert Pharo text to GT"
			children: #children;
			column: 'Item' text: [ :p | p title ];
			column: 'Due Date' text: [ :p | p dueDateDescription readToString: p ];
			actionUpdateButtonTooltip: 'Update'.
]

{ #category : #accessing }
PpReadOnlyProjectList >> links [

	^ links ifNil: [ links := Set new ]
]

{ #category : #accessing }
PpReadOnlyProjectList >> links: aSet [

	links := aSet
]

{ #category : #magritte }
PpReadOnlyProjectList >> maGtFormFor: aView [
	"Deprioritize this view because it is not very useful and super slow"
	
	^ (super maGtFormFor: aView)
		priority: 190
]

{ #category : #accessing }
PpReadOnlyProjectList >> neverDoing [
	^ self newFromProjectsBlock: [ self activeChildrenList projects select: [ :e | e status = PpProject neverDoingStatus ] ]
]

{ #category : #magritte }
PpReadOnlyProjectList >> neverDoingDescription [
	<gtInspectorPresentationOrder: 6>
	<magritteAltFor: #projectsDescription>
	
	^ self filteredProjectsDescription: #neverDoing
]

{ #category : #accessing }
PpReadOnlyProjectList >> nextActionsList [
	^ self newFromProjectsBlock: [ 
		| roots children |
		roots := self projects.
		children := (self projects flatCollect: [ :p | p allChildren ]).
		(roots, children) asSet ]
]

{ #category : #accessing }
PpReadOnlyProjectList >> notDoing [
	^ self newFromProjectsBlock: [ self activeChildrenList projects select: [ :e | e status = PpProject notDoingStatus ] ]
]

{ #category : #magritte }
PpReadOnlyProjectList >> notDoingDescription [
	<gtInspectorPresentationOrder: 4>
	<magritteAltFor: #projectsDescription>
	<magritteDescription>
	
	^ self filteredProjectsDescription: #notDoing
]

{ #category : #accessing }
PpReadOnlyProjectList >> overdue [
	^ self dueBy: Date yesterday
]

{ #category : #magritte }
PpReadOnlyProjectList >> overdueDescription [
	<gtInspectorPresentationOrder: 1>
	<magritteAltFor: #projectsDescription>
	<magritteDescription>
	
	^ self filteredProjectsDescription: #overdue
]

{ #category : #accessing }
PpReadOnlyProjectList >> projects [
	^ self children
]

{ #category : #private }
PpReadOnlyProjectList >> projects: aCollection [
	self children: aCollection
]

{ #category : #magritte }
PpReadOnlyProjectList >> projectsDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
			accessor: #projects;
			label: 'Projects (roots)';
			priority: 100;
			default: Bag new;
			classes: { PpProject };
			yourself
]

{ #category : #accessing }
PpReadOnlyProjectList >> rootChildren [
	| dependencies |
	dependencies := self links collect: #dependency.
	^ self children difference: dependencies
]
