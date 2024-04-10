Class {
	#name : #PpLeDailyPageType,
	#superclass : #LePageType,
	#instVars : [
		'date'
	],
	#category : #'ProjectProject-GToolkit'
}

{ #category : #'instance creation' }
PpLeDailyPageType class >> date: aDate page: anLePage [

	^ self new
		date: aDate;
		page: anLePage;
		yourself
]

{ #category : #examples }
PpLeDailyPageType class >> example [
	<gtExample>
	^ self exampleEmptyPage
		addSnippet: QuLeTranscriptLineSnippet exampleDumbledore;
		addSnippet: QuLeTranscriptLineSnippet exampleHarryPotter;
		yourself
]

{ #category : #examples }
PpLeDailyPageType class >> exampleEmptyPage [
	<gtExample>
	
	| page model transcript |
	transcript := QuTranscript new.
	model := Object new.
	model stub olUID willReturn: 1.
	model stub uuid willReturn: 1.
	model stub participants willReturn: #('Jack' 'Jill').
	model stub transcript willReturn: transcript.
	self modelReferenceBuilderMap at: Object put: [OlDummyObjectUIDReferenceForTesting new
		object: model;
		uid: model uuid;
		yourself ].
	[ 
		page := LePage quTranscriptOwner: model.
	] ensure: [ self modelReferenceBuilderMap removeKey: Object ].
	LeDatabase new addPage: page.
	^ page
]

{ #category : #initialization }
PpLeDailyPageType class >> initialize [

	self updatePrimaryDBPageTypes
]

{ #category : #accessing }
PpLeDailyPageType class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#date -> #date);
		yourself
]

{ #category : #accessing }
PpLeDailyPageType class >> leJsonV4Name [

	^ 'ppDailyPage'
]

{ #category : #accessing }
PpLeDailyPageType >> asContentUIModel [
	^ LePageViewModel new pageModel: self page
]

{ #category : #accessing }
PpLeDailyPageType >> databaseKey [

	^ self date mmddyyyy
]

{ #category : #accessing }
PpLeDailyPageType >> date [
	^ date
]

{ #category : #accessing }
PpLeDailyPageType >> date: aDate [
	date := aDate translateToUTC
]

{ #category : #'api - testing' }
PpLeDailyPageType >> isPpDailyPageType [
	^ true
]

{ #category : #accessing }
PpLeDailyPageType >> pageElementClass [
	^ PeLePageElement"QuLeTranscriptPageElement"
]

{ #category : #printing }
PpLeDailyPageType >> printOn: aStream [

	aStream
		<< 'TPP Daily Page: ';
		<< self date mmddyyyy
]

{ #category : #accessing }
PpLeDailyPageType >> saveEmptyPages [

	^ true
]

{ #category : #accessing }
PpLeDailyPageType >> shouldAppearInIndexOrDailyNotes [
	^ true
]

{ #category : #accessing }
PpLeDailyPageType >> title [

	^ self date
		ifNotNil: [ :aDate | aDate mmddyyyy ]
		ifNil: [ 'PpDaily Page' ]
]
