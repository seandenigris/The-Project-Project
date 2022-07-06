Trait {
	#name : #PpTProjectContainer,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpTProjectContainer >> gtSpotterNewProjectIn: aPpProjectList labeled: aString for: aStep [
	
	aStep listProcessor
		title: 'New ', aString;
		priority: 50;
		itemName: [ :input | 'Create new ', aString, ': ', input ];
		previewObject: [ :input | PpProject new title: input; yourself ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := aPpProjectList children anySatisfy: [ :e | 
					e title = context textTrimmed ].
				isExisting ifFalse: [ 
					filter value: context textTrimmed ] ];
		send: [ :input :spotterStep |
			| result |
			result := PpProject new title: input; yourself.
			self children add: result  ]
]
