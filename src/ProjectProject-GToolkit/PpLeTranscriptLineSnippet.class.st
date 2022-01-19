Class {
	#name : #PpLeTranscriptLineSnippet,
	#superclass : #LeTextSnippet,
	#instVars : [
		'lineID'
	],
	#category : #'ProjectProject-GToolkit'
}

{ #category : #accessing }
PpLeTranscriptLineSnippet class >> empty [
	"Needed because superclass returns a vanilla text snippet"
	^ self new
]

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
PpLeTranscriptLineSnippet >> event [
	^ self page type event
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> line [

	^ self event transcript detect: [ :e | e contentSnippetID = self uid ]
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> lineID [

	^ lineID
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> lineID: anObject [

	lineID := anObject
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> parent: anObject [
	super parent: anObject.
	self lineID ifNotNil: [ ^ self ].
	self page type event transcript add: (PpTranscriptLine new
		contentSnippetID: self uid;
		yourself)
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> speaker: aPerson [
	self line speaker: aPerson
]
