Class {
	#name : #PpOneNoteToProjectVisitor,
	#superclass : #MsalOneNotePageVisitor,
	#instVars : [
		'project',
		'note'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpOneNoteToProjectVisitor >> application [
	^ self note application
]

{ #category : #accessing }
PpOneNoteToProjectVisitor >> note [
	^ note
]

{ #category : #accessing }
PpOneNoteToProjectVisitor >> note: aPage [
	note := aPage
]

{ #category : #accessing }
PpOneNoteToProjectVisitor >> project [
	^ project ifNil: [ project := PpProject new ]
]

{ #category : #accessing }
PpOneNoteToProjectVisitor >> visitCreationTimetamp: aDateAndTime [
	self project status timestamp: aDateAndTime.
]

{ #category : #accessing }
PpOneNoteToProjectVisitor >> visitImageElement: anXMLElement [
	| url resource |
	(anXMLElement attributeAt: 'data-src-type') = 'image/png' ifFalse: [ self error: 'only handles pngs' ].
	
	url := (anXMLElement attributeAt: #src) asUrl.
	
	resource := self application
		get: url
		contentReader: [ :r | 
			| file |
			file := Tempfile withSuffix: '.png'.
			file
				binaryWriteStreamDo: [ :str | str nextPutAll: r contents ];
				asRlResource ].
				
	self project supportMaterials add: resource.
]

{ #category : #accessing }
PpOneNoteToProjectVisitor >> visitTitle: aString [

	self project title: aString
]
