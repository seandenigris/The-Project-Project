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
