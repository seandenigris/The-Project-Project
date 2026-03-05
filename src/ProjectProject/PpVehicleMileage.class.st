Class {
	#name : 'PpVehicleMileage',
	#superclass : 'Object',
	#instVars : [
		'miles',
		'date',
		'source'
	],
	#category : 'ProjectProject-Core-Inventories',
	#package : 'ProjectProject',
	#tag : 'Core-Inventories'
}

{ #category : 'as yet unclassified' }
PpVehicleMileage class >> of: aNumber on: aDate [ 

	^ self new
		miles: aNumber;
		date: aDate;
		yourself
]

{ #category : 'as yet unclassified' }
PpVehicleMileage >> beCalculated [

	self source: #calculated
]

{ #category : 'as yet unclassified' }
PpVehicleMileage >> bePrimary [

	self source: #primary
]

{ #category : 'accessing' }
PpVehicleMileage >> date [
	^ date
]

{ #category : 'accessing' }
PpVehicleMileage >> date: anObject [
	date := anObject
]

{ #category : 'accessing' }
PpVehicleMileage >> dateDescription [
	<magritteDescription>
	
	^ MADateDescription new
		accessor: #date;
		priority: 100;
		yourself
]

{ #category : 'as yet unclassified' }
PpVehicleMileage >> displayStringOn: aStream [

	self miles ifNotNil: [ :ms |
		aStream
			print: ms;
			nextPutAll: ' miles' ].
			
	self date ifNotNil: [ :aDate |
		aStream
			nextPutAll: ' on ';
			nextPutAll: aDate mmddyyyy ]
]

{ #category : 'accessing' }
PpVehicleMileage >> miles [
	^ miles
]

{ #category : 'accessing' }
PpVehicleMileage >> miles: anObject [
	miles := anObject
]

{ #category : 'accessing' }
PpVehicleMileage >> milesDescription [
	<magritteDescription>
	
	^ MANumberDescription new
		accessor: #miles;
		priority: 200;
		beInteger;
		yourself
]

{ #category : 'as yet unclassified' }
PpVehicleMileage >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : 'accessing' }
PpVehicleMileage >> source [
	^ source
]

{ #category : 'accessing' }
PpVehicleMileage >> source: anObject [
	source := anObject
]
