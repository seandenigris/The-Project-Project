"
self new maEdit
"
Class {
	#name : #PpNote,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'text'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #'todo list' }
PpNote class >> showTodoList [
	<script>
	self todoList open
]

{ #category : #'todo list' }
PpNote class >> todoList [
	^ FileLocator home / 'Dropbox (Personal)' / ' Emergency TODO List.rtf'
]

{ #category : #defaults }
PpNote >> defaultTimestamp [
	"Pharo's Date offset support is fatally broken. See [Pharo Issue 12147: Date>>#= fooled by daylight savings time](https://pharo.fogbugz.com/default.asp?12147)"
	^ DateAndTime now translateToUTC
]

{ #category : #magritte }
PpNote >> noteDescription [
	<magritteDescription>
	
	^ MAMemoDescription new
			accessor: #text;
			priority: 200;
"			default: DateAndTime now;"
			beRequired;
			yourself
]

{ #category : #printing }
PpNote >> printOn: aStream [
	aStream
		nextPutAll: self text;
		nextPutAll: ' (';
		nextPutAll: self timestamp asDate mmddyyyy, ' ', self timestamp asTime printMinutes;
		nextPut: $)
]

{ #category : #accessing }
PpNote >> text [
	^ text
]

{ #category : #accessing }
PpNote >> text: anObject [
	text := anObject
]

{ #category : #accessing }
PpNote >> timestamp [
	^ timestamp
]

{ #category : #accessing }
PpNote >> timestamp: anObject [
	timestamp := anObject
]

{ #category : #magritte }
PpNote >> timestampDescription [
	<magritteDescription>
	
	^ MADateAndTimeDescription new
			accessor: #timestamp;
			label: 'Timestamp';
			priority: 100;
			default: self defaultTimestamp;
			display: [ :e | e asDate mmddyyyy, ' ', e asTime printMinutes ];
			beRequired;
			yourself
]
