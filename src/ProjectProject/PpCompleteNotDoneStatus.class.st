Class {
	#name : #PpCompleteNotDoneStatus,
	#superclass : #PpStatus,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpCompleteNotDoneStatus class >> label [
	^ 'Complete (Not Done)'
]

{ #category : #testing }
PpCompleteNotDoneStatus >> isComplete [
	^ true
]
