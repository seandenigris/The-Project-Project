Class {
	#name : #PpProjectCompletionFilter,
	#superclass : #PpProjectFilter,
	#instVars : [
		'matchesComplete',
		'matchesIncomplete'
	],
	#category : #'ProjectProject-UI-Bloc'
}

{ #category : #'instance creation' }
PpProjectCompletionFilter class >> filterDescriptor [

	^ GtFilterShortListModel new
		creator: [ :anItem |
			anItem
				ifSome: [ :aValue | 
					aValue 
						ifTrue: [ self matchingComplete ]
						ifFalse: [ self matchingIncomplete ] ]
				ifNone: [ self matchingAll ] ];
		named: 'Complete?';
		order: 18;
		items: { 
			PpFilterIncompleteItem new.
			GtFilterModelAllItem default.
			PpFilterCompleteItem new };
		selectFirstItem.
		
	"Adapted from GtSearchSubclassResponsibilityMethodsFilter>>#globalFilterDescriptor2"
]

{ #category : #'instance creation' }
PpProjectCompletionFilter class >> matchingAll [

	^ self matchingComplete
		matchesIncomplete: true;
		yourself
]

{ #category : #'instance creation' }
PpProjectCompletionFilter class >> matchingComplete [

	^ self new
		matchesComplete: true;
		yourself
]

{ #category : #'instance creation' }
PpProjectCompletionFilter class >> matchingIncomplete [

	^ self new
		matchesIncomplete: true;
		yourself
]

{ #category : #'as yet unclassified' }
PpProjectCompletionFilter >> matches: anObject [

	self matchesAll ifTrue: [ ^ true ].
	
	self matchesComplete ifTrue: [ ^ anObject isComplete ].
	
	self matchesIncomplete ifTrue: [ ^ anObject isComplete not ].
]

{ #category : #'as yet unclassified' }
PpProjectCompletionFilter >> matchesAll [

	^ self matchesComplete and: [ self matchesIncomplete ]
]

{ #category : #'as yet unclassified' }
PpProjectCompletionFilter >> matchesComplete [

	^ matchesComplete ifNil: [ ^ false ]
]

{ #category : #'as yet unclassified' }
PpProjectCompletionFilter >> matchesComplete: aBoolean [

	matchesComplete := aBoolean
]

{ #category : #'as yet unclassified' }
PpProjectCompletionFilter >> matchesIncomplete [

	^ matchesIncomplete ifNil: [ ^ false ]
]

{ #category : #'as yet unclassified' }
PpProjectCompletionFilter >> matchesIncomplete: aBoolean [

	matchesIncomplete := aBoolean
]
