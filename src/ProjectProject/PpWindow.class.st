Class {
	#name : #PpWindow,
	#superclass : #PpArchitecturalItem,
	#instVars : [
		'type'
	],
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #accessing }
PpWindow >> location [

	^ location
]

{ #category : #accessing }
PpWindow >> replacementStringWithSeparator: aString [

	^ String streamContents: [ :aStream |
		self printSummaryOn: aStream ]
]

{ #category : #accessing }
PpWindow >> type [
	^ type
]

{ #category : #accessing }
PpWindow >> type: anObject [
	type := anObject
]

{ #category : #accessing }
PpWindow >> typeString [

	^ String streamContents: [ :aStream |
			self type ifNotNil: [ aStream nextPutAll: self type; space ].
			"self isExterior
				ifTrue: [ aStream nextPutAll: 'exterior ' ]
				ifFalse: [ aStream nextPutAll: 'interior ' ]."
				
			aStream nextPutAll: 'window' ]
]
