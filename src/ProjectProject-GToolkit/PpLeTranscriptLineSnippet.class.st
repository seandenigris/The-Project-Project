Class {
	#name : #PpLeTranscriptLineSnippet,
	#superclass : #LeTextSnippet,
	#instVars : [
		'lineID'
	],
	#category : #'ProjectProject-GToolkit'
}

{ #category : #accessing }
PpLeTranscriptLineSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: (#lineID -> #lineID);
		yourself 
]

{ #category : #accessing }
PpLeTranscriptLineSnippet class >> leJsonV4Name [

	^ 'ppTranscriptLineSnippet'
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> asSnippetViewModel [
	^ PpLeTranscriptLineSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> lineID [

	^ lineID
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> lineID: anObject [

	lineID := anObject
]
