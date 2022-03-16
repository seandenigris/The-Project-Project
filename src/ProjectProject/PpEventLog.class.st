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

{ #category : #examples }
PpEventLog class >> example [
	<gtExample>
	^ self
		given: [ self new ]
		when: [ :result | 
			result events add: PpEvent examplePointInTime.
			result ]
		then: [ :result | result events should haveSize: 1 ]
]

{ #category : #persistence }
PpEventLog class >> restoreFrom: anObject [

	uniqueInstance := anObject.
]

{ #category : #persistence }
PpEventLog class >> spData [

	^ uniqueInstance
]

{ #category : #accessing }
PpEventLog class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
PpEventLog class >> uniqueInstance: anObject [

	uniqueInstance := anObject
]

{ #category : #accessing }
PpEventLog >> allEventsDo: aBlock [

	^ self events do: [ :e | e allEventsDo: aBlock ]
]

{ #category : #accessing }
PpEventLog >> events [

	^ events ifNil: [ events := SortedCollection sortUsing: #startDate ascending undefinedFirst ]
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
		itemName:[ :e | e printString ];
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #accessing }
PpEventLog >> gtSpotterNew: aClass on: aStep [

	| typeName |
	typeName := (aClass name allButFirst: 2) normalizeCamelCase.

	aStep listProcessor
		title: 'New ', typeName;
		priority: 50;
		itemName: [ :input | 'Create new ', typeName asLowercase, ': ', input ];
		previewObject: [ :input | aClass new title: input; yourself ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := self events anySatisfy: [ :e | 
					e title = context textTrimmed ].
				isExisting ifFalse: [ 
					filter value: context textTrimmed ] ];
		send: [ :input :spotterStep | self events add: (aClass new title: input; yourself) ].
]

{ #category : #accessing }
PpEventLog >> gtSpotterNewEventOn: aStep [
	<gtSearch>
	
	PpEvent withAllSubclassesDo: [ :cls |
		self gtSpotterNew: cls on: aStep ]
]

{ #category : #accessing }
PpEventLog >> gtSpotterProcessorsFor: aSpotterStep [
	
	^ super gtSpotterProcessorsFor: aSpotterStep
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
