Trait {
	#name : #PpTMutableProjectContainer,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpTMutableProjectContainer >> addChild: aPpProject [
	self subclassResponsibility
]

{ #category : #spotter }
PpTMutableProjectContainer >> childrenNewGtSpotterFor: aStep [
	<gtSearch>
	
	aStep listProcessor
		title: 'New child';
		priority: 50;
		itemName: #gtSpotterText;
		wantsToDisplayOnEmptyQuery: false;
		filter: (PeGtSubInstancesFilter new
			rootClass: PpProject;
			yourself);
		send: [ :result :spotterStep |
			self addChild: result  ]
]

{ #category : #accessing }
PpTMutableProjectContainer >> masterList [
	self explicitRequirement
]
