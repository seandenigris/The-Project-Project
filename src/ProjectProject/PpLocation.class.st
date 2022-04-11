Class {
	#name : #PpLocation,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#classVars : [
		'DB'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #accessing }
PpLocation class >> db [

	^ DB ifNil: [ DB := SortedCollection sortUsing: #name ascending ].
]

{ #category : #accessing }
PpLocation class >> dbEnsureNamed: aString [
	| result |
	result := self new
	name: aString;
	yourself.
	^ self db add: result
]

{ #category : #persistence }
PpLocation class >> restoreFrom: anObject [

	DB := anObject.
]

{ #category : #persistence }
PpLocation class >> spData [

	^ DB.
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
