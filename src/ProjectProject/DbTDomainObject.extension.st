Extension { #name : #DbTDomainObject }

{ #category : #'*ProjectProject' }
DbTDomainObject >> ppTimelineStamp [

	^ self
		propertyAt: #ppTimelineStamp
		ifPresent: [ :aValuable | aValuable valueWithArguments: { self } ]
		ifAbsent: [ nil ]
]

{ #category : #'*ProjectProject' }
DbTDomainObject >> ppTimelineStamp: aValuable [
	"aValuable - aDateAndTime or returns one" 

	^ self
		propertyAt: #ppTimelineStamp
		put: aValuable
]
