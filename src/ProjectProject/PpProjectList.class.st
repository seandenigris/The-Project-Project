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
			| multiStep |
			multiStep := PpProject exampleComplete.
			pl
				addChild: multiStep;
				addChild: PpProject exampleIncomplete to: multiStep;
				addChild: PpProject exampleIncomplete.
			pl ]
		then: [ :pl | 
			pl rootChildren should haveSize: 2.
			pl allChildren should haveSize: 3 ]
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

{ #category : #importing }
PpProjectList class >> importAppleNotesFromClipboard [
	"Captures lists from Apple notes of the form:
		- do something
		- [ ] do something else
		
	The second item is how Apple notes export todo items (rendered as circular checkbox in the app)"

	| lineParser lines |
	lineParser := '- ' asPParser, '[ ] ' asPParser optional, #any asPParser plus flatten ==> #third.
	lines := Clipboard clipboardText asString lines collect: [ :e | lineParser parse: e ].
	lines do: [ :e | self uniqueInstance addChild: (PpProject titled: e) ]
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
	aPpProject masterList: self.
	^ self allChildren add: aPpProject
]

{ #category : #accessing }
PpProjectList >> addChild: aProject to: parentProject [
	| link |
	link := PpProjectDependency 
		project: parentProject 
		dependsOn: aProject
		in: self.
	self dependencyLinks add: link.
	^ self addChild: aProject
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
PpProjectList >> allChildren [
	^ children ifNil: [ children := Set new ]
]

{ #category : #accessing }
PpProjectList >> childrenDescription [
	
	^ super childrenDescription
		default: Set new;
		yourself
]

{ #category : #accessing }
PpProjectList >> dependencyLinks [
	^ dependencyLinks ifNil: [ dependencyLinks := Set new ]
]

{ #category : #accessing }
PpProjectList >> masterList [
	^ self
]

{ #category : #magritte }
PpProjectList >> mementoClass [
	^ MAStraightMemento
]
