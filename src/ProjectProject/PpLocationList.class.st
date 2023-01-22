Class {
	#name : #PpLocationList,
	#superclass : #Object,
	#instVars : [
		'locations',
		'rootChildren'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #persistence }
PpLocationList class >> restoreFrom: anObject [

	UniqueInstance := anObject
]

{ #category : #persistence }
PpLocationList class >> spData [

	^ UniqueInstance
]

{ #category : #'instance creation' }
PpLocationList class >> uniqueInstance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #accessing }
PpLocationList >> addChild: aLocation [

	^ self rootChildren add: aLocation
]

{ #category : #accessing }
PpLocationList >> addChildNamed: aString [

	| location |
	location := PpLocation named: aString.
	^ self addChild: location
]

{ #category : #accessing }
PpLocationList >> allChildren [

	| roots branches |
	roots := self rootChildren.
	branches := roots flatCollect: [ :p | p allChildren ].
	^ (roots addAll: branches; yourself) asSet.
]

{ #category : #accessing }
PpLocationList >> gtSearchLocationsFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Locations';
		priority: 2;
		items: [ self allChildren asOrderedCollection ];
		itemName: #displayString;
		matchSubstrings
]

{ #category : #accessing }
PpLocationList >> gtSearchNewLocationFor: aSearch [
	<gtSearch>
	
	self flag: 'looks duplicated from location class'.
	^ aSearch explicit
		title: 'Add location';
		priority: 80;
		itemName: [ :result | '+ ' , result gtDisplayText ];
		search: [ :context | 
			| isExisting input |
			input := context searchQuery trimmed.
			isExisting := self rootChildren
				anySatisfy: [ :e | e name = input ].
			isExisting 
				ifFalse: [ { PpLocation named: input } ]
				ifTrue: [ { } ] ];
		send: [ :result | self addChild: result ]
]

{ #category : #views }
PpLocationList >> gtViewLocationsOn: aView [
	<gtView>
	^ aView tree
		title: 'Locations' translated;
		priority: 5;
		items: [ self rootChildren ];
		children: #children;
		actionUpdateButton
]

{ #category : #accessing }
PpLocationList >> rootChildren [

	^ rootChildren ifNil: [ rootChildren := Set new ]
]

{ #category : #accessing }
PpLocationList >> rootChildren: anObject [

	rootChildren := anObject
]
