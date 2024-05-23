Class {
	#name : #PpOverheadDoorMotor,
	#superclass : #PpInventoryItem,
	#instVars : [
		'model',
		'otherSpecifications'
	],
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #accessing }
PpOverheadDoorMotor class >> forDoor: anOverheadDoor [

	^ self new
		name: anOverheadDoor name, ' motor';
		location: anOverheadDoor location;
		yourself
]

{ #category : #accessing }
PpOverheadDoorMotor class >> ndOtherSpecifications [

	^ #(
		'1/2 H.P'
		'115 Volts with Emergency manual chain'
		'(2) Sets of photo cell: one mounted 6" From floor (UL325) and one mounted 18" From floor'
		'(1) Safety edge'
		'(1) Take up reel'
		'(1) Remote control')
]

{ #category : #accessing }
PpOverheadDoorMotor >> model [
	^ model
]

{ #category : #accessing }
PpOverheadDoorMotor >> model: anObject [
	model := anObject
]

{ #category : #accessing }
PpOverheadDoorMotor >> otherSpecifications [
	^ otherSpecifications
]

{ #category : #accessing }
PpOverheadDoorMotor >> otherSpecifications: anObject [
	otherSpecifications := anObject
]

{ #category : #accessing }
PpOverheadDoorMotor >> replacementStringWithSeparator: aString [

	^ String streamContents: [ :aStream |
		aStream << 'Motor Operator'.
		"self printSummaryOn: aStream."
		
		aStream
			nextPutAll: aString;
			nextPutAll: 'Model: '; << self model; << ', or approved equal'.
			
	self otherSpecifications
		do: [ :spec |
			aStream
				nextPutAll: aString;
				nextPutAll: spec ] ]
]
