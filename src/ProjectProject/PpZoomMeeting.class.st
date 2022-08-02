Class {
	#name : #PpZoomMeeting,
	#superclass : #PpEvent,
	#instVars : [
		'recordingFolder',
		'id',
		'audio',
		'video',
		'chatLog',
		'playlist'
	],
	#category : #'ProjectProject-Core-Events'
}

{ #category : #'instance creation' }
PpZoomMeeting class >> allFromRecordingsFolder [
	| rootFolder |
	rootFolder := FileLocator documents / 'Zoom'.
	^ rootFolder directories collect: [ :folder |
		self new
			recordingFolder: folder;
			yourself ]
]

{ #category : #examples }
PpZoomMeeting class >> example [
	<gtExample>
	^ self examplePointInTime
]

{ #category : #importing }
PpZoomMeeting class >> importAllRecorded [
	
	^ self allFromRecordingsFolder do: [ :evt |
		| resourceFields |
		PpEventLog uniqueInstance events add: evt.
		
		resourceFields := #(#audio #video #chatLog #playlist).
		resourceFields do: [ :sel |
			(evt perform: sel) ifNotNil: [ :res | res import ] ].
		
		evt recordingFolder delete ]
]

{ #category : #accessing }
PpZoomMeeting >> audio [

	^ audio
]

{ #category : #accessing }
PpZoomMeeting >> audio: anObject [

	audio := anObject
]

{ #category : #accessing }
PpZoomMeeting >> chatLog [

	^ chatLog
]

{ #category : #accessing }
PpZoomMeeting >> chatLog: anObject [

	chatLog := anObject
]

{ #category : #accessing }
PpZoomMeeting >> folderNameParser [
	| token time titleToken date idToken |
	token := #space asPParser negate plus flatten.
	date := token ==> [ :r | self startDate: r asDate ].
	time := token ==> [ :r | self startTime: (r copyReplaceAll: '.' with: ':') asTime ].
	titleToken := #any asPParser starLazy flatten ==> [ :r | self title: r ].
	idToken := #digit asPParser plus flatten ==> [ :r | self id: r asNumber ].
	^ (date , #space asPParser , time , titleToken , idToken) end
]

{ #category : #accessing }
PpZoomMeeting >> id [

	^ id
]

{ #category : #accessing }
PpZoomMeeting >> id: anObject [

	id := anObject
]

{ #category : #accessing }
PpZoomMeeting >> playlist [

	^ playlist
]

{ #category : #accessing }
PpZoomMeeting >> playlist: anObject [

	playlist := anObject
]

{ #category : #accessing }
PpZoomMeeting >> recordingFolder [

	^ recordingFolder
]

{ #category : #accessing }
PpZoomMeeting >> recordingFolder: aFileReference [
	recordingFolder := aFileReference.
	self folderNameParser parse: recordingFolder basename.
	self recordingFolder / 'audio_only.m4a' ifExists: [ :f | self audio: f asRlResource ].
	self recordingFolder / 'zoom_0.mp4' ifExists: [ :f | self video: f asRlResource ].
	self recordingFolder / 'chat.txt' ifExists: [ :f | self chatLog: f asRlResource ].
	self recordingFolder / 'playback.m3u' ifExists: [ :f | self playlist: f asRlResource ].
]

{ #category : #accessing }
PpZoomMeeting >> video [

	^ video
]

{ #category : #accessing }
PpZoomMeeting >> video: anObject [

	video := anObject
]
