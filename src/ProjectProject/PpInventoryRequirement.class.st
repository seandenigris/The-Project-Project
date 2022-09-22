Class {
	#name : #PpInventoryRequirement,
	#superclass : #PpProjectCondition,
	#instVars : [
		'item'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #'spotter - instance creation' }
PpInventoryRequirement class >> gtSpotterItemsFromString: aString [

	| bestMatches |
	bestMatches := PpInventory uniqueInstance items
		sorted: [ :a :b | (a name alike: aString) > (b name alike: aString) ].
	
	bestMatches first = aString ifFalse: [ 
		| loc |
		loc := PpInventoryItem named: aString.
		bestMatches add: loc ].
	
	^ bestMatches collect: [ :loc |
		self new
			item: loc;
			yourself ].
]

{ #category : #accessing }
PpInventoryRequirement >> item [

	^ item
]

{ #category : #accessing }
PpInventoryRequirement >> item: anObject [

	item := anObject
]

{ #category : #accessing }
PpInventoryRequirement >> printOn: aStream [

	aStream
		"nextPut: $@;"
		print: self item;
		nextPutAll: ' requirement'
]
