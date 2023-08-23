Trait {
	#name : #PpTProjectProperty,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpTProjectProperty >> basicNewLinkedPpProject [

	^ self linkedPpProjectClass new
		title: self ppProjectTitle;
		yourself
]

{ #category : #testing }
PpTProjectProperty >> isPpValuedObject [
	self explicitRequirement
]

{ #category : #accessing }
PpTProjectProperty >> linkedPpProjectClass [
	^ PpProject
]

{ #category : #accessing }
PpTProjectProperty >> newLinkedPpProject [
	"Override for custom project configuration e.g. setting a backlink from the project to self. This additional level of indirection is provided so you don't have to worry about aliasing"

	^ self basicNewLinkedPpProject
]

{ #category : #accessing }
PpTProjectProperty >> newPpProject [

	^ self isPpValuedObject
		ifTrue: [ PpValuedObject on: self ]
		ifFalse: [ self newLinkedPpProject ]
]

{ #category : #accessing }
PpTProjectProperty >> ppProject [

	^ self
		propertyAt: #ppProject
		ifAbsentPut: [ self newPpProject ]
]

{ #category : #accessing }
PpTProjectProperty >> ppProject: aPpValue [

	self
		propertyAt: #ppProject
		putRemovingNil: aPpValue
]

{ #category : #accessing }
PpTProjectProperty >> ppProjectTitle [
	"#title is set as the default for convenience. Override as needed"

	^ self title
]
