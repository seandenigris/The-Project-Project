Class {
	#name : #PpProjectListElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'filterModel',
		'listElement',
		'model'
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
PpProjectListElement >> buildFilterModel [

	| toggleModel |
	toggleModel := GtFilterShortListModel new.
	toggleModel name: 'Completion'.
	toggleModel
		items: {'Incomplete'.
				'All'.
				'Complete'};
		selectFirstItem.

	^ GtFilterItemsModel new items: { toggleModel }	"{GtSmaCCVariableFilter availableFilters first{;
		availableFiltersBuilder: GtSmaCCVariableFilter"
]

{ #category : #'as yet unclassified' }
PpProjectListElement >> filterElement [
	filterModel
		ifNil: [ 
			filterModel := self buildFilterModel.
			filterModel weak
				when: GtFiltersModelAnnouncement
				send: #updateFilters
				to: self ].
	^ filterModel asFiltersElement
]

{ #category : #'as yet unclassified' }
PpProjectListElement >> listElement [

	listElement ifNotNil: [ ^ listElement ].

	^ listElement := (self model gtViewProjectsFor: GtPhlowView empty) asElement
		padding:
			(BlInsets
				top: 10
				left: 0
				bottom: 0
				right: 0);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
]

{ #category : #accessing }
PpProjectListElement >> model [
	^ model
]

{ #category : #accessing }
PpProjectListElement >> model: anObject [
	model := anObject.
]

{ #category : #'as yet unclassified' }
PpProjectListElement >> updateFilters [

	self listElement text: (filterModel items atRandom selectedItem string, ' on ', DateAndTime now printString) asRopedText
]
