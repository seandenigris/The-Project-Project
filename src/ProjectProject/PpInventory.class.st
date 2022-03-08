Class {
	#name : #PpInventory,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #persistence }
PpInventory class >> restoreFrom: anObject [

	UniqueInstance := anObject
]

{ #category : #persistence }
PpInventory class >> spData [

	^ UniqueInstance
]

{ #category : #'instance creation' }
PpInventory class >> uniqueInstance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #accessing }
PpInventory >> addItemNamed: aString [

	| item |
	item := PpInventoryItem named: aString.
	^ self items add: item
]

{ #category : #accessing }
PpInventory >> items [
	^ items ifNil: [ items := SortedCollection sortUsing: #name ascending ]
]
