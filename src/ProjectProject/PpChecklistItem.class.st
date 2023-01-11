Class {
	#name : #PpChecklistItem,
	#superclass : #Object,
	#instVars : [
		'isComplete',
		'description'
	],
	#category : #'ProjectProject-Core-Checklists'
}

{ #category : #Morphic }
PpChecklistItem >> asMorph [
	^ PpChecklistItemMorph new
		model: self;
		yourself
]

{ #category : #accessing }
PpChecklistItem >> description [
	^ description
]

{ #category : #accessing }
PpChecklistItem >> description: anObject [
	description := anObject
]

{ #category : #'accessing-magritte' }
PpChecklistItem >> descriptionDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #description;
		priority: 100;
		yourself
]

{ #category : #accessing }
PpChecklistItem >> isComplete [
	^ isComplete ifNil: [ false ]
]

{ #category : #accessing }
PpChecklistItem >> isComplete: anObject [
	isComplete := anObject
]

{ #category : #'accessing-magritte' }
PpChecklistItem >> isCompleteDescription [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #isComplete;
		label: 'Complete?';
		priority: 200;
		yourself
]

{ #category : #accessing }
PpChecklistItem >> markdownString [

	| bullet |
	bullet := self isComplete
		ifTrue: [ '[x]' ]
		ifFalse: [ '[ ]' ].
	^ bullet, ' ', self description
]

{ #category : #printing }
PpChecklistItem >> printOn: aStream [
	aStream nextPutAll: description.
	self isComplete
		ifFalse: [ aStream nextPutAll: ' (I)' ]
		ifTrue: [ aStream nextPutAll: ' (C)' ]
]
