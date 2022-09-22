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
PpLocationList >> addChildNamed: aString [

	| location |
	location := PpLocation named: aString.
	^ self rootChildren add: location
]

{ #category : #accessing }
PpLocationList >> allChildren [

	| roots branches |
	roots := self rootChildren.
	branches := roots flatCollect: [ :p | p allChildren ].
	^ (roots addAll: branches; yourself) asSet.
]

{ #category : #accessing }
PpLocationList >> gtSearchLocationsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Locations';
		priority: 2;
		allCandidates: [ self allChildren ];
		itemName: #displayString;
		matchSubstrings
]

{ #category : #accessing }
PpLocationList >> gtSearchNewLocationFor: aStep [
	<gtSearch>
	aStep listProcessor
		title: 'Add location';
		priority: 80;
		itemName: [ :input | '+ ', input, ' location ' ];
		previewObject: [ :input | PpLocation named: input trimBoth ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := self rootChildren anySatisfy: [ :e | 
					e name = context textTrimmed ].
				isExisting not  ifTrue: [ 
					filter value: context textTrimmed ] ];
		send: [ :newName :spotterStep | self addChildNamed: newName ]
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
