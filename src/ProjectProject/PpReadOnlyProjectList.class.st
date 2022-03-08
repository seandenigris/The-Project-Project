Class {
	#name : #PpReadOnlyProjectList,
	#superclass : #Object,
	#instVars : [
		'projects'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #magritte }
PpReadOnlyProjectList >> activeDescription [
	<magritteAltFor: #projectsDescription>
	
	^ self filteredProjectsDescription: 'Active Projects'
]

{ #category : #accessing }
PpReadOnlyProjectList >> activeProjects [
	^ self newFromProjectsBlock: [ self projects reject: [ :e | e isComplete ] ]
]

{ #category : #accessing }
PpReadOnlyProjectList >> allProjects [
	^ self newFromProjectsBlock: [ 
		| roots children |
		roots := self projects.
		children := (self projects flatCollect: [ :p | p allChildren ]).
		(roots, children) asSet ]
]

{ #category : #magritte }
PpReadOnlyProjectList >> completeDescription [
	<gtInspectorPresentationOrder: 8>
	<magritteAltFor: #projectsDescription>
	
	^ self filteredProjectsDescription: 'Complete Projects' " order: 8"
]

{ #category : #accessing }
PpReadOnlyProjectList >> completeProjects [
	^ self newFromProjectsBlock: [ self projects select: [ :e | e isComplete ] ]
]

{ #category : #accessing }
PpReadOnlyProjectList >> dueBy: aDate [
	"Recursive through steps"
	^ self newFromProjectsBlock: [ 
		self activeProjects projects
			inject: OrderedCollection new
			into: [ :result :root |
				root allProjectsDo: [ :e |
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
	
	^ self filteredProjectsDescription: 'Due Today' " order: 2"
]

{ #category : #magritte }
PpReadOnlyProjectList >> filteredProjectsDescription: labelString [
	^ MAToOneRelationDescription new
		accessor: labelString asValidSelector asSymbol;
		label: labelString;
		gtView: [ :aView :desc :me |
			aView tree
				priority: 8;
				items: [ (desc read: me) projects ];
				children: [ :proj | proj activeChildren ] ];
		"default: Bag new;"
		classes: PpReadOnlyProjectList;
		beReadOnly;
		group: 'Projects';
		yourself
]

{ #category : #spotter }
PpReadOnlyProjectList >> gtGtSpotterFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 5;
		title: 'Projects (Roots)';
		allCandidates: [ self projects ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
		itemName: #title
]

{ #category : #accessing }
PpReadOnlyProjectList >> gtMagritteFor: aView [
	^ aView empty
]

{ #category : #accessing }
PpReadOnlyProjectList >> gtViewOn: aView [

	<gtView>
	| tabs |
	self flag: 'At first, we filtered out empty lists (i.e. returned empty views, but it had the side effect of caching the item list, which prevented refreshing; not sure whether empty tabs should be hidden anway'.
	tabs := (self magritteAllDescriptionsFor: #projectsDescription) collect: [ :desc | 
		aView columnedTree
			title: desc label translated;
			priority: 25;
			items: [ (desc read: self) projects ];
			"itemText: [ :p | p displayText asRopedText ]; doesn't work - don't know how to convert Pharo text to GT"
			children: #children;
			column: 'Item' text: [ :p | p title ];
			column: 'Due Date' text: [ :p | p dueDateDescription readToString: p ];
			actionUpdateButtonTooltip: 'Update' ].
		
	^ aView composite
		  title: 'Projects' translated;
		  views: tabs
]

{ #category : #accessing }
PpReadOnlyProjectList >> maGtFormFor: aView [
	"Deprioritize this view because it is not very useful and super slow"
	
	^ (super maGtFormFor: aView)
		priority: 190
]

{ #category : #accessing }
PpReadOnlyProjectList >> neverDoing [
	^ self newFromProjectsBlock: [ self activeProjects projects select: [ :e | e status = PpProject neverDoingStatus ] ]
]

{ #category : #magritte }
PpReadOnlyProjectList >> neverDoingDescription [
	<gtInspectorPresentationOrder: 6>
	<magritteAltFor: #projectsDescription>
	
	^ self filteredProjectsDescription: 'Never Doing' " order: 6"
]

{ #category : #accessing }
PpReadOnlyProjectList >> newFromProjectsBlock: aBlock [
	^ PpReadOnlyProjectList new
		projects: aBlock value;
		yourself
]

{ #category : #accessing }
PpReadOnlyProjectList >> notDoing [
	^ self newFromProjectsBlock: [ self activeProjects projects select: [ :e | e status = PpProject notDoingStatus ] ]
]

{ #category : #magritte }
PpReadOnlyProjectList >> notDoingDescription [
	<gtInspectorPresentationOrder: 4>
	<magritteAltFor: #projectsDescription>
	<magritteDescription>
	
	^ self filteredProjectsDescription: 'Not Doing' " order: 4"
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
	
	^ self filteredProjectsDescription: 'Overdue' " order: 1"
]

{ #category : #accessing }
PpReadOnlyProjectList >> projects [
	^ projects ifNil: [ projects := OrderedCollection new ]
]

{ #category : #private }
PpReadOnlyProjectList >> projects: anObject [
	projects := anObject
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
