Class {
	#name : #PpOneNoteToEventVisitor,
	#superclass : #MsalOneNotePageVisitor,
	#instVars : [
		'event'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpOneNoteToEventVisitor >> event [
	^ event ifNil: [ event := PpEvent new ]
]

{ #category : #accessing }
PpOneNoteToEventVisitor >> visitCreationTimetamp: aDateAndTime [
	self event 
		startDate: aDateAndTime asDate;
		startTime: aDateAndTime asTime.
]

{ #category : #accessing }
PpOneNoteToEventVisitor >> visitID: aString [

	self event
		propertyAt: #oneNotePageID
		put: aString
]

{ #category : #accessing }
PpOneNoteToEventVisitor >> visitModificationTimestampUTC: aDateAndTime [

	| localOffset localStamp |
	localOffset := Locale localTimeZone offset.
	localStamp := aDateAndTime + localOffset.
	self event 
		endDate: localStamp asDate;
		endTime: localStamp asTime.
]

{ #category : #accessing }
PpOneNoteToEventVisitor >> visitTitle: aString [

	self event title: aString
]
