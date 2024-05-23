Class {
	#name : #PpLocation,
	#superclass : #PpAbstractLocation,
	#instVars : [
		'children'
	],
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #accessing }
PpLocation class >> list [
	^ PpLocationList uniqueInstance
]

{ #category : #accessing }
PpLocation class >> named: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : #persistence }
PpLocation class >> restoreFrom: anObject [

	PpLocationList restoreFrom:anObject.
]

{ #category : #persistence }
PpLocation class >> spData [

	^ PpLocationList spData
]

{ #category : #accessing }
PpLocation >> addChild: aLocation [

	^ self children add: aLocation
]

{ #category : #accessing }
PpLocation >> addChildNamed: aString [

	| child |
	child := self class named: aString.
	^ self addChild: child
]

{ #category : #accessing }
PpLocation >> allChildren [

	| roots branches |
	roots := self rootChildren.
	branches := roots flatCollect: [ :p | p allChildren ].
	^ (roots, branches) asSet.
]

{ #category : #accessing }
PpLocation >> children [
	^ self maLazyInstVarUsing: self childrenDescription
]

{ #category : #'as yet unclassified' }
PpLocation >> children: aCollection [ 
	children := aCollection
]

{ #category : #accessing }
PpLocation >> childrenDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
		accessor: #children;
		priority: 200;
		default: Bag new;
		classes: PpLocation withAllSubclasses;
		gtSearchSource: (MessageSend receiver: self selector: #list); 
		yourself
]

{ #category : #accessing }
PpLocation >> childrenForItemsView [

	^ OrderedCollection new
		addAll: self items;
		addAll: self children;
		yourself
]

{ #category : #accessing }
PpLocation >> childrenGtViewOn: aView [
	<gtView>
	^ aView tree
		title: 'Children' translated;
		priority: 5;
		items: [ self children ];
		children: #children;
		actionUpdateButton
]

{ #category : #accessing }
PpLocation >> displayStringOn: aStream [

	aStream nextPutAll: self fullName
]

{ #category : #accessing }
PpLocation >> distanceFrom: rhs [
	^ self geoLocation distanceFrom: rhs geoLocation
]

{ #category : #accessing }
PpLocation >> fullName [
	^ String streamContents: [ :s |
			self parent ifNotNil: [ :p | s << p fullName; space ].
			s << self name ]
]

{ #category : #accessing }
PpLocation >> geoLocation [
	^ self propertyAt: #geoLocation ifAbsent: [ nil ]
]

{ #category : #accessing }
PpLocation >> geoLocation: aPpGeoLocation [
	^ self propertyAt: #geoLocation put: aPpGeoLocation
]

{ #category : #accessing }
PpLocation >> gtSearchNewLocationFor: aSearch [
	<gtSearch>
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
				ifFalse: [ { self class named: input } ]
				ifTrue: [ { } ] ];
		send: [ :result | self addChild: result ]
]

{ #category : #accessing }
PpLocation >> initialize [
	super initialize.
	self ensureUUID
]

{ #category : #accessing }
PpLocation >> items [
		
	^ self inventory items select: [ : item |
		item location = self ]
]

{ #category : #accessing }
PpLocation >> itemsAll [
		
	^ self children
		inject: self items
		into: [ :res :loc |
			res
				addAll: loc items;
				yourself ]
]

{ #category : #accessing }
PpLocation >> itemsGtViewOn: aView [
	<gtView>
	^ aView tree
		title: 'Items' translated;
		priority: 15;
		items: [ self childrenForItemsView ];
		itemText: #displayString;
		children: #childrenForItemsView;
		actionUpdateButton
]

{ #category : #accessing }
PpLocation >> list [
	^ PpLocationList uniqueInstance
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
PpLocation >> parent [

	^ self list allChildren 
		detect: [ :e | e children includes: self ]
		ifNone: [ nil ]
]

{ #category : #accessing }
PpLocation >> printOn: aStream [

	aStream
		nextPutAll: name;
		nextPutAll: ' location'
]

{ #category : #accessing }
PpLocation >> rootChildren [
	^ self children
]
