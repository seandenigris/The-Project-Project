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
	^ label ifNil: [ self name copyFrom: 3 to: self name size - 'Status' size ]
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
PpStatus >> timestamp: anObject [

	timestamp := anObject
]
