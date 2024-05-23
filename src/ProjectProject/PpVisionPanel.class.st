Class {
	#name : #PpVisionPanel,
	#superclass : #Object,
	#instVars : [
		'dimensions',
		'alignment'
	],
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #accessing }
PpVisionPanel >> alignment [
	^ alignment ifNil: [ #center ]
]

{ #category : #accessing }
PpVisionPanel >> alignment: anObject [
	alignment := anObject
]

{ #category : #accessing }
PpVisionPanel >> beSide [

	self alignment: #side
]

{ #category : #accessing }
PpVisionPanel >> dimensions [
	^ dimensions
]

{ #category : #accessing }
PpVisionPanel >> dimensions: anObject [
	dimensions := anObject
]

{ #category : #accessing }
PpVisionPanel >> displayStringOn: aStream [

	aStream
		print: self dimensions x;
		nextPutAll: '" X ';
		print: self dimensions y;
		nextPutAll: '" vision lite'.
		
	self isSide 
		ifTrue: [ aStream nextPutAll: ' side' ]
		ifFalse: [ aStream nextPutAll: ' center' ].
		
	aStream nextPutAll: ' panel'
]

{ #category : #accessing }
PpVisionPanel >> isCenter [

	^ self alignment = #center
]

{ #category : #accessing }
PpVisionPanel >> isSide [

	^ self alignment = #side
]

{ #category : #accessing }
PpVisionPanel >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]
