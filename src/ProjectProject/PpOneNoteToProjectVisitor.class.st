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
PpOneNoteToProjectVisitor >> visitImageBytes: aByteArray [
	
	| file resource readerClass extension |
	readerClass := ImageReadWriter readerClassFromStream: aByteArray readStream.
	extension := readerClass typicalFileExtensions first.
	file := Tempfile withSuffix: '.', extension.
	resource := file
		binaryWriteStreamDo: [ :str | str nextPutAll: aByteArray ];
		asRlResource.
				
	self project supportMaterials add: resource.
]

{ #category : #accessing }
PpOneNoteToProjectVisitor >> visitTitle: aString [

	self project title: aString
]