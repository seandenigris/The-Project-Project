Class {
	#name : #PpProjectList,
	#superclass : #PpProjectsSnapshot,
	#traits : 'PpTMutableProjectContainer',
	#classTraits : 'PpTMutableProjectContainer classTrait',
	#instVars : [
		'dependencyLinks'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #examples }
PpProjectList class >> example [
	<gtExample>
	^ self
		given: [ self new ]
		when: [ :pl |
			pl
				addChild: PpProject exampleComplete;
				addChild: PpProject exampleIncomplete.
			pl ]
		then: [ :pl | pl allChildren should haveSize: 2 ]
]

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

{ #category : #UI }
PpProjectList >> add [
	PpProject new asMagritteMorph
		addButtons;
		addWindow;
		onAnswer: [ :newProject | self allChildren add: newProject ];
		openInWorld
]

{ #category : #accessing }
PpProjectList >> addChild: aPpProject [
	self rootChildren add: aPpProject
]

{ #category : #accessing }
PpProjectList >> addChild: aProject to: parentProject [
	| link |
	link := PpProjectDependency 
		project: parentProject 
		dependsOn: aProject.
	self dependencyLinks add: link.
	self addChild: aProject
]

{ #category : #magritte }
PpProjectList >> addDescription [
	<magritteActionDescription>
	
	^ MAActionDescription new
			action: #add;
			icon: #add;
			priority: 100;
			isMutator: true;
			yourself
]

{ #category : #accessing }
PpProjectList >> dependencyLinks [
	^ dependencyLinks ifNil: [ dependencyLinks := Bag new ]
]

{ #category : #accessing }
PpProjectList >> gtSpotterNewChildFor: aStep [
	<gtSearch>
	self gtSpotterNewChildIn: self labeled: 'project' for: aStep
]

{ #category : #accessing }
PpProjectList >> masterList [
	^ self
]

{ #category : #magritte }
PpProjectList >> mementoClass [
	^ MAStraightMemento
]
