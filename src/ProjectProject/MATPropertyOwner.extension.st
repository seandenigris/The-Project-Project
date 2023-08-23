Extension { #name : #MATPropertyOwner }

{ #category : #'*ProjectProject' }
MATPropertyOwner >> ppTimelineStamp [

	^ self
		propertyAt: #ppTimelineStamp
		ifPresent: [ :aValuable | aValuable valueWithArguments: { self } ]
		ifAbsent: [ nil ]
]

{ #category : #'*ProjectProject' }
MATPropertyOwner >> ppTimelineStamp: aValuable [
	"aValuable - aDateAndTime or returns one" 

	^ self
		propertyAt: #ppTimelineStamp
		put: aValuable
]
