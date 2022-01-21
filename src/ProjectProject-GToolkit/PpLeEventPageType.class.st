Class {
	#name : #PpLeEventPageType,
	#superclass : #LePageType,
	#instVars : [
		'eventID'
	],
	#category : #'ProjectProject-GToolkit'
}

{ #category : #'instance creation' }
PpLeEventPageType class >> eventID: aUUID page: aLePage [

	^ self new 
		eventID: aUUID;
		page: aLePage 
]

{ #category : #examples }
PpLeEventPageType class >> example [
	<gtExample>
	^ self exampleEmptyPage
		addSnippet: PpLeTranscriptLineSnippet exampleDumbledore;
		addSnippet: PpLeTranscriptLineSnippet exampleHarryPotter;
		yourself
]

{ #category : #examples }
PpLeEventPageType class >> exampleEmptyPage [
	<gtExample>
	| log page |
	log := PpEventLog example.
	page := LePage ppEventID: log events first ensureUUID.
	LeDatabase new addPage: page.
	page type stub eventLog willReturn: log.
	^ page
]

{ #category : #accessing }
PpLeEventPageType class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#eventID -> #eventID);
		yourself

]

{ #category : #accessing }
PpLeEventPageType class >> leJsonV3Name [

	^ 'ppEventPage'
]

{ #category : #accessing }
PpLeEventPageType class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#eventID -> #eventID);
		add: (#dynabookModelReference -> #dynabookModelReference);
		yourself

]

{ #category : #accessing }
PpLeEventPageType class >> leJsonV4Name [

	^ 'ppEventPage'
]

{ #category : #comparing }
PpLeEventPageType >> = anObject [
	"Answer whether the receiver and anObject represent the same page type."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ self eventID = anObject eventID
]

{ #category : #accessing }
PpLeEventPageType >> databaseKey [
	"Answer the attribute used to index a page of the receiver's type in the database."

	^ self eventID
]

{ #category : #accessing }
PpLeEventPageType >> dynabookModelReference [

	^ DbObjectUIDReference new
		sourceClass: #PpEventLog;
		collectionGetter: #events;
		uid: self eventID;
		yourself
]

{ #category : #accessing }
PpLeEventPageType >> event [
	self eventID ifNil: [ ^ nil ].
	^ self eventLog events detect: [ :e | e uuid = self eventID ]
]

{ #category : #accessing }
PpLeEventPageType >> eventID [

	^ eventID
]

{ #category : #accessing }
PpLeEventPageType >> eventID: anObject [

	eventID := anObject
]

{ #category : #accessing }
PpLeEventPageType >> eventLog [
	^ PpEventLog uniqueInstance
]

{ #category : #comparing }
PpLeEventPageType >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self eventID hash
]

{ #category : #'api - testing' }
PpLeEventPageType >> isPpEventPageType [
	^ true
]

{ #category : #printing }
PpLeEventPageType >> printOn: aStream [

	aStream
		<< 'PpEvent Page: ';
		<< (self event ifNotNil: #printString ifNil: [ '<none>' ])
]

{ #category : #accessing }
PpLeEventPageType >> snippetBuilder [
	^ PpLeEventSnippetBuilder new
		parent: self page;
		database: self page database.
]

{ #category : #accessing }
PpLeEventPageType >> title [

	^ self event 
		ifNotNil: #displayString
		ifNil: [ 'PpEvent Page' ]
]
