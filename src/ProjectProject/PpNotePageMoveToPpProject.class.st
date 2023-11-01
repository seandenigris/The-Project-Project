Class {
	#name : #PpNotePageMoveToPpProject,
	#superclass : #MsalNotePageHandler,
	#category : #ProjectProject
}

{ #category : #testing }
PpNotePageMoveToPpProject class >> canHandleNote: aPage [

	^ true
]

{ #category : #accessing }
PpNotePageMoveToPpProject >> displayStringOn: aStream [

	aStream << 'Move to PpProject'
]

{ #category : #accessing }
PpNotePageMoveToPpProject >> execute [

	self note
		moveToPpProject;
		delete.
]
