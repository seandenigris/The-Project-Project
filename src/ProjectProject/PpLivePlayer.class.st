Class {
	#name : 'PpLivePlayer',
	#superclass : 'Object',
	#category : 'ProjectProject-Core-Events-Support',
	#package : 'ProjectProject',
	#tag : 'Core-Events-Support'
}

{ #category : 'accessing' }
PpLivePlayer >> currentPosition [
	^ DateAndTime now translateToUTC
]
