Class {
	#name : #PpProjectListElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'filterModel',
		'listElement',
		'model',
		'phlowContext',
		'phlowView'
	],
	#category : #'ProjectProject-UI-Bloc'
}

{ #category : #'as yet unclassified' }
PpProjectListElement >> buildElement [
	self matchParent.
	self
		padding:
			(BlInsets
				top: 0
				left: 10
				bottom: 10
				right: 0).
	self margin: (BlInsets all: 0).
	self filterElement ifNotNil: [ :filter | self addChild: filter as: #filter ].
	self addChild: self listElement.
	"self updateList"
]

{ #category : #'as yet unclassified' }
PpProjectListElement >> filterElement [
	
	^ self filterModel asFiltersElement
]

{ #category : #'as yet unclassified' }
PpProjectListElement >> filterModel [

	| toggleModel |
	
	filterModel ifNotNil: [ ^ filterModel ].
			
	toggleModel := GtFilterShortListModel new.
	toggleModel name: 'Complete?'.
	toggleModel
		items: {
			'Incomplete'.
			'All'.
			'Complete'};
		selectFirstItem.
		
	self phlowContext at: #completionFilter put: false.
		
	filterModel := GtFilterItemsModel new 
		items: { toggleModel }";
		availableFiltersBuilder: GtSmaCCVariableFilter".
		
	filterModel weak
		when: GtFiltersModelAnnouncement
		send: #updateFilters
		to: self.
		
	^ filterModel
]

{ #category : #'as yet unclassified' }
PpProjectListElement >> listElement [
	| filter desc view |
	
	listElement ifNotNil: [ ^ listElement ].

	filter := [ :aCol | 
		| filtered |
		filtered := aCol
				select: [ :proj | proj isComplete = (self phlowContext at: #completionFilter) ].
		filtered sorted: #title ascending ].

	desc := self model childrenDescription.

	view := self phlowView columnedTree
			title: desc label translated;
			items: [ filter value: (desc read: self model) ];
			children: [ :p | filter value: p rootChildren ];
			column: ''
				stencil: [ :proj | 
					BrCheckbox new
						aptitude: BrGlamorousCheckboxAptitude;
						checked: (proj isCompleteDescription read: proj);
						whenCheckedDo: [ proj isCompleteDescription write: true to: proj ];
						whenUncheckedDo: [ proj isCompleteDescription write: false to: proj ] ]
				width: 50;
			column: 'Item'
				text: [ :p | p gtDisplayText ]
				weight: 3;
			column: 'Due Date'
				text: [ :p | p dueDateString ]
				weight: 1;
			actionUpdateButton.

	^ listElement := view asElement
			padding: (BlInsets
					top: 10
					left: 0
					bottom: 0
					right: 0);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ]
]

{ #category : #accessing }
PpProjectListElement >> model [
	^ model
]

{ #category : #accessing }
PpProjectListElement >> model: anObject [
	model := anObject.
]

{ #category : #accessing }
PpProjectListElement >> phlowContext [
	^ phlowContext
]

{ #category : #accessing }
PpProjectListElement >> phlowContext: anObject [
	phlowContext := anObject
]

{ #category : #accessing }
PpProjectListElement >> phlowView [
	^ phlowView
]

{ #category : #accessing }
PpProjectListElement >> phlowView: anObject [
	phlowView := anObject
]

{ #category : #'as yet unclassified' }
PpProjectListElement >> updateFilters [

	self filterModel items atRandom selectedItem string = 'Complete'
		ifTrue: [ self phlowContext at: #completionFilter put: true ].
		
	self filterModel items atRandom selectedItem string = 'Incomplete'
		ifTrue: [ self phlowContext at: #completionFilter put: false ].
		
	self updateList
]

{ #category : #'as yet unclassified' }
PpProjectListElement >> updateList [
	| oldList |
	oldList := self listElement.
	listElement := nil.
	self replaceChild: oldList with: self listElement
]
