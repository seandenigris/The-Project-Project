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
	#category : 'ProjectProject-Core'
}

{ #category : #accessing }
PpTag class >> db [
	^ PpTagCollection uniqueInstance
]

{ #category : #convenience }
PpTag class >> ensureNamed: aString [ 
	^ self db tags
			detect: [ :e | e name = aString ]
			ifNone: [ self db addTagNamed: aString ]
]

{ #category : #'instance creation' }
PpTag class >> named: aString [ 
	^ PpTag new
		name: aString;
		yourself
]

{ #category : #persistence }
PpTag class >> restoreFrom: anObject [

	PpTagCollection uniqueInstance: anObject.
]

{ #category : #persistence }
PpTag class >> spData [
	^ PpTagCollection uniqueInstance
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
