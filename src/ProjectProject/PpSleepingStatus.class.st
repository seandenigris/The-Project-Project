Class {
	#name : #PpSleepingStatus,
	#superclass : #PpStatus,
	#instVars : [
		'wakeupDate'
	],
	#category : #'ProjectProject-Core-Projects-Support'
}

{ #category : #testing }
PpSleepingStatus >> isActive [
	
	self wakeupDate ifNil: [ ^ false ].

	^ DateAndTime now >= self wakeupDate
]

{ #category : #testing }
PpSleepingStatus >> isInactive [
	^ self isActive not
]

{ #category : #accessing }
PpSleepingStatus >> wakeupDate [

	^ wakeupDate
]

{ #category : #accessing }
PpSleepingStatus >> wakeupDate: anObject [

	wakeupDate := anObject
]

{ #category : #accessing }
PpSleepingStatus >> wakeupDateDescription [
	<magritteDescription>
	
	^ MADateDescription new
		accessor: #wakeupDate;
		priority: 100;
		beRequired;
		yourself
]
