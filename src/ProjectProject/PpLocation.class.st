Class {
	#name : #PpLocation,
	#superclass : #Object,
	#instVars : [
		'name',
		'children'
	],
	#classVars : [
		'DB'
	],
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #accessing }
PpLocation class >> named: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : #persistence }
PpLocation class >> restoreFrom: anObject [

	PpLocationList restoreFrom:anObject.
]

{ #category : #persistence }
PpLocation class >> spData [

	^ PpLocationList spData
]

{ #category : #accessing }
PpLocation >> addChildNamed: aString [

	| child |
	child := self class new
		name: aString;
		yourself.
	^ self children add: child
]

{ #category : #accessing }
PpLocation >> children [
	^ children ifNil: [ children := Bag new ]
]

{ #category : #accessing }
PpLocation >> displayStringOn: aStream [

	aStream nextPutAll: name
]

{ #category : #accessing }
PpLocation >> name [

	^ name
]

{ #category : #accessing }
PpLocation >> name: anObject [

	name := anObject
]

{ #category : #accessing }
PpLocation >> printOn: aStream [

	aStream
		nextPutAll: name;
		nextPutAll: ' location'
]
