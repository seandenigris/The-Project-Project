Extension { #name : #MpRelatableEntity }

{ #category : #'*ProjectProject' }
MpRelatableEntity >> ppProject [

	^ self
		propertyAt: #ppProject
		ifAbsentPut: [ PpValuedObject on: self ]
]

{ #category : #'*ProjectProject' }
MpRelatableEntity >> ppProjectTitle [
	^ self fullName
]

{ #category : #'*ProjectProject' }
MpRelatableEntity >> projectList [
	^ PpProjectList uniqueInstance
]

{ #category : #'*ProjectProject' }
MpRelatableEntity >> projects [
	^ self projectList agendaFor: self
]
