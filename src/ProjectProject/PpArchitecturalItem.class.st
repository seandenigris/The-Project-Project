Class {
	#name : #PpArchitecturalItem,
	#superclass : #PpInventoryItem,
	#instVars : [
		'needsReplacement',
		'dimensions',
		'material',
		'hasLintel'
	],
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #testing }
PpArchitecturalItem class >> isAbstract [
		
	^ self == PpArchitecturalItem
]

{ #category : #accessing }
PpArchitecturalItem >> dimensions [
	^ dimensions
]

{ #category : #accessing }
PpArchitecturalItem >> dimensions: anObject [
	dimensions := anObject
]

{ #category : #printing }
PpArchitecturalItem >> displayStringOn: aStream [

	self name isEmptyOrNil
		ifFalse: [ super displayStringOn: aStream ]
		ifTrue: [ self printSummaryOn: aStream ]
]

{ #category : #accessing }
PpArchitecturalItem >> hasLintel [
	^ hasLintel
]

{ #category : #accessing }
PpArchitecturalItem >> hasLintel: anObject [
	hasLintel := anObject
]

{ #category : #accessing }
PpArchitecturalItem >> hasLintelDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
		accessor: #hasLintel;
		priority: 600;
		yourself
]

{ #category : #accessing }
PpArchitecturalItem >> location [
	
	^ location ifNil: [ location := PpLocationBorder new ]
]

{ #category : #accessing }
PpArchitecturalItem >> material [
	^ material
]

{ #category : #accessing }
PpArchitecturalItem >> material: anObject [
	material := anObject
]

{ #category : #accessing }
PpArchitecturalItem >> needsReplacement [
	^ needsReplacement
]

{ #category : #accessing }
PpArchitecturalItem >> needsReplacement: anObject [
	needsReplacement := anObject
]

{ #category : #accessing }
PpArchitecturalItem >> needsReplacementDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
		accessor: #needsReplacement;
		priority: 600;
		yourself
]

{ #category : #printing }
PpArchitecturalItem >> printDimensionsOn: aStream [

	self dimensions ifNotNil: [ :dims |
		aStream
			print: dims x;
			nextPutAll: '" X ';
			print: dims y;
			nextPutAll: '" ' ].
]

{ #category : #printing }
PpArchitecturalItem >> printSummaryOn: aStream [

	self printDimensionsOn: aStream.
		
	self material ifNotNil: [ :mat | aStream nextPutAll: self material ].
		
	aStream 
		space;
		nextPutAll: self typeString.
]

{ #category : #printing }
PpArchitecturalItem >> typeString [

	self subclassResponsibility
]
