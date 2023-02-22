Trait {
	#name : #PpTMutableProjectContainer,
	#category : #'ProjectProject-Core-Projects-Support'
}

{ #category : #spotter }
PpTMutableProjectContainer >> childrenNewSearches [
	
	^ PpValue withAllSubclasses collect: [ :cls |
		GtSpotterProtoSearch new list
			title: 'New ' , cls name;
			priority: 50;
			itemName: #gtSpotterText;
			items: [ {} asAsyncStream ];
			filter: (PeGtInstancesFilter new
					rootClass: cls;
					yourself);
			send: [ :result | self ensureChild: result ] ]
				
	 "Implementation note:
	- first tried to have all subclasses under one heading, but then realized that there are multiple axes for classes like PpContactAction - class, strategy and receiver, so suggesting multiple receivers under its own category seems more helpful"
]

{ #category : #accessing }
PpTMutableProjectContainer >> ensureChild: aPpProject [
	self subclassResponsibility
]

{ #category : #spotter }
PpTMutableProjectContainer >> gtSpotterSearchesInContext: aSpotterContext [
	| pragmaSearches |
	pragmaSearches := super gtSpotterSearchesInContext: aSpotterContext.
	^ pragmaSearches merge: self childrenNewSearches asAsyncStream
]

{ #category : #accessing }
PpTMutableProjectContainer >> masterList [
	self explicitRequirement
]
