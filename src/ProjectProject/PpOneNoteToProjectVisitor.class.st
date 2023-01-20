Class {
	#name : #PpOneNoteToProjectVisitor,
	#superclass : #MsalOneNotePageVisitor,
	#instVars : [
		'project'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpOneNoteToProjectVisitor >> project [
	^ project ifNil: [ project := PpProject new ]
]

{ #category : #accessing }
PpOneNoteToProjectVisitor >> visitCreationTimetamp: aDateAndTime [
	self project status timestamp: aDateAndTime.
]

{ #category : #accessing }
PpOneNoteToProjectVisitor >> visitImage: anRlResource [
				
	self project supportMaterials add: anRlResource import.
]

{ #category : #accessing }
PpOneNoteToProjectVisitor >> visitTitle: aString [

	self project title: aString
]
