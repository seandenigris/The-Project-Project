Class {
	#name : 'PpCompleteNotDoneStatus',
	#superclass : 'PpStatus',
	#category : 'ProjectProject-Core-Projects-Support',
	#package : 'ProjectProject',
	#tag : 'Core-Projects-Support'
}

{ #category : 'accessing' }
PpCompleteNotDoneStatus class >> label [
	^ 'Complete (Not Done)'
]

{ #category : 'testing' }
PpCompleteNotDoneStatus >> isComplete [
	^ true
]
