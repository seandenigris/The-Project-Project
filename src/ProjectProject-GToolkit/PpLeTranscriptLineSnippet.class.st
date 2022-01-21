Class {
	#name : #PpLeTranscriptLineSnippet,
	#superclass : #LeTextSnippet,
	#category : #'ProjectProject-GToolkit'
}

{ #category : #accessing }
PpLeTranscriptLineSnippet class >> empty [
	"Needed because superclass returns a vanilla text snippet"
	^ self new
]

{ #category : #examples }
PpLeTranscriptLineSnippet class >> exampleDumbledore [
	<gtExample>
	
	| page result |
	page := PpLeEventPageType exampleEmptyPage.
	result := self empty.
	page addSnippet: result.
	result line speaker: page type event participants first.
	result text: 'To the well-organized mind, death is but the next great adventure.' asRopedText.
	^ result
]

{ #category : #examples }
PpLeTranscriptLineSnippet class >> exampleHarryPotter [
	<gtExample>
	
	| page result |
	page := PpLeEventPageType exampleEmptyPage.
	result := self empty.
	page addSnippet: result.
	result line speaker: page type event participants first.
	result text: 'I don''t want to be rude or anything, but—this isn''t a great time for me to have a house elf in my bedroom.' asRopedText.
	^ result
]

{ #category : #accessing }
PpLeTranscriptLineSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		"add: (#lineID -> #lineID);
		yourself "
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
PpLeTranscriptLineSnippet >> gtViewLineFor: aView [
	<gtView>
	self line ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Line';
		priority: 2;
		object: [ self line ];
		view: #gtRawFor:
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> gtViewLineOn: aView [
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> line [

	^ self event transcript 
		detect: [ :e | e contentSnippetID = self uid ] 
		ifNone: [ nil ]
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> parent: anObject [
	super parent: anObject.
	self line ifNotNil: [ ^ self ].
	self page type event transcript add: (PpTranscriptLine new
		contentSnippetID: self uid;
		position: DateAndTime now;
		yourself).
]

{ #category : #accessing }
PpLeTranscriptLineSnippet >> speaker: aPerson [
	self line speaker: aPerson
]
