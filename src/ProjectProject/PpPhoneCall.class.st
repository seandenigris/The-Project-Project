"
PpPhoneCall new maEdit
"
Class {
	#name : #PpPhoneCall,
	#superclass : #PpEvent,
	#category : #'ProjectProject-Core'
}

{ #category : #examples }
PpPhoneCall class >> example [
	<gtExample>
	^ self examplePointInTime
]

{ #category : #printing }
PpPhoneCall >> printOn: aStream [
	aStream
		nextPutAll: 'Phone call'.
	self participants ifNotNil: [ :people |
		aStream nextPutAll: ' with '.
		people
			do: [ :e | aStream print: e name ]
			separatedBy: [ aStream nextPutAll: ' & ' ] ].
		notes ifNotNil: [ 
			aStream
				nextPutAll: ': '.
			notes
				do: [ :n | aStream nextPutAll: n text asString ]
				separatedBy: [ aStream crlf ] ]
]
