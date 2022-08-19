Extension { #name : #MpPerson }

{ #category : #'*ProjectProject' }
MpPerson >> projects [
	^ PpProjectList uniqueInstance agendaFor: self
]
