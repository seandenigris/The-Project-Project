Class {
	#name : #PpLeTranscriptLineSnippetViewModel,
	#superclass : #LeTextCoderSnippetViewModel,
	#category : #'ProjectProject-GToolkit'
}

{ #category : #accessing }
PpLeTranscriptLineSnippetViewModel >> positionDisplayText [
	^ self snippetModel line position
		ifNotNil: [ :obj | obj asTime print24 gtDisplayText ]
		ifNil: [ '' asRopedText ]
]

{ #category : #accessing }
PpLeTranscriptLineSnippetViewModel >> snippetElementClass [
	^ PpLeTranscriptLineSnippetElement 
]

{ #category : #accessing }
PpLeTranscriptLineSnippetViewModel >> speakerDisplayText [
	^ self snippetModel line speaker
		ifNotNil: [ :spkr | spkr gtDisplayText ]
		ifNil: [ '' asRopedText ]
]
