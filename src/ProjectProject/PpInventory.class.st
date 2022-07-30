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

{ #category : #accessing }
PpInventory >> addItemNamed: aString [

	| item |
	item := PpInventoryItem named: aString.
	^ self items add: item
]

{ #category : #accessing }
PpInventory >> gtSearchItemsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Items';
		priority: 2;
		allCandidates: [ self items ];
		itemName: #displayString;
		matchSubstrings
]

{ #category : #accessing }
PpInventory >> gtSearchNewItemFor: aStep [
	<gtSearch>
	aStep listProcessor
		title: 'Add item';
		priority: 80;
		itemName: [ :input | 'Add item: ', input ];
		previewObject: [ :input | PpInventoryItem named: input trimBoth ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := self items anySatisfy: [ :e | 
					e name = context textTrimmed ].
				isExisting not  ifTrue: [ 
					filter value: context textTrimmed ] ];
		send: [ :newName :spotterStep | self addItemNamed: newName ]
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
