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
PpTranscriptLine >> position [

	^ position
]

{ #category : #accessing }
PpTranscriptLine >> position: anObject [

	position := anObject
]

{ #category : #accessing }
PpTranscriptLine >> printOn: aStream [
	position ifNotNil: [ :obj | aStream print: obj; space ].
	speaker ifNotNil: [ :obj | aStream print: obj; space ].
	contentSnippetID ifNotNil: [ 
		| cStr |
		cStr := [ self snippet contentAsString ] on: Error do: [ '???' ]. 
		aStream print: cStr ].
]

{ #category : #accessing }
PpTranscriptLine >> snippet [

	^ LeDatabasesRegistry defaultPrimaryDatabase blockWithUID: self contentSnippetID
]

{ #category : #accessing }
PpTranscriptLine >> speaker [

	^ speaker
]

{ #category : #accessing }
PpTranscriptLine >> speaker: anObject [

	speaker := anObject
]
