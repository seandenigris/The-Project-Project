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
PpInventory >> gtSearchTransactionsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Items';
		priority: 2;
		allCandidates: [ self items ];
		itemName: #displayString;
		matchSubstrings
]

{ #category : #views }
PpInventory >> gtViewItemsOn: aView [
	<gtView>
	^ aView columnedList
		title: 'Items' translated;
		priority: 5;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'Location' text: [ :e | e location displayString ];
		yourself.
]

{ #category : #accessing }
PpInventory >> items [
	^ items ifNil: [ items := SortedCollection sortUsing: #name ascending ]
]
