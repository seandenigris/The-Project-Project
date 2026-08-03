Extension { #name : 'MpRelatableEntity' }

{ #category : '*ProjectProject' }
MpRelatableEntity >> ppIsValuedObject [

	^ true
]

{ #category : '*ProjectProject' }
MpRelatableEntity >> ppProjectTitle [
	^ self fullName
]

{ #category : '*ProjectProject' }
MpRelatableEntity >> projects [
	^ self projectList agendaFor: self
]
