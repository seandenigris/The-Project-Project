Class {
	#name : #PpLeTranscriptLineSnippet,
	#superclass : #LeTextSnippet,
	#instVars : [
		'lineID'
	],
	#category : #'ProjectProject-GToolkit'
}

{ #category : #'instance creation' }
PpLeTranscriptLineSnippet class >> empty [ 
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
PpLeTranscriptLineSnippet >> lineID [

	^ lineID
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> lineID: anObject [

	lineID := anObject
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> source [
	self flag: 'Does a transcript line need to know its event? If so, it''s available from the page'.
	self sourceID ifNil: [ ^ nil ].
	
	^ self
		detectSourceWithUuid: self sourceID 
		ifFound: #yourself
		ifNone: [ nil ]
]
