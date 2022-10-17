Class {
	#name : #PpEventLog,
	#superclass : #PpReadOnlyEventLog,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ProjectProject-Core-Events'
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

{ #category : #removing }
PpEventLog >> add: anEvent [
	^ self events add: anEvent
]

{ #category : #'as yet unclassified' }
PpEventLog >> addAll: aCollection [ 
	^ self events addAll: aCollection
]

{ #category : #accessing }
PpEventLog >> eventsNewSearches [
	
	^ PpEvent withAllSubclasses collect: [ :cls |
		self gtSpotterNew: cls ]
]

{ #category : #accessing }
PpEventLog >> gtSpotterNew: aClass [

	| typeName |
	typeName := (aClass name allButFirst: 'Pp' size) normalizeCamelCase.
	
	^ GtSpotterProtoSearch new explicit
		title: 'New ', typeName;
		priority: 50;
		itemName: [ :result | '+ ', result title ];
		wantsToDisplayOnEmptyQuery: false;
		search: [ :aContext | 
			| input |
			input := aContext searchQuery trimBoth.
			{ aClass fromString: input } asAsyncStream ];
		itemSpawnAfter: [ :anObject | self events add: anObject ]
]

{ #category : #accessing }
PpEventLog >> gtSpotterSearchesInContext: aSpotterContext [
	| pragmaSearches |
	pragmaSearches := super gtSpotterSearchesInContext: aSpotterContext.
	^ pragmaSearches merge: self eventsNewSearches asAsyncStream
]

{ #category : #removing }
PpEventLog >> remove: anEvent [
	^ self events remove: anEvent
]
