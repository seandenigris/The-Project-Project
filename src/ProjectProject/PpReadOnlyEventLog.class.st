Class {
	#name : #PpReadOnlyEventLog,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #accessing }
PpReadOnlyEventLog >> allEventsDo: aBlock [

	^ self events do: [ :e | e allEventsDo: aBlock ]
]

{ #category : #accessing }
PpReadOnlyEventLog >> events [

	^ events ifNil: [ events := SortedCollection sortUsing: #startDate ascending undefinedFirst ]
]

{ #category : #accessing }
PpReadOnlyEventLog >> events: anObject [

	events := anObject
]

{ #category : #accessing }
PpReadOnlyEventLog >> gtGtSpotterEventsOn: aStep [
	"Adapted from GT superclass"
	<gtSearch>
	^ aStep listProcessor
		priority: 5;
		title: 'Events';
		allCandidates: [ self events ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
		itemName:[ :e | e printString ];
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #accessing }
PpReadOnlyEventLog >> gtViewEventsOn: aView [
	<gtView>
	^ aView columnedList
		title: 'Events' translated;
		priority: 5;
		items: [ self events ];
		column: 'Date' text: [ :e | e startDate ifNil: [ '' ] ] width: 125;
		column: 'Event' text: [ :e | e displayString ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #accessing }
PpReadOnlyEventLog >> gtViewTimelineOn: aView [
	<gtView>
	^ aView explicit
		title: 'Timeline' translated;
		priority: 10;
		stencil: [ self timeline ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #accessing }
PpReadOnlyEventLog >> select: aBlock [
	| evts |
	evts := self events select: aBlock.
	^ PpReadOnlyEventLog new 
		events: evts; 
		yourself
]