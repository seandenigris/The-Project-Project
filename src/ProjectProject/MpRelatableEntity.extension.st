Extension { #name : #MpRelatableEntity }

{ #category : #'*ProjectProject' }
MpRelatableEntity >> projectList [
	^ PpProjectList uniqueInstance
]

{ #category : #'*ProjectProject' }
MpRelatableEntity >> projects [
	^ self projectList agendaFor: self
]
