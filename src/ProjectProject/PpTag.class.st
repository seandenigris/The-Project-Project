"
### Create Child Tag
```
parent := PpTag detectNamed: 'Fire Department'.
tag := PpTag ensureNamed: 'Health & Safety'.
parent children add: tag
```
"
Class {
	#name : #PpTag,
	#superclass : #Object,
	#instVars : [
		'name',
		'children'
	],
	#classInstVars : [
		'db'
	],
	#category : 'ProjectProject-Core'
}

{ #category : #private }
PpTag class >> addTagNamed: aString [
	| tag |
	tag := self new
		name: aString;
		yourself.
	^ self db add: tag
]

{ #category : #accessing }
PpTag class >> db [
	^ db ifNil: [ db := Bag new ]
]

{ #category : #accessing }
PpTag class >> detectNamed: aString [ 
	^ self db detect: [ :e | e name = aString ]
]

{ #category : #accessing }
PpTag class >> ensureNamed: aString [ 
	^ self db
			detect: [ :e | e name = aString ]
			ifNone: [ self addTagNamed: aString ]
]

{ #category : #persistence }
PpTag class >> restoreFrom: anObject [

	db := anObject.
]

{ #category : #persistence }
PpTag class >> spData [
	^ self db
]

{ #category : #accessing }
PpTag >> children [
	^ children ifNil: [ children := OrderedCollection new ]
]

{ #category : #accessing }
PpTag >> children: anObject [
	children := anObject
]

{ #category : #accessing }
PpTag >> name [
	^ name
]

{ #category : #accessing }
PpTag >> name: aString [
	name := aString
]

{ #category : #printing }
PpTag >> printOn: aStream [
	aStream nextPut: $#.
	name ifNotNil: [ aStream nextPutAll: name ]
]
