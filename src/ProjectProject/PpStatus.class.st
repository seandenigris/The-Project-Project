Class {
	#name : #PpStatus,
	#superclass : #Object,
	#instVars : [
		'timestamp'
	],
	#classInstVars : [
		'label'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpStatus class >> label [
	^ label ifNil: [ 
		| labelFromName |
		labelFromName := self name copyFrom: 3 to: self name size - 'Status' size.
		labelFromName normalizeCamelCase ]
]

{ #category : #accessing }
PpStatus class >> label: aString [
	label := aString
]

{ #category : #comparing }
PpStatus >> = rhs [

	^ self class = rhs class and: [ self timestamp = rhs timestamp ]
]

{ #category : #comparing }
PpStatus >> hash [

	^ self class hash bitXor: self timestamp hash
]

{ #category : #testing }
PpStatus >> isActive [
	^ false
]

{ #category : #testing }
PpStatus >> isComplete [
	^ false
]

{ #category : #testing }
PpStatus >> isInactive [
	^ false
]

{ #category : #testing }
PpStatus >> isInbox [
	^ false
]

{ #category : #accessing }
PpStatus >> printOn: aStream [
	
	aStream
		nextPutAll: self class label;
		space;
		nextPutAll: 'Status'
]

{ #category : #accessing }
PpStatus >> timestamp [

	^ timestamp
]

{ #category : #accessing }
PpStatus >> timestamp: aDateAndTime [

	"Translate to UTC because Pharo's Date offset support is fatally broken. See [Pharo Issue 12147: Date>>#= fooled by daylight savings time](https://pharo.fogbugz.com/default.asp?12147)"
	timestamp := aDateAndTime translateToUTC
]
