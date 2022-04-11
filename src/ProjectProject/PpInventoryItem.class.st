Class {
	#name : #PpInventoryItem,
	#superclass : #Object,
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#instVars : [
		'name',
		'location'
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
PpInventoryItem >> displayStringOn: aStream [
	aStream
		nextPutAll: name;
		nextPutAll: ' @ ';
		display: location
]

{ #category : #accessing }
PpInventoryItem >> location [

	^ location
]

{ #category : #accessing }
PpInventoryItem >> location: anObject [

	location := anObject
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
		nextPutAll: ' @ ';
		print: location;
		nextPutAll: ' (Inventory Item)'
]
