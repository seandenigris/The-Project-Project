Class {
	#name : #PpLeEventSnippetBuilder,
	#superclass : #LeParentSnippetBuilder,
	#category : #'ProjectProject-GToolkit'
}

{ #category : #accessing }
PpLeEventSnippetBuilder >> text [
	self ensureSnippetOfClass: QuLeCitedTextSnippet.
	^ self snippet
		sourceID: self parent type eventID;
		yourself
]
