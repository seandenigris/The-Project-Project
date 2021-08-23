Class {
	#name : 'PpProjectList',
	#superclass : 'Object',
	#instVars : [
		'projects'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'ProjectProject-Core'
}

{ #category : 'examples' }
PpProjectList class >> example [
	<gtExample>
	^ self
		given: [ self new ]
		when: [ :pl |
			pl projects
				add: PpProject exampleComplete;
				add: PpProject exampleIncomplete.
			pl ]
		then: [ :pl | pl projects should haveSize: 2 ]
]

{ #category : 'UI' }
PpProjectList class >> exampleBrowser [
	| projects browser |
	projects := self uniqueInstance.
	browser := GLMTabulator new.
	browser
		column: #one;
		column: #two;
		column: #three.
	(browser transmit)
		to: #one;
		andShow: [ :a :b | b neverDoingDescription glmPresentation value: a value: nil value: b ].
	(browser transmit)
		to: #two;
		from: #one;
		andShow: [ :a :b | b gtInspectorMagritteIn: a ].
	(browser transmit)
		to: #three;
		from: #one;
		andShow: [ :a :b | b linksDescription glmPresentation value: a value: nil value: b ].
	browser openOn: projects.
]

{ #category : 'world menu' }
PpProjectList class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Projects)
		order: 0.25;
		with: [ (aBuilder item: #'Projects Browse')
				order: 1;
				action: [ self openBrowser ];
				icon:
					(self iconNamed: #toolsIcon).
			(aBuilder item: #'Projects Inspect')
				order: 2;
				action: [ self uniqueInstance inspect ];
				icon:
					(self iconNamed: #toolsIcon) ]
]

{ #category : 'UI' }
PpProjectList class >> openBrowser [
	<script>
	
	PpProjectBrowser openOn: self uniqueInstance
]

{ #category : 'persistence' }
PpProjectList class >> restoreFrom: anObject [

	uniqueInstance := anObject.
]

{ #category : 'persistence' }
PpProjectList class >> spData [
	^ self uniqueInstance
]

{ #category : 'accessing' }
PpProjectList class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'accessing' }
PpProjectList class >> uniqueInstance: anObject [
	uniqueInstance := anObject
]

{ #category : 'magritte' }
PpProjectList >> activeDescription [
	<gtInspectorPresentationOrder: 8>
	<magritteAltFor: #projectsDescription>
	
	^ self filteredProjectsDescription: 'Active Projects' " order: 0.01"
]

{ #category : 'accessing' }
PpProjectList >> activeProjects [
	^ self projects reject: [ :e | e isComplete ]
]

{ #category : 'UI' }
PpProjectList >> add [
	PpProject new asMagritteMorph
		addButtons;
		addWindow;
		onAnswer: [ :newProject | self projects add: newProject ];
		openInWorld
]

{ #category : 'magritte' }
PpProjectList >> addDescription [
	<magritteActionDescription>
	
	^ MAActionDescription new
			action: #add;
			icon: #add;
			priority: 100;
			isMutator: true;
			yourself
]

{ #category : 'accessing' }
PpProjectList >> allProjects [
	| roots children |
	roots := self projects.
	children := (self projects flatCollect: [ :p | p allChildren ]).
	^ (roots, children) asSet
]

{ #category : 'magritte' }
PpProjectList >> completeDescription [
	<gtInspectorPresentationOrder: 8>
	<magritteAltFor: #projectsDescription>
	
	^ self filteredProjectsDescription: 'Complete Projects' " order: 8"
]

{ #category : 'accessing' }
PpProjectList >> completeProjects [
	^ self projects select: [ :e | e isComplete ]
]

{ #category : 'accessing' }
PpProjectList >> dueBy: aDate [
	"Recursive through steps"
	^ self activeProjects
		inject: OrderedCollection new
		into: [ :result :root |
			root allProjectsDo: [ :e |
				(e isActiveDueBy: aDate)
					ifTrue: [ result add: e ] ].
			result ]
]

{ #category : 'accessing' }
PpProjectList >> dueToday [
	^ self dueBy: Date today
]

{ #category : 'magritte' }
PpProjectList >> dueTodayDescription [
	<gtInspectorPresentationOrder: 2>
	<magritteAltFor: #projectsDescription>
	
	^ self filteredProjectsDescription: 'Due Today' " order: 2"
]

{ #category : 'magritte' }
PpProjectList >> filteredProjectsDescription: labelString [
	^ MAToManyRelationDescription new
		accessor: labelString asValidSelector asSymbol;
		label: labelString;
		glmPresentation: [ :a | a tree children: [ :proj | proj activeChildren ] ];
		"default: Bag new;"
			beReadOnly;
		group: 'Projects';
		yourself
]

{ #category : 'spotter' }
PpProjectList >> gtGtSpotterFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 5;
		title: 'Projects (Roots)';
		allCandidates: [ self projects ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
		itemName: #title
]

{ #category : 'accessing' }
PpProjectList >> gtViewOn: aView [

	<gtView>
	| tabs |
	self flag: 'At first, we filtered out empty lists (i.e. returned empty views, but it had the side effect of caching the item list, which prevented refreshing; not sure whether empty tabs should be hidden anway'.
	tabs := (self magritteAllDescriptionsFor: #projectsDescription) collect: [ :desc | 
		aView columnedTree
			title: desc label translated;
			priority: 25;
			items: [ desc read: self ];
			"itemText: [ :p | p displayText asRopedText ]; doesn't work - don't know how to convert Pharo text to GT"
			children: #children;
			column: 'Item' item: [ :p | p title ];
			column: 'Due Date' item: [ :p | p dueDateDescription readToString: p ];
			actionUpdateButtonTooltip: 'Update' ].
		
	^ aView composite
		  title: 'Projects' translated;
		  views: tabs
]

{ #category : 'magritte' }
PpProjectList >> mementoClass [
	^ MAStraightMemento
]

{ #category : 'accessing' }
PpProjectList >> neverDoing [
	^ self activeProjects select: [ :e | e status = PpProject neverDoingStatus ]
]

{ #category : 'magritte' }
PpProjectList >> neverDoingDescription [
	<gtInspectorPresentationOrder: 6>
	<magritteAltFor: #projectsDescription>
	
	^ self filteredProjectsDescription: 'Never Doing' " order: 6"
]

{ #category : 'accessing' }
PpProjectList >> notDoing [
	^ self activeProjects select: [ :e | e status = PpProject notDoingStatus ]
]

{ #category : 'magritte' }
PpProjectList >> notDoingDescription [
	<gtInspectorPresentationOrder: 4>
	<magritteAltFor: #projectsDescription>
	<magritteDescription>
	
	^ self filteredProjectsDescription: 'Not Doing' " order: 4"
]

{ #category : 'accessing' }
PpProjectList >> overdue [
	^ self dueBy: Date yesterday
]

{ #category : 'magritte' }
PpProjectList >> overdueDescription [
	<gtInspectorPresentationOrder: 1>
	<magritteAltFor: #projectsDescription>
	<magritteDescription>
	
	^ self filteredProjectsDescription: 'Overdue' " order: 1"
]

{ #category : 'accessing' }
PpProjectList >> projects [
	^ projects ifNil: [ projects := OrderedCollection new ]
]

{ #category : 'private' }
PpProjectList >> projects: anObject [
	projects := anObject
]

{ #category : 'magritte' }
PpProjectList >> projectsDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
			accessor: #projects;
			label: 'Projects (roots)';
			priority: 100;
			default: Bag new;
			classes: { PpProject };
			yourself
]
