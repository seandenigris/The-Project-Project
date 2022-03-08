Class {
	#name : #PpInventoryItem,
	#superclass : #Object,
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#instVars : [
		'name'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #accessing }
PpInventoryItem class >> named: aString [ 

	^ self new
		name: aString;
		yourself
]

{ #category : #accessing }
PpInventoryItem >> name [

	^ name
]

{ #category : #accessing }
PpInventoryItem >> name: anObject [

	name := anObject
]

{ #category : #accessing }
PpInventoryItem >> printOn: aStream [
	aStream
		nextPutAll: name;
		nextPutAll: ' (Inventory Item)'
]
