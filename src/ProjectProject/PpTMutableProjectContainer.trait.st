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
	
	PpProject withAllSubclassesDo: [ :cls |
		aStep listProcessor
			title: 'New ', cls name;
			priority: 50;
			itemName: #gtSpotterText;
			wantsToDisplayOnEmptyQuery: false;
			filter: (PeGtInstancesFilter new
				rootClass: cls;
				yourself);
			send: [ :result :spotterStep |
				self addChild: result  ] ].
				
	"Implementation note:
	- first tried to have all subclasses under one heading, but then realized that there are multiple axes for classes like PpContactAction - class, strategy and receiver, so suggesting multiple receivers under its own category seems more helpful"
]

{ #category : #accessing }
PpTMutableProjectContainer >> masterList [
	self explicitRequirement
]
