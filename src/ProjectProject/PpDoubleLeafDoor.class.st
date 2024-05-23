Class {
	#name : #PpDoubleLeafDoor,
	#superclass : #PpDoor,
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #accessing }
PpDoubleLeafDoor >> printSummaryOn: aStream [

	aStream 
		nextPutAll: 'double leaf ';
		nextPutAll: self typeString.
		
	aStream nextPutAll: '. Each leaf: '.

	self printDimensionsOn: aStream.
		
	self material ifNotNil: [ :mat | aStream nextPutAll: self material ].
		
	
]
