Class {
	#name : #PpInventory,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #'ProjectProject-Core-Inventories'
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

{ #category : #'adding / removing' }
PpInventory >> addItem: anItem [

	^ self items add: anItem
]

{ #category : #accessing }
PpInventory >> addItemNamed: aString [

	| item |
	item := PpInventoryItem named: aString.
	^ self addItem: item
]

{ #category : #accessing }
PpInventory >> gtSearchItemsFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Items';
		priority: 2;
		items: [ self items ];
		itemName: #displayString;
		matchSubstrings
]

{ #category : #accessing }
PpInventory >> gtSpotNewItemFor: aSearch [
	<gtSearch>
	
	^ aSearch explicit
		title: 'Add item';
		priority: 80;
		itemName: [ :result | '+ ', result gtDisplayString ];
		search: [ :aContext | 
			| input |
			input := aContext searchQuery trimBoth.
			{ PpInventoryItem named: input } asAsyncStream ];
		send: [ :anObject | self addItem: anObject ]
]

{ #category : #views }
PpInventory >> gtViewItemsOn: aView [
	<gtView>
	^ aView columnedList
		title: 'Items' translated;
		priority: 5;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'Location' text: [ :e | 
			e location
				ifNotNil: #displayString
				ifNil: [ '' ] ];
		actionUpdateButton;
		yourself
]

{ #category : #accessing }
PpInventory >> items [
	^ items ifNil: [ items := SortedCollection sortUsing: #name ascending ]
]
