Extension { #name : #PpEvent }

{ #category : #'*ProjectProject-GToolkit' }
PpEvent class >> exampleTranscriptEmptyPage [
	<gtExample>
	^ self
		given: [ PpEventLog example ]
		when: [ :log |
			| page event |
				event := log events first.
				page := LePage quTranscriptOwner: event.
				LeDatabase new addPage: page.
				page type stub subjectModelReference willReturn: (OlDummyObjectUIDReferenceForTesting new
					source: log events;
					uid: event uuid;
					yourself).
					page ]
		then: [ :page | page "children should haveSize: 1" ]
]

{ #category : #'*ProjectProject-GToolkit' }
PpEvent >> newLepiterPage [
	^ LePage quTranscriptOwner: self
]
