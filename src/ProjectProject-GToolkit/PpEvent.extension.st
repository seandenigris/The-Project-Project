Extension { #name : #PpEvent }

{ #category : #'*ProjectProject-GToolkit' }
PpEvent class >> exampleTranscriptEmptyPage [
	<gtExample>
	^ self
		given: [ PpEventLog example ]
		when: [ :log |
			| page event |
				event := log events first.
				page := LePage quTranscriptOwnerID: event ensureUUID.
				LeDatabase new addPage: page.
				page type stub modelReference willReturn: (MADummyObjectUIDReferenceForTesting new
					source: log events;
					uid: event uuid;
					yourself).
					page ]
		then: [ :page | page snippets should haveSize: 1 ]
]
