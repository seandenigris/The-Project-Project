Class {
	#name : 'PpVehicle',
	#superclass : 'PpInventoryItem',
	#instVars : [
		'mileageRecords'
	],
	#category : 'ProjectProject-Core-Inventories',
	#package : 'ProjectProject',
	#tag : 'Core-Inventories'
}

{ #category : 'as yet unclassified' }
PpVehicle >> mileageCalculatedOn: aDate [

	| recordPair startRecord endRecord totalInterval partialInterval mileage partialMileage result |
	recordPair := (self mileageRecords iterator
	    | 2 windowIt
	    | [ :pair |
	        (aDate <= pair first date) and: [ aDate >= pair second date ]
	      ] selectIt) next.
	      
	startRecord := recordPair first.
	endRecord := recordPair second.

	totalInterval := endRecord date - startRecord date.
	partialInterval := endRecord date - aDate.
	mileage := endRecord miles - startRecord miles.
	partialMileage := partialInterval / totalInterval * mileage.
	
	result := PpVehicleMileage
		of: (endRecord miles - partialMileage) rounded
		on: aDate.
		
	^ result 
		beCalculated;
		yourself
]

{ #category : 'as yet unclassified' }
PpVehicle >> mileageOn: aDate [

	^ self mileageRecords
		detect: [ :mr | mr date = aDate ]
		ifFound: [ :mr | mr miles ]
		ifNone: [ self mileageCalculatedOn: aDate ]
]

{ #category : 'accessing' }
PpVehicle >> mileageRecords [
	^ mileageRecords ifNil: [ mileageRecords := SortedCollection sortUsing: #date descending ]
]

{ #category : 'accessing' }
PpVehicle >> mileageRecords: anObject [
	mileageRecords := anObject
]

{ #category : 'views' }
PpVehicle >> mileageRecordsGtViewFor: aView [
	<gtView>
	
	mileageRecords isEmptyOrNil ifTrue: [ ^ aView empty ].
	
	^ (aView 
		maColumnedListOf: PpVehicleMileage
		descriptionsSelect: [ :desc | true ]
		containerDo: [ :aContainer |
			(aContainer childNamed: #date) display: #mmddyyyy
			])
		title: 'Mileage';
		items: [ mileageRecords ];
		priority: 60;
		actionUpdateButton
]

{ #category : 'as yet unclassified' }
PpVehicle >> mileageWas: aNumber on: aDate [

	| record |
	record := PpVehicleMileage
		of: aNumber
		on: aDate.

	self mileageRecords add: record
]
