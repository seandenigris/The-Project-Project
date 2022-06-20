"
How do we know our current location?

One way ([via howtogeek](https://www.howtogeek.com/252070/how-do-you-find-a-computers-geographic-location-using-the-command-line/)) is: `curl ipinfo.io`, which gives a general location based on IP address.
"
Class {
	#name : #PpLocationRequirement,
	#superclass : #Object,
	#category : #'ProjectProject-Core'
}

{ #category : #accessing }
PpLocationRequirement >> isSatisfied [
	| currentLocation loc distance tolerance |
	currentLocation := '/Applications/Utilities/CoreLocationCLI' asSuCommand
		outputDecoder: [ :str | 
			PpGeoLocation fromCoreLocationCLIOutput: str ];
		output.
		
	loc := PpLocation allInstances detect: [ :e | e name = 'home' ].
	distance := loc distanceFrom: currentLocation.
	tolerance := 200. "feet"
	^ distance < tolerance
]
