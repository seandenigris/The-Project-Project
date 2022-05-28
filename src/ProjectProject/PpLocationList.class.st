Class {
	#name : #PpLocationList,
	#superclass : #Object,
	#instVars : [
		'locations'
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
PpLocationList >> addLocationNamed: aString [

	| location |
	location := PpLocation named: aString.
	^ self locations add: location
]

{ #category : #accessing }
PpLocationList >> gtSearchLocationsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Locations';
		priority: 2;
		allCandidates: [ self locations ];
		itemName: #displayString;
		matchSubstrings
]

{ #category : #accessing }
PpLocationList >> gtSearchNewLocationFor: aStep [
	<gtSearch>
	aStep listProcessor
		title: 'Add location';
		priority: 80;
		itemName: [ :input | 'Add location ', input ];
		previewObject: [ :input | PpLocation named: input trimBoth ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := self locations anySatisfy: [ :e | 
					e name = context textTrimmed ].
				isExisting not  ifTrue: [ 
					filter value: context textTrimmed ] ];
		send: [ :newName :spotterStep | self addLocationNamed: newName ]
]

{ #category : #views }
PpLocationList >> gtViewLocationsOn: aView [
	<gtView>
	^ aView tree
		title: 'Locations' translated;
		priority: 5;
		items: [ self locations ];
		children: #children;
		actionUpdateButton
]

{ #category : #accessing }
PpLocationList >> locations [

	^ locations ifNil: [ locations := SortedCollection sortUsing: #name ascending ]
]

{ #category : #accessing }
PpLocationList >> locations: anObject [

	locations := anObject
]
