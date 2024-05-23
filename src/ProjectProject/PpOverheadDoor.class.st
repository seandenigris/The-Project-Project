Class {
	#name : #PpOverheadDoor,
	#superclass : #PpAbstractDoor,
	#instVars : [
		'model',
		'sections',
		'panels',
		'jambMaterial',
		'otherSpecifications',
		'finish',
		'motor'
	],
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #accessing }
PpOverheadDoor class >> ndOtherSpecifications [

	^ #(
		'Two Rows of Solid panel on two bottom sections'
		'#3-#4-#5 and #6 Sections to be 1/8 Clear tempered single glazed'
		'3" Angle mounted track to {jambMaterial} jambs'
		'Counterbalance torsion spring system (25,000 Cycle)'
		'1" Solid shaft'
		'Pusher spring bumper'
		'Include new trim and weatherstripping').
]

{ #category : #accessing }
PpOverheadDoor >> finish [
	^ finish
]

{ #category : #accessing }
PpOverheadDoor >> finish: anObject [
	finish := anObject
]

{ #category : #accessing }
PpOverheadDoor >> jambMaterial [
	^ jambMaterial
]

{ #category : #accessing }
PpOverheadDoor >> jambMaterial: anObject [
	jambMaterial := anObject
]

{ #category : #accessing }
PpOverheadDoor >> jambMaterialDescription [
	<magritteDescription>
	
	^ MASingleOptionDescription new
			accessor: #material;
			priority: 100;
			options: #(steel wood);
			yourself
]

{ #category : #accessing }
PpOverheadDoor >> material [
	^ material
]

{ #category : #accessing }
PpOverheadDoor >> material: anObject [
	material := anObject
]

{ #category : #accessing }
PpOverheadDoor >> materialDescription [
	<magritteDescription>
	
	^ MASingleOptionDescription new
			accessor: #material;
			priority: 100;
			options: #(steel aluminum);
			yourself
]

{ #category : #accessing }
PpOverheadDoor >> model [
	^ model
]

{ #category : #accessing }
PpOverheadDoor >> model: anObject [
	model := anObject
]

{ #category : #accessing }
PpOverheadDoor >> motor [
	^ motor
]

{ #category : #accessing }
PpOverheadDoor >> motor: anObject [
	motor := anObject
]

{ #category : #accessing }
PpOverheadDoor >> motorDo: aBlock [
	
	motor ifNil: [ motor := PpOverheadDoorMotor forDoor: self ].
	
	aBlock value: self motor
]

{ #category : #accessing }
PpOverheadDoor >> otherSpecifications [
	^ otherSpecifications
]

{ #category : #accessing }
PpOverheadDoor >> otherSpecifications: anObject [
	otherSpecifications := anObject
]

{ #category : #accessing }
PpOverheadDoor >> panels [
	^ panels
]

{ #category : #accessing }
PpOverheadDoor >> panels: anObject [
	panels := anObject
]

{ #category : #accessing }
PpOverheadDoor >> printDimensionsOn: aStream [

	self dimensions ifNotNil: [ :dims |
		aStream
			print: dims x // 12;
			nextPutAll: '''';
			print: dims x \\ 12;
			nextPutAll: '" X ';
			print: dims y // 12;
			nextPutAll: '''';
			print: dims y \\ 12;
			nextPutAll: '" ' ].
]

{ #category : #accessing }
PpOverheadDoor >> replacementGtViewFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Replacement';
		priority: 62;
		text: (self replacementStringWithSeparator: String crlf, '- ');
		yourself.
]

{ #category : #accessing }
PpOverheadDoor >> replacementStringWithSeparator: aString [

	^ String streamContents: [ :aStream |
		self printSummaryOn: aStream.
		
		aStream
			nextPutAll: aString;
			nextPutAll: 'Model: '; << self model; << ', or approved equal'.
		
		aStream 
			nextPutAll: aString;
			nextPutAll: self finish;
			nextPutAll: aString;
			print: self sections;
			nextPutAll: ' Sections, ';
			print: self panels;
			nextPutAll: ' Panels'.
			
	self otherSpecifications
		do: [ :spec |
			| filledSpec |
			filledSpec := spec format: { #jambMaterial -> self jambMaterial } asDictionary.
			aStream
				nextPutAll: aString;
				nextPutAll: filledSpec ] ]
]

{ #category : #accessing }
PpOverheadDoor >> sections [
	^ sections
]

{ #category : #accessing }
PpOverheadDoor >> sections: anObject [
	sections := anObject
]

{ #category : #accessing }
PpOverheadDoor >> typeString [

	^ 'overhead door'
]
