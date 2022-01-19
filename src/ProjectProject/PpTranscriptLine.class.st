Class {
	#name : #PpTranscriptLine,
	#superclass : #Object,
	#instVars : [
		'position',
		'speaker',
		'contentSnippetID'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #accessing }
PpTranscriptLine >> contentSnippetID [

	^ contentSnippetID
]

{ #category : #accessing }
PpTranscriptLine >> contentSnippetID: aUUID [

	contentSnippetID := aUUID
]

{ #category : #accessing }
PpTranscriptLine >> contents [

	^ contents
]

{ #category : #accessing }
PpTranscriptLine >> position [

	^ position
]

{ #category : #accessing }
PpTranscriptLine >> position: anObject [

	position := anObject
]

{ #category : #accessing }
PpTranscriptLine >> speaker [

	^ speaker
]

{ #category : #accessing }
PpTranscriptLine >> speaker: anObject [

	speaker := anObject
]
