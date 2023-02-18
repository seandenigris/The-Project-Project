"
PpPhoneCall new maEdit
"
Class {
	#name : #PpPhoneCall,
	#superclass : #PpEvent,
	#category : #'ProjectProject-Core-Events'
}

{ #category : #examples }
PpPhoneCall class >> example [
	<gtExample>
	^ self examplePointInTime
]

{ #category : #conversion }
PpPhoneCall >> asPpProject [

	| result strategy |
	strategy := PpContactStrategy all detect: [ :strat | 
		strat class modelClass = self class ].
	
	self participants size > 1 ifTrue: [
		self error: 'Contact actions only have one receiver' ].
	
	result := PpContactAction new
		title: self title;
		strategy: strategy;
		receiver: self participants first;
		yourself.
		
	result supportMaterials add: self.
	
	self end ifNotNil: [ :endTimestamp |
		result log removeAll.
		result beComplete.
		result status timestamp: self end ].

	^ result
]
