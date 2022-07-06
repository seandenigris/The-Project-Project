"
How do we know our current location?

One way ([via howtogeek](https://www.howtogeek.com/252070/how-do-you-find-a-computers-geographic-location-using-the-command-line/)) is: `curl ipinfo.io`, which gives a general location based on IP address.
"
Class {
	#name : #PpLocationRequirement,
	#superclass : #Object,
	#instVars : [
		'location'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpLocationRequirement >> isSatisfied [
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
PpLocationRequirement >> location [

	^ location
]

{ #category : #accessing }
PpLocationRequirement >> location: anObject [

	location := anObject
]

{ #category : #accessing }
PpLocationRequirement >> locationDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
			accessor: #location;
			priority: 650;
			classes: { PpLocation };
			gtSearchSource: (MessageSend receiver: self selector: #locationOptions);
			yourself
]

{ #category : #accessing }
PpLocationRequirement >> locationOptions [
	^ PpLocationList uniqueInstance
]

{ #category : #accessing }
PpLocationRequirement >> printOn: aStream [

	aStream
		nextPut: $@;
		print: self location;
		nextPutAll: ' requirement'
]
