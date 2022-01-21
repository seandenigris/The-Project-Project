Class {
	#name : #PpTranscript,
	#superclass : #Object,
	#instVars : [
		'lines',
		'pageID'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #accessing }
PpTranscript >> lines [

	^ lines ifNil: [ lines := SortedCollection sortUsing: #position ascending undefinedFirst ]
]

{ #category : #accessing }
PpTranscript >> lines: anObject [

	lines := anObject
]

{ #category : #accessing }
PpTranscript >> pageID [

	^ pageID
]

{ #category : #accessing }
PpTranscript >> pageID: anObject [

	pageID := anObject
]
