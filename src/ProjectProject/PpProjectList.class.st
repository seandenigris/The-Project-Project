Class {
	#name : #PpProjectList,
	#superclass : #PpReadOnlyProjectList,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #examples }
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
		onAnswer: [ :newProject | self projects add: newProject ];
		openInWorld
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
PpProjectList >> gtGtSpotterFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 5;
		title: 'Projects';
		allCandidates: [ self allProjectsList projects ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
		itemName: [ :e | e title ] 
]

{ #category : #accessing }
PpProjectList >> gtSpotterNewProjectFor: aStep [
	<gtSearch>
	aStep listProcessor
		title: 'New Project';
		priority: 50;
		itemName: [ :input | 'Create new project: ', input ];
		previewObject: [ :input | PpProject new title: input; yourself ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := self projects anySatisfy: [ :e | 
					e title = context textTrimmed ].
				isExisting ifFalse: [ 
					filter value: context textTrimmed ] ];
		send: [ :input :spotterStep |
			| result |
			result := PpProject new title: input; yourself.
			self projects add: result  ]
]

{ #category : #magritte }
PpProjectList >> mementoClass [
	^ MAStraightMemento
]
