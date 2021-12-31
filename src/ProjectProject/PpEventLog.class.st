Class {
	#name : #PpEventLog,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #accessing }
PpEventLog class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
PpEventLog class >> uniqueInstance: anObject [

	uniqueInstance := anObject
]

{ #category : #accessing }
PpEventLog >> events [

	^ events ifNil: [ events := SortedCollection sortUsing: #startDate ascending ]
]

{ #category : #accessing }
PpEventLog >> events: anObject [

	events := anObject
]

{ #category : #accessing }
PpEventLog >> gtGtSpotterEventsOn: aStep [
	"Adapted from GT superclass"
	<gtSearch>
	^ aStep listProcessor
		priority: 5;
		title: 'Events';
		allCandidates: [ self events ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
		itemName:[ :e | e printString ] 
]

{ #category : #accessing }
PpEventLog >> gtSpotterNewEventOn: aStep [
	<gtSearch>
	aStep listProcessor
		title: 'New Event';
		priority: 50;
		itemName: [ :input | 'Create new event: ', input ];
		previewObject: [ :input | PpEvent new title: input; yourself ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := self events anySatisfy: [ :e | 
					e title = context textTrimmed ].
				isExisting ifFalse: [ 
					filter value: context textTrimmed ] ];
		send: [ :input :spotterStep | self events add: (PpEvent new title: input; yourself) ]
]

{ #category : #accessing }
PpEventLog >> gtSpotterProcessorsFor: aSpotterStep [
	
	^ super gtSpotterProcessorsFor: aSpotterStep
]

{ #category : #accessing }
PpEventLog >> gtSpotterProcessorsFora: a [
]

{ #category : #accessing }
PpEventLog >> gtViewEventsOn: aView [
	<gtView>
	^ aView columnedList
		title: 'Events' translated;
		priority: 5;
		items: [ self events ];
		column: 'Date' text: [ :e | e startDate ifNil: [ '' ] ] width: 125;
		column: 'Event' text: [ :e | e printString ];
		actionUpdateButtonTooltip: 'Update'.
]
