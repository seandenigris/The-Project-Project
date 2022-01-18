Class {
	#name : #PpTranscriptLine,
	#superclass : #Object,
	#instVars : [
		'position',
		'speaker',
		'contents'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #accessing }
PpTranscriptLine >> contents [

	^ contents
]

{ #category : #accessing }
PpTranscriptLine >> contents: anObject [

	contents := anObject
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
