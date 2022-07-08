Trait {
	#name : #PpTMutableProjectContainer,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpTMutableProjectContainer >> addChild: aPpProject [
	self subclassResponsibility
]

{ #category : #accessing }
PpTMutableProjectContainer >> gtSpotterNewChildIn: aPpProjectList labeled: aString for: aStep [
	
	aStep listProcessor
		title: 'New ', aString;
		priority: 50;
		itemName: [ :input | 'Create new ', aString, ': ', input ];
		previewObject: [ :input | PpProject new title: input; yourself ];
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
			result := PpProject new title: input; yourself.
			self addChild: result  ]
]
