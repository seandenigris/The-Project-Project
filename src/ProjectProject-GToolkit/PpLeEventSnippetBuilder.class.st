Class {
	#name : #PpLeEventSnippetBuilder,
	#superclass : #LeParentSnippetBuilder,
	#category : #'ProjectProject-GToolkit'
}

{ #category : #accessing }
PpLeEventSnippetBuilder >> text [
	^ self ensureSnippetOfClass: PpLeTranscriptLineSnippet
]
