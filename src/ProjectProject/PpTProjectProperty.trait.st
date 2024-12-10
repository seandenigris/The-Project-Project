Trait {
	#name : #PpTProjectProperty,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpTProjectProperty >> hasPpProject [

	^ self properties includesKey: #ppProject
]

{ #category : #testing }
PpTProjectProperty >> isPpValuedObject [
	"If yes, self will *become* a project via a wrapper. If not, we will *link* to a related project"
	self explicitRequirement
]

{ #category : #accessing }
PpTProjectProperty >> newLinkedPpProject [
	
	| result |
	result := self ppLinkedProjectClass new
		title: self ppProjectTitle;
		yourself.
		
	self ppProjectConfigureLinked: result.
	
	^ result
]

{ #category : #accessing }
PpTProjectProperty >> newPpProject [

	^ self isPpValuedObject
		ifTrue: [ PpValuedObject on: self ]
		ifFalse: [ self newLinkedPpProject ]
]

{ #category : #'as yet unclassified' }
PpTProjectProperty >> postCopyProjectProperty [
	"Send after super postCopy"
	
	self ppProjectBasic: nil
]

{ #category : #accessing }
PpTProjectProperty >> ppLinkedProjectClass [
	^ PpProject
]

{ #category : #accessing }
PpTProjectProperty >> ppProject [

	^ self
		propertyAt: #ppProject
		ifAbsentPut: [ self newPpProject ]
]

{ #category : #accessing }
PpTProjectProperty >> ppProject: aPpValue [
		
	aPpValue 
		ifNotNil: [ self ppProjectConfigureLinked: aPpValue ]
		ifNil: [ self ppProjectOnRemove ].
		
	self ppProjectBasic: aPpValue.
]

{ #category : #accessing }
PpTProjectProperty >> ppProjectBasic: aPpValue [

	self
		propertyAt: #ppProject
		putRemovingNil: aPpValue
]

{ #category : #accessing }
PpTProjectProperty >> ppProjectConfigureLinked: aPpValue [
	"Override for custom project configuration e.g. setting a backlink from the project to self."
]

{ #category : #accessing }
PpTProjectProperty >> ppProjectOnRemove [
	"Override for custom projects e.g. removing a backlink from the project to self."
]

{ #category : #accessing }
PpTProjectProperty >> ppProjectTitle [
	"#title is set as the default for convenience. Override as needed"

	^ self title
]
