Class {
	#name : #PpTagCollection,
	#superclass : #Object,
	#instVars : [
		'tags'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #'ProjectProject-Tagging'
}

{ #category : #accessing }
PpTagCollection class >> uniqueInstance [

	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #accessing }
PpTagCollection class >> uniqueInstance: anObject [

	^ UniqueInstance := anObject
]

{ #category : #accessing }
PpTagCollection >> addTag: aPpTag [
	^ self tags add: aPpTag
]

{ #category : #accessing }
PpTagCollection >> addTagNamed: aString [
	| tag |
	tag := PpTag named: aString.
	^ self addTag: tag
]

{ #category : #accessing }
PpTagCollection >> ensureNamed: aString [ 
	^ self tags
			detect: [ :e | e name = aString ]
			ifNone: [ self addTagNamed: aString ]
]

{ #category : #accessing }
PpTagCollection >> gtGtSpotterTagsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 5;
		title: 'Tags';
		items: [ self tags ];
		matchSubstrings;
		itemName: [ :aTag | aTag name ]
]

{ #category : #accessing }
PpTagCollection >> gtSpotterNewTagFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'New tag';
		priority: 50;
		itemName: [ :result | '+ ' , result gtDisplayText ];
		search: [ :context | 
			| isExisting input |
			input := context searchQuery trimmed.
			isExisting := self tags anySatisfy: [ :e | e name = input ].
			isExisting
				ifFalse: [ { PpTag named: input } ]
				ifTrue: [ { } ] ];
		send: [ :result | self addTag: result ]
]

{ #category : #accessing }
PpTagCollection >> includes: aPpTag [ 
	^ self tags includes: aPpTag
]

{ #category : #accessing }
PpTagCollection >> printOn: aStream [
	aStream nextPutAll: 'Tags: '.
	self tags printElementsOn: aStream
]

{ #category : #accessing }
PpTagCollection >> tags [

	^ tags ifNil: [ tags := SortedCollection sortUsing: #name ascending  ]
]

{ #category : #accessing }
PpTagCollection >> tags: aCollection [
	tags := aCollection
]

{ #category : #accessing }
PpTagCollection >> viewListOn: aView [

	<gtView>
	^ aView forward
		title: 'Items';
		priority: 20;
		object: [ self tags ];
		view: #gtItemsFor:
]
