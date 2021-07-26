Class {
	#name : #PpProjectList,
	#superclass : #Object,
	#instVars : [
		'projects'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #UI }
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
		andShow: [ :a :b | b descriptionNeverDoing glmPresentation value: a value: nil value: b ].
	(browser transmit)
		to: #two;
		from: #one;
		andShow: [ :a :b | b gtInspectorMagritteIn: a ].
	(browser transmit)
		to: #three;
		from: #one;
		andShow: [ :a :b | b descriptionLinks glmPresentation value: a value: nil value: b ].
	browser openOn: projects.
]

{ #category : #'world menu' }
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

{ #category : #UI }
PpProjectList class >> openBrowser [
	<script>
	
	PpProjectBrowser openOn: self uniqueInstance
]

{ #category : #persistence }
PpProjectList class >> restoreFrom: anObject [

	uniqueInstance := anObject.
]

{ #category : #persistence }
PpProjectList class >> spData [
	^ self uniqueInstance
]

{ #category : #accessing }
PpProjectList class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
PpProjectList class >> uniqueInstance: anObject [
	uniqueInstance := anObject
]

{ #category : #accessing }
PpProjectList >> activeProjects [
	^ self projects reject: [ :e | e isComplete ]
]

{ #category : #UI }
PpProjectList >> add [
	PpProject new asMagritteMorph
		addButtons;
		addWindow;
		onAnswer: [ :newProject | self projects add: newProject ];
		openInWorld
]

{ #category : #accessing }
PpProjectList >> allProjects [
	| roots children |
	roots := self projects.
	children := (self projects flatCollect: [ :p | p allChildren ]).
	^ (roots, children) asSet
]

{ #category : #accessing }
PpProjectList >> completeProjects [
	^ self projects select: [ :e | e isComplete ]
]

{ #category : #magritte }
PpProjectList >> descriptionActive [
	<gtInspectorPresentationOrder: 8>
	<magritteAltFor: #descriptionProjects>
	
	^ self descriptionFilteredProjects: 'Active Projects' " order: 0.01"
]

{ #category : #magritte }
PpProjectList >> descriptionAdd [
	<magritteActionDescription>
	
	^ MAActionDescription new
			action: #add;
			icon: #add;
			priority: 100;
			isMutator: true;
			yourself
]

{ #category : #magritte }
PpProjectList >> descriptionComplete [
	<gtInspectorPresentationOrder: 8>
	<magritteAltFor: #descriptionProjects>
	
	^ self descriptionFilteredProjects: 'Complete Projects' " order: 8"
]

{ #category : #magritte }
PpProjectList >> descriptionDueToday [
	<gtInspectorPresentationOrder: 2>
	<magritteAltFor: #descriptionProjects>
	
	^ self descriptionFilteredProjects: 'Due Today' " order: 2"
]

{ #category : #magritte }
PpProjectList >> descriptionFilteredProjects: labelString [
	^ MAToManyRelationDescription new
		accessor: labelString asValidSelector asSymbol;
		label: labelString;
		glmPresentation: [ :a | a tree children: [ :proj | proj activeChildren ] ];
		"default: Bag new;"
			beReadOnly;
		group: 'Projects';
		yourself
]

{ #category : #magritte }
PpProjectList >> descriptionNeverDoing [
	<gtInspectorPresentationOrder: 6>
	<magritteAltFor: #descriptionProjects>
	
	^ self descriptionFilteredProjects: 'Never Doing' " order: 6"
]

{ #category : #magritte }
PpProjectList >> descriptionNotDoing [
	<gtInspectorPresentationOrder: 4>
	<magritteAltFor: #descriptionProjects>
	<magritteDescription>
	
	^ self descriptionFilteredProjects: 'Not Doing' " order: 4"
]

{ #category : #magritte }
PpProjectList >> descriptionOverdue [
	<gtInspectorPresentationOrder: 1>
	<magritteAltFor: #descriptionProjects>
	<magritteDescription>
	
	^ self descriptionFilteredProjects: 'Overdue' " order: 1"
]

{ #category : #magritte }
PpProjectList >> descriptionProjects [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
			accessor: #projects;
			label: 'Projects';
			priority: 100;
			default: Bag new;
			classes: { PpProject };
			yourself
]

{ #category : #accessing }
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

{ #category : #accessing }
PpProjectList >> dueToday [
	^ self dueBy: Date today
]

{ #category : #magritte }
PpProjectList >> mementoClass [
	^ MAStraightMemento
]

{ #category : #accessing }
PpProjectList >> neverDoing [
	^ self activeProjects select: [ :e | e status = PpProject neverDoingStatus ]
]

{ #category : #accessing }
PpProjectList >> notDoing [
	^ self activeProjects select: [ :e | e status = PpProject notDoingStatus ]
]

{ #category : #accessing }
PpProjectList >> overdue [
	^ self dueBy: Date yesterday
]

{ #category : #accessing }
PpProjectList >> projects [
	^ projects ifNil: [ projects := OrderedCollection new ]
]

{ #category : #private }
PpProjectList >> projects: anObject [
	projects := anObject
]
