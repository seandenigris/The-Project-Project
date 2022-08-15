Class {
	#name : #PpStatus,
	#superclass : #Object,
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
	^ self class = rhs class
]

{ #category : #comparing }
PpStatus >> hash [
	^ self class hash
]

{ #category : #accessing }
PpStatus >> printOn: aStream [
	
	aStream
		nextPutAll: self class label;
		space;
		nextPutAll: 'Status'
]
