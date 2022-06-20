Class {
	#name : #PpTagCollection,
	#superclass : #Object,
	#instVars : [
		'tags'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #'ProjectProject-Core'
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
	tag := PpTag new
		name: aString;
		yourself.
	^ self addTag: tag
]

{ #category : #accessing }
PpTagCollection >> ensureNamed: aString [ 
	^ self tags
			detect: [ :e | e name = aString ]
			ifNone: [ self addTagNamed: aString ]
]

{ #category : #accessing }
PpTagCollection >> gtGtSpotterTagsFor: aStep [
	<gtSearch>
	
	^ aStep listProcessor
		priority: 5;
		title: 'Tags';
		allCandidates: [ self tags ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
		itemName:[ :aTag | aTag name ].		
]

{ #category : #accessing }
PpTagCollection >> gtSpotterNewTagFor: aStep [
	<gtSearch>
	aStep listProcessor
		title: 'New tag';
		priority: 50;
		itemName: [ :input | 'Create tag: ', input ];
		previewObject: [ :input | PpTag new name: input; yourself ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := self tags anySatisfy: [ :e | 
					e name = context textTrimmed ].
				isExisting ifFalse: [ 
					filter value: context textTrimmed ] ];
		send: [ :newName :spotterStep | self ensureNamed: newName ]
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