Class {
	#name : #PpAbstractProjectContainer,
	#superclass : #Object,
	#instVars : [
		'masterList'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpAbstractProjectContainer >> activeChildrenList [
	^ self newFromChildrenBlock: [ self rootChildren reject: [ :e | e isComplete ] ]
]

{ #category : #magritte }
PpAbstractProjectContainer >> activeDescription [
	"<magritteAltFor: #childrenDescription>"
	
	^ self filteredProjectsDescription: #activeChildrenList
]

{ #category : #accessing }
PpAbstractProjectContainer >> agendaFor: anMpPerson [
	^ self newFromChildrenBlock: [ 
		self allChildren select: [ :e | 
			e isComplete not and: [ e stakeholders anySatisfy: [ :holder |
				holder person == anMpPerson ] ] ] ]
]

{ #category : #accessing }
PpAbstractProjectContainer >> allChildren [
	self subclassResponsibility
]

{ #category : #enumeration }
PpAbstractProjectContainer >> allChildrenDo: aBlock [
	aBlock value: self.
	self rootChildren do: [ :child | child allChildrenDo: aBlock ]
]

{ #category : #spotter }
PpAbstractProjectContainer >> allChildrenGtSpotterFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 5;
		title: 'Projects';
		items: [ self masterList allChildren ];
		matchSubstrings;
		itemName: #gtDisplayText
]

{ #category : #accessing }
PpAbstractProjectContainer >> allChildrenList [
	^ self newFromChildrenBlock: [ self allChildren ]
]

{ #category : #magritte }
PpAbstractProjectContainer >> childrenDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
		accessor: #rootChildren;
		beReadOnly;
		label: 'Children';
		priority: 100;
		classes: PpProject withAllSubclasses;
		gtSearchSource: (MessageSend receiver: self selector: #masterList);
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
	^ self newFromChildrenBlock: [ self rootChildren select: [ :e | e isComplete ] ]
]

{ #category : #magritte }
PpAbstractProjectContainer >> completeDescription [
	"<magritteAltFor: #childrenDescription>"
	
	^ self filteredProjectsDescription: #completeChildrenList
]

{ #category : #accessing }
PpAbstractProjectContainer >> dependencyLinks [
	^ self masterList 
		ifNil: [ #() ]
		ifNotNil: [ :ml | ml dependencyLinks ]
]

{ #category : #accessing }
PpAbstractProjectContainer >> dueBy: aDate [
	self subclassResponsibility
]

{ #category : #accessing }
PpAbstractProjectContainer >> dueToday [
	^ self dueBy: Date today
]

{ #category : #magritte }
PpAbstractProjectContainer >> dueTodayDescription [
	"<magritteAltFor: #childrenDescription>"
	
	^ self filteredProjectsDescription: #dueToday
]

{ #category : #magritte }
PpAbstractProjectContainer >> filteredProjectsDescription: aSelector [
	| label |
	label := aSelector normalizeCamelCase capitalized.
	(aSelector endsWith: 'List') ifTrue: [ 
		| suffixLength |
		suffixLength := ' List' size.
		(label includesSubstring: 'Children') ifTrue: [ suffixLength := suffixLength + ' Children' size ].
		label := label allButLast: suffixLength ].
	^ MAToOneRelationDescription new
		accessor: aSelector;
		label: label;
		"default: Bag new;"
		classes: PpProjectsSnapshot;
		beReadOnly;
		group: 'Projects';
		yourself
]

{ #category : #'gt-views' }
PpAbstractProjectContainer >> gtViewNextActionsFor: aView [
	<gtView>
	
	| tabs |
	tabs := { 
		aView columnedTree
			title: 'All' translated;
			priority: 10;
			items: [ self nextActionsList allChildren ];
			children: #rootChildren;
			column: 'Item' text: #gtDisplayText;
			column: 'Parents' text: [ :p | p parents displayString ];
			actionUpdateButtonTooltip: 'Update'.
		
		aView columnedTree
			title: '@Phone' translated;
			priority: 20;
			items: [ self nextActionsList allChildren select: [ :e |
				(e isKindOf: PpContactAction) and: [ e strategy isKindOf: PpCallOnPhone ] ] ];
			children: #rootChildren;
			column: 'Item' text: #gtDisplayText;
			column: 'Parents' text: [ :p | p parents displayString ];
			actionUpdateButtonTooltip: 'Update'.
			
		aView columnedTree
			title: '@Email' translated;
			priority: 20;
			items: [ self nextActionsList allChildren select: [ :e |
				(e isKindOf: PpContactAction) and: [ e strategy isKindOf: PpSendEmail ] ] ];
			children: #rootChildren;
			column: 'Item' text: #gtDisplayText;
			column: 'Parents' text: [ :p | p parents displayString ];
			actionUpdateButtonTooltip: 'Update' }.
		
	^ aView composite
		title: 'Next Actions' translated;
		priority: 10;
		views: tabs
]

{ #category : #'gt-views' }
PpAbstractProjectContainer >> gtViewProjectsFor: aView [

	<gtView>
	| tabs |
	self flag: 'At first, we filtered out empty lists (i.e. returned empty views, but it had the side effect of caching the item list, which prevented refreshing; not sure whether empty tabs should be hidden anway'.
	tabs := (self magritteAllDescriptionsFor: #childrenDescription) collect: [ :desc | 
		aView columnedTree
			title: desc label translated;
			items: [ (desc read: self) asOrderedCollection ];
			children: #rootChildren;
			column: 'Item' text: [ :p | p gtDisplayText ] weight: 3;
			column: 'Due Date' text: [ :p | p dueDateDescription readToString: p ]  weight: 1;
			itemContextMenuStencil: [ :element :item | 
				BrGlamorousSimpleContextMenuContent new
					items: {'Revert'
								-> [ :e | element phlow fireUpdateWish ].
							'Checkout'
								-> [ :e | element phlow fireUpdateWish ]};
					yourself ];
			actionUpdateButtonTooltip: 'Update' ].
		
	^ aView composite
		  title: self childrenLabel translated;
		  priority: 20;
		  views: tabs
]

{ #category : #accessing }
PpAbstractProjectContainer >> masterList [

	^ masterList
]

{ #category : #accessing }
PpAbstractProjectContainer >> masterList: anObject [

	masterList := anObject
]

{ #category : #accessing }
PpAbstractProjectContainer >> neverDoing [
	^ self newFromChildrenBlock: [ self activeChildrenList allChildren select: [ :e | e status = PpProject inactiveStatus ] ]
]

{ #category : #magritte }
PpAbstractProjectContainer >> neverDoingDescription [
	"<magritteAltFor: #childrenDescription>"
	
	^ self filteredProjectsDescription: #neverDoing
]

{ #category : #private }
PpAbstractProjectContainer >> newFromChildrenBlock: aBlock [
	^ PpProjectsSnapshot new
		allChildren: aBlock value asArray;
		masterList: self masterList;
		yourself
]

{ #category : #accessing }
PpAbstractProjectContainer >> nextActionsList [
	^ self newFromChildrenBlock: [ 
		self allChildren select: #isNextAction ]
]

{ #category : #accessing }
PpAbstractProjectContainer >> overdue [
	^ self dueBy: Date yesterday
]

{ #category : #magritte }
PpAbstractProjectContainer >> overdueDescription [
	"<magritteAltFor: #childrenDescription>
	<magritteDescription>"
	
	^ self filteredProjectsDescription: #overdue
]

{ #category : #accessing }
PpAbstractProjectContainer >> rootChildren [
	self subclassResponsibility
]
