Class {
	#name : #PpEventLog,
	#superclass : #PpReadOnlyEventLog,
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
PpEventLog >> gtSpotterNew: aClass on: aStep [

	| typeName |
	typeName := (aClass name allButFirst: 2) normalizeCamelCase.

	aStep listProcessor
		title: 'New ', typeName;
		priority: 50;
		itemName: [ :input | 'Create new ', typeName asLowercase, ': ', input ];
		previewObject: [ :input | aClass fromString: input ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := self events anySatisfy: [ :e | 
					e title = context textTrimmed ].
				isExisting ifFalse: [ 
					filter value: context textTrimmed ] ];
		send: [ :input :spotterStep | self events add: (aClass fromString: input) ].
]

{ #category : #accessing }
PpEventLog >> gtSpotterNewEventOn: aStep [
	<gtSearch>
	
	PpEvent withAllSubclassesDo: [ :cls |
		self gtSpotterNew: cls on: aStep ]
]
