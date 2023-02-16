Extension { #name : #MsalOneNotePage }

{ #category : #'*ProjectProject' }
MsalOneNotePage >> asPpEvent [
			
	^ (PpOneNoteToEventVisitor visit: self) event
]

{ #category : #'*ProjectProject' }
MsalOneNotePage >> asPpProject [
			
	^ (PpOneNoteToProjectVisitor visit: self) project
]

{ #category : #'*ProjectProject' }
MsalOneNotePage >> htmlBody [

	^ self htmlDocument findElementNamed: #body.
]

{ #category : #'*ProjectProject' }
MsalOneNotePage >> moveToPpProject [
	| project |
	project := self asPpProject.
	PpProjectList uniqueInstance addChild: project.
	project supportMaterials
		select: [ :e | e isKindOf: RlResource ]
		thenDo: #import.
		
	self delete.
	
	^ project
]
