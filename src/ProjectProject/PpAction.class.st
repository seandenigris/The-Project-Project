Class {
	#name : #PpAction,
	#superclass : #PpProject,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpAction >> defaultStatus [
	^ PpActiveStatus new
]

{ #category : #testing }
PpAction >> isAction [
	^ true
]

{ #category : #accessing }
PpAction >> isNextAction [
	
	self isComplete ifTrue: [ ^ false ].
	self isInactive ifTrue: [ ^ false ].
	
	^ self rootChildren allSatisfy: #isComplete
]
