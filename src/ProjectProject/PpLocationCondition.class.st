"
How do we know our current location?

One way ([via howtogeek](https://www.howtogeek.com/252070/how-do-you-find-a-computers-geographic-location-using-the-command-line/)) is: `curl ipinfo.io`, which gives a general location based on IP address.
"
Class {
	#name : #PpLocationCondition,
	#superclass : #PpProjectCondition,
	#instVars : [
		'location'
	],
	#category : #'ProjectProject-Core-Projects-Support'
}

{ #category : #accessing }
PpLocationCondition class >> gtSpotterItemsFromString: aString [

	| bestMatches |
	bestMatches := PpLocationList uniqueInstance allChildren
		sorted: [ :a :b | (a name alike: aString) > (b name alike: aString) ].
	
	bestMatches first = aString ifFalse: [ 
		| loc |
		loc := PpLocation named: aString.
		bestMatches copyWith: loc ].
	
	^ bestMatches collect: [ :loc |
		self new
			location: loc;
			yourself ].
]

{ #category : #accessing }
PpLocationCondition >> isSatisfied [
	| currentLocation distance tolerance |
	currentLocation := '/Applications/Utilities/CoreLocationCLI' asSuCommand
		outputDecoder: [ :str | 
			PpGeoLocation fromCoreLocationCLIOutput: str ];
		output.
		
	distance := self location distanceFrom: currentLocation.
	tolerance := 200. "feet"
	^ distance < tolerance
]

{ #category : #accessing }
PpLocationCondition >> location [

	^ location
]

{ #category : #accessing }
PpLocationCondition >> location: anObject [

	location := anObject
]

{ #category : #accessing }
PpLocationCondition >> locationDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
			accessor: #location;
			priority: 650;
			classes: { PpLocation };
			gtSearchSource: (MessageSend receiver: self selector: #locationOptions);
			yourself
]

{ #category : #accessing }
PpLocationCondition >> locationOptions [
	^ PpLocationList uniqueInstance
]

{ #category : #accessing }
PpLocationCondition >> printOn: aStream [

	aStream
		nextPut: $@;
		print: self location;
		nextPutAll: ' requirement'
]
