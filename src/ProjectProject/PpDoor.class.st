Class {
	#name : #PpDoor,
	#superclass : #PpAbstractDoor,
	#instVars : [
		'isExterior',
		'visionPanel',
		'frameNeedsReplacement'
	],
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #printing }
PpDoor >> displayStringOn: aStream [

	super displayStringOn: aStream.
	self displayVisionPanelOn: aStream
]

{ #category : #printing }
PpDoor >> displayVisionPanelOn: aStream [

	self visionPanel ifNotNil: [ :vp |
		aStream
			nextPutAll: ' with ';
			display: vp ].
]

{ #category : #accessing }
PpDoor >> frameNeedsReplacement [
	^ frameNeedsReplacement
]

{ #category : #accessing }
PpDoor >> frameNeedsReplacement: anObject [
	frameNeedsReplacement := anObject
]

{ #category : #accessing }
PpDoor >> fringes [

	^ #('weatherstripping' 'hinges' 'closer')
]

{ #category : #accessing }
PpDoor >> glass [

	^ '1/4" safety laminated'
]

{ #category : #accessing }
PpDoor >> isExterior [
	^ isExterior
]

{ #category : #accessing }
PpDoor >> isExterior: anObject [
	isExterior := anObject
]

{ #category : #accessing }
PpDoor >> replacementStringWithSeparator: aString [

	^ String streamContents: [ :aStream |
		self 
			printSummaryOn: aStream;
			displayVisionPanelOn: aStream.
				
		self frameNeedsReplacement
			ifTrue: [ aStream nextPutAll: ' and new buck' ]. ]
]

{ #category : #accessing }
PpDoor >> typeString [

	^ String streamContents: [ :aStream |
		self isExterior
			ifTrue: [ aStream nextPutAll: 'exterior ' ]
			ifFalse: [ aStream nextPutAll: 'interior ' ].
			
		aStream nextPutAll: 'door' ]
]

{ #category : #accessing }
PpDoor >> visionPanel [
	^ visionPanel
]

{ #category : #accessing }
PpDoor >> visionPanel: anObject [
	visionPanel := anObject
]

{ #category : #accessing }
PpDoor >> visionPanelDo: aBlock [
	
	visionPanel ifNil: [ visionPanel := PpVisionPanel new ].
	
	aBlock value: self visionPanel
]
