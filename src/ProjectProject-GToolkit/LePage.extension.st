Extension { #name : #LePage }

{ #category : #'*ProjectProject-GToolkit' }
LePage class >> journalOn: aDate [

	| type result |
	
	result := self new.
		
	type := PpLeDailyPageType 
		date: aDate 
		page: result.
	
	^ result
		type: type;
		yourself
]
