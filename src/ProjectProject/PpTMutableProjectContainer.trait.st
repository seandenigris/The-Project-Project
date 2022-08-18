Trait {
	#name : #PpTMutableProjectContainer,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpTMutableProjectContainer >> addChild: aPpProject [
	self subclassResponsibility
]

{ #category : #accessing }
PpTMutableProjectContainer >> gtSpotterNew: aClass in: aPpProjectList for: aStep [
	
	aStep listProcessor
		title: 'New ', aClass label;
		priority: 50;
		itemName: [ :input | 'New ', aClass label, ': ', input ];
		previewObject: [ :input | aClass fromString: input ];
		"allCandidates: [ MpAddressBook uniqueInstance contacts ];"
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :cntxt | 
				| isExisting |
				isExisting := aPpProjectList rootChildren anySatisfy: [ :e | 
					e title = cntxt textTrimmed ].
				isExisting ifFalse: [ 
					filter value: cntxt textTrimmed ] ];
		send: [ :input :spotterStep |
			| result |
			result := aClass fromString: input.
			self addChild: result  ]
]

{ #category : #accessing }
PpTMutableProjectContainer >> gtSpotterNewChildFor: aStep [
	<gtSearch>
	
	PpProject withAllSubclassesDo: [ :cls |
		self 
			gtSpotterNew: cls 
			in: self masterList
			for: aStep ]
]

{ #category : #accessing }
PpTMutableProjectContainer >> masterList [
	self explicitRequirement
]
