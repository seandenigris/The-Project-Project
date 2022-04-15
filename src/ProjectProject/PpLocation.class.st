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
