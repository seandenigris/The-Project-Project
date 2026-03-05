Class {
	#name : 'PpInboxStatus',
	#superclass : 'PpStatus',
	#category : 'ProjectProject-Core-Projects-Support',
	#package : 'ProjectProject',
	#tag : 'Core-Projects-Support'
}

{ #category : 'accessing' }
PpInboxStatus >> isInbox [
	^ true
]

{ #category : 'as yet unclassified' }
PpInboxStatus >> ppTimelineStamp [
	
	^ self timestamp
]
