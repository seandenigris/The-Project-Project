Class {
	#name : #PpEvent,
	#superclass : #Object,
	#traits : 'DbTDomainObject - {#editLepiterPageDescription} + (QuTTranscriptable @ {#traitTranscript->#transcript}) + PpTProjectProperty',
	#classTraits : 'DbTDomainObject classTrait + QuTTranscriptable classTrait + PpTProjectProperty classTrait',
	#instVars : [
		'endDate',
		'startDate',
		'endTime',
		'startTime',
		'notes',
		'participants',
		'title',
		'location',
		'transcript'
	],
	#category : #'ProjectProject-Core-Events'
}

{ #category : #'as yet unclassified' }
PpEvent class >> exampleCopy [
	<gtExample>

	| e1 s1 u1 e2 l1 t1 p1 |
	e1 := PpEvent new.
	s1 := {1. 2. 3}.
	l1 := 'abcd'.
	u1 := e1 uuid.
	t1 := e1 transcript.
	p1 := e1 ppProject.
	e1 
		supportMaterials: s1;
		lepiterPageID: l1.
	e2 := e1 copy.
	self assert: e1 uuid equals: u1.
	self assert: e2 uuid ~= u1.
	self assert: s1 equals: e1 supportMaterials.
	self assert: s1 ~= e2 supportMaterials.
	self assert: l1 equals: e1 lepiterPageID.
	self assert: l1 ~= e2 lepiterPageID.
	self assert: t1 equals: e1 transcript.
	self assert: t1 ~= e2 transcript.
	self assert: p1 equals: e1 ppProject.
	self assert: p1 ~= e2 ppProject.
]

{ #category : #examples }
PpEvent class >> examplePointInTime [
	<gtExample>
	^ self
		given: [ PpEvent new ]
		when: [ :result |
			result participants 
				add: MpPerson exampleDumbledore;
				add: MpPerson exampleHarryPotter.
			result 
				title: 'Meeting';
				startDate: '4/5/2021' asDate; 	
				yourself ]
		then: [ :evt | evt startDate should equal: '4/5/2021' asDate translateToUTC ]
]

{ #category : #'instance creation' }
PpEvent class >> fromString: aString [
	"aString format: {date}? (@ {time})?, any other chars are considered the title"

	| tokens titlePart date prefixSize time |
	tokens := aString findTokens: Character separators.
	prefixSize := 0.
	titlePart := nil.
	[
		date := Date fromString: tokens first.
		prefixSize := tokens first size + 1.
		tokens second = '@' 
			ifTrue: [ 
				time := tokens third asTime.
				prefixSize := prefixSize + tokens third size + 3 ].
	]
		on: Error 
		do: [ date := Date today ].
		
	prefixSize < aString size ifTrue: [
		titlePart := (aString allButFirst: prefixSize) trimLeft ].
		
	^ self new
		title: titlePart;
		startDate: date;
		startTime: time;
		yourself
]

{ #category : #'instance creation' }
PpEvent class >> on: aDate [

	^ self new
		startDate: aDate;
		endDate: aDate;
		yourself
]

{ #category : #accessing }
PpEvent >> addressBook [
	^ MpAddressBook uniqueInstance
]

{ #category : #accessing }
PpEvent >> allEventsDo: aBlock [
	aBlock value: self.
	self children do: [ :child | child allEventsDo: aBlock ]
]

{ #category : #accessing }
PpEvent >> children [
	^ self propertyAt: #children ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #accessing }
PpEvent >> date [
	^ self startDate
]

{ #category : #accessing }
PpEvent >> date: aDate [

	self
		startDate: aDate;
		endDate: aDate
]

{ #category : #'as yet unclassified' }
PpEvent >> documentsImportAllFrom: aFolder [

	| nonHiddenFiles |
	nonHiddenFiles := aFolder allFiles reject: [ :e | e base isEmpty ].
	^ nonHiddenFiles collect: [ :file | 
		PpEventDocumentImport new
			event: self;
			file: file;
			yourself ]
]

{ #category : #accessing }
PpEvent >> duration [

	self end ifNil: [ ^ 0 ].

	^ self end - self start
]

{ #category : #accessing }
PpEvent >> end [

	self endDate ifNil: [ ^ nil ].
	self endTime ifNil: [ ^ nil ].

	^ DateAndTime date: self endDate time: self endTime.
]

{ #category : #accessing }
PpEvent >> endDate [
	^ self maLazyInstVarUsing: self endDateDescription
]

{ #category : #accessing }
PpEvent >> endDate: aDate [
	endDate := aDate translateToUTC
]

{ #category : #'magritte-accessing' }
PpEvent >> endDateDescription [
	<magritteDescription>

		^ MADateDescription new
		accessor: #endDate;
		priority: 400;
		default: self startDate;
		yourself
]

{ #category : #accessing }
PpEvent >> endTime [
	^ self maLazyInstVarUsing: self endTimeDescription
]

{ #category : #accessing }
PpEvent >> endTime: aTime [
	endTime := aTime
]

{ #category : #'magritte-accessing' }
PpEvent >> endTimeDescription [
	<magritteDescription>
	
	^ MATimeDescription new
		accessor: #endTime;
		priority: 500;
		yourself
]

{ #category : #accessing }
PpEvent >> eventLog [

	^ self
		propertyAt: #eventLog
		ifAbsent: [ PpEventLog uniqueInstance ]
]

{ #category : #accessing }
PpEvent >> eventLog: anEventLog [

	self eventLog = anEventLog ifTrue: [ ^ self ].

	^ self
		propertyAt: #eventLog
		putRemovingNil: anEventLog
]

{ #category : #accessing }
PpEvent >> events [
	^ self children
]

{ #category : #accessing }
PpEvent >> import [

	self eventLog add: self
]

{ #category : #accessing }
PpEvent >> importDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		gtIcon: BrGlamorousVectorIcons down;
		comment: 'Import into Singleton Library';
		action: #import;
		enableBlock: [ :evt | (PpEventLog uniqueInstance hasEvent: evt) not ];
		yourself
]

{ #category : #accessing }
PpEvent >> initialize [
	super initialize.
	self ensureUUID
]

{ #category : #testing }
PpEvent >> isInProgress [
	
	self isPast ifTrue: [ ^ false ].
	self startDate ifNil: [ ^ false ].
	self startDate > self today ifTrue: [ ^ false ].
	self startTime ifNotNil: [ :st | st > self now asTime ifTrue: [ ^ false ] ].
	^ true
]

{ #category : #testing }
PpEvent >> isPast [
	self endDate
		ifNil: [ self startDate < self today ifTrue: [ ^ true ].
			self startDate > self today ifTrue: [ ^ false ] ]
		ifNotNil: [ :ed | 
			ed < self today ifTrue: [ ^ true ].
			ed > self today ifTrue: [ ^ false ] ].
	^ self endTime ifNotNil: [ self endTime < self now asTime ] ifNil: [ false ]
]

{ #category : #testing }
PpEvent >> isPpValuedObject [
	^ true
]

{ #category : #accessing }
PpEvent >> location [
	^ self maLazyInstVarUsing: self locationDescription
]

{ #category : #accessing }
PpEvent >> location: aString [
	location := aString
]

{ #category : #'magritte-accessing' }
PpEvent >> locationDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		name: #location;
		accessor: #location;
		priority: 600;
		options: MpAddressBook uniqueInstance organizations asEntityCollection;
		yourself
]

{ #category : #playing }
PpEvent >> newPlayer [
	self hasRecording ifTrue: [ ^ self ensureRecording newPlayer ].
	self isInProgress ifFalse: [ ^ LlNullMediaPlayer new ].
	^ PpLivePlayer new
]

{ #category : #accessing }
PpEvent >> notes [
	^ self maLazyInstVarUsing: self notesDescription
]

{ #category : #accessing }
PpEvent >> notes: anObject [
	notes := anObject
]

{ #category : #accessing }
PpEvent >> notesAdd: convertibleToNote [
	^ self notes add: convertibleToNote asPpNote
]

{ #category : #magritte }
PpEvent >> notesDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
			accessor: #notes;
			label: 'Notes';
			priority: 700;
			default: OrderedCollection new;
			gtSearchDelegateTo: PpNote message: #peGtSpotterNewInstanceFor:;
			classes: { PpNote };
			yourself
]

{ #category : #testing }
PpEvent >> now [
	^ DateAndTime now translateToUTC
]

{ #category : #accessing }
PpEvent >> participants [
	^ self maLazyInstVarUsing: self participantsDescription
]

{ #category : #accessing }
PpEvent >> participants: anObject [
	participants := anObject
]

{ #category : #magritte }
PpEvent >> participantsDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
			accessor: #participants;
			priority: 625;
			kind: MpEntityCollection;
			default: MpEntityCollection new;
			classes: MpRelatableEntity allSubclasses;
			gtSearchSource: (MessageSend receiver: self selector: #addressBook);
			yourself
]

{ #category : #'as yet unclassified' }
PpEvent >> postCopy [

	super postCopy.
	
	self 
		postCopyProperties;
		postCopyDbDomainObject;
		postCopyTranscriptable;
		postCopyProjectProperty
]

{ #category : #accessing }
PpEvent >> printOn: aStream [
	self title 
		ifNotNil: [ :str | aStream nextPutAll: str ]
		ifNil: [ aStream nextPutAll: (self className allButFirst: 'Pp' size) normalizeCamelCase ].
	self startDate ifNotNil: [ :sDate |
		aStream
			nextPutAll: ' on ';
			nextPutAll: sDate mmddyyyy ].
	self location ifNotNil: [ :loc |
		aStream
			nextPutAll: ' at ';
			print: loc ].
	self participants ifNotNil: [ :people |
		aStream nextPutAll: ' with '.
		people
			do: [ :e | aStream nextPutAll: e fullName ]
			separatedBy: [ aStream nextPutAll: ', ' ] ].
		notes isEmptyOrNil ifFalse: [ 
			aStream
				nextPutAll: ': '.
			notes
				do: [ :n | aStream nextPutAll: n text asString ]
				separatedBy: [ aStream crlf ] ]
]

{ #category : #accessing }
PpEvent >> quLeSourceText [

	| dateString |
	dateString := self startDate monthName, ' ', self startDate dayOfMonth asString, ', ', self startDate year asString.
	^ self title, ', ', dateString
]

{ #category : #accessing }
PpEvent >> removeFromLog [

	self eventLog remove: self
]

{ #category : #accessing }
PpEvent >> start [
	(self startDate isNil or: [ self startTime isNil ]) ifTrue: [ ^ nil ].
	
	^ DateAndTime
		date: self startDate
		time: self startTime
]

{ #category : #accessing }
PpEvent >> startDate [
	^ self maLazyInstVarUsing: self startDateDescription
]

{ #category : #accessing }
PpEvent >> startDate: aDate [
	startDate := aDate translateToUTC
]

{ #category : #'magritte-accessing' }
PpEvent >> startDateDescription [

	<magritteDescription>
	^ MADateDescription new
		accessor: #startDate;
		priority: 200;
		yourself
]

{ #category : #accessing }
PpEvent >> startTime [
	^ self maLazyInstVarUsing: self startTimeDescription
]

{ #category : #accessing }
PpEvent >> startTime: aTime [
	startTime := aTime
]

{ #category : #'magritte-accessing' }
PpEvent >> startTimeDescription [
	<magritteDescription>

		^ MATimeDescription new
		accessor: #startTime;
		priority: 300;
		yourself
]

{ #category : #accessing }
PpEvent >> tags [

	^ self propertyAt: #tags ifAbsentPut: PpTagCollection new
]

{ #category : #accessing }
PpEvent >> title [
	^ self maLazyInstVarUsing: self titleDescription
]

{ #category : #accessing }
PpEvent >> title: aString [
	title := aString
]

{ #category : #'magritte-accessing' }
PpEvent >> titleDescription [

	<magritteDescription>
	^ MAStringDescription new
		  name: #title;
		  accessor: #title;
		  priority: 100;
		  default: (self className allButFirst: 'Pp' size) normalizeCamelCase;
		  yourself
]

{ #category : #testing }
PpEvent >> today [
	^ Date today translateToUTC
]

{ #category : #accessing }
PpEvent >> transcript [
	
	self hasRecording ifTrue: [ ^ self ensureRecording transcript ].
	^ self traitTranscript
]

{ #category : #accessing }
PpEvent >> transcriptGtViewFor: aView [
	<gtView>

	(self hasProperty: #transcript) ifFalse: [ ^ aView empty ].
	
	^ aView forward
		title: 'Transcript' translated;
		priority: 65;
		object: [ self transcript ];
		view: #gtLiveFor:.
]

{ #category : #'as yet unclassified' }
PpEvent >> worksGtViewOn: aView [
	<gtView>

	| works |
	works := self library works select: [ :w | w copies anySatisfy: [ :copy | copy source = self ] ].
	works ifEmpty: [ ^ aView empty ].
	
	^ aView list
		title: 'Works' translated;
		priority: 60;
		items: [ works ];
		actionUpdateButton
]
