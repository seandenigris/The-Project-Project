Extension { #name : #RlEmail }

{ #category : #'*ProjectProject' }
RlEmail >> asPpProject [

	| result |
	result := PpContactAction new
		title: self subject;
		yourself.
	result supportMaterials add: self.
	result log removeAll.
	result beComplete.
	self flag: 'Match recipients to MpContacts'.
	result status timestamp: self timestamp.
	^ result
]

{ #category : #'*ProjectProject' }
RlEmail >> ppTimelineStamp [

	^ self timestamp
]
