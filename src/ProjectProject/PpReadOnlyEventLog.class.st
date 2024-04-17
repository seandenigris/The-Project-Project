Class {
	#name : #PpReadOnlyEventLog,
	#superclass : #Object,
	#traits : 'PeTEnumerable',
	#classTraits : 'PeTEnumerable classTrait',
	#instVars : [
		'events'
	],
	#category : #'ProjectProject-Core-Events'
}

{ #category : #accessing }
PpReadOnlyEventLog >> allEventsDo: aBlock [

	^ self events do: [ :e | e allEventsDo: aBlock ]
]

{ #category : #accessing }
PpReadOnlyEventLog >> events [

	^ events ifNil: [ events := SortedCollection sortUsing: #startDate descending undefinedFirst, #startTime descending undefinedFirst ]
]

{ #category : #accessing }
PpReadOnlyEventLog >> events: anObject [

	events := anObject
]

{ #category : #accessing }
PpReadOnlyEventLog >> gtGtSpotterEventsOn: aSearch [
	"Adapted from GT superclass"

	<gtSearch>
	^ aSearch list
		priority: 5;
		title: 'Events';
		items: [ self events ];
		matchSubstrings;
		itemName: [ :e | e printString ];
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
		actionUpdateButton.
]

{ #category : #accessing }
PpReadOnlyEventLog >> gtViewTimelineOn: aView [
	<gtView>
	^ aView explicit
		title: 'Timeline' translated;
		priority: 10;
		stencil: [ self timeline ];
		actionUpdateButton.
]

{ #category : #testing }
PpReadOnlyEventLog >> hasEvent: anEvent [
	^ self events identityIncludes: anEvent
]

{ #category : #accessing }
PpReadOnlyEventLog >> privateEnumerable [

	^ self events
]

{ #category : #accessing }
PpReadOnlyEventLog >> select: aBlock [
	| evts |
	evts := self events select: aBlock.
	^ PpReadOnlyEventLog new 
		events: evts; 
		yourself
]
