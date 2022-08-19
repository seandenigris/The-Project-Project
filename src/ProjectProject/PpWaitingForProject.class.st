Class {
	#name : #PpWaitingForProject,
	#superclass : #PpProject,
	#instVars : [
		'person'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpWaitingForProject >> addressBook [
	^ MpAddressBook uniqueInstance
]

{ #category : #accessing }
PpWaitingForProject >> defaultStatus [
	^ PpWaitingForStatus new
]

{ #category : #accessing }
PpWaitingForProject >> displayStringOn: aStream [

	aStream nextPutAll: 'W/F: '.
	
	person ifNotNil: [ aStream print: person ].
	
	title ifNotNil: [ 
		aStream 
			nextPutAll: ' re ';
			nextPutAll: title ].
]

{ #category : #accessing }
PpWaitingForProject >> person [

	^ person
]

{ #category : #accessing }
PpWaitingForProject >> person: anObject [

	person := anObject
]

{ #category : #accessing }
PpWaitingForProject >> personDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #person;
		priority: 200;
		classes: MpRelatableEntity allSubclasses;
		gtSearchSource: (MessageSend receiver: self selector: #addressBook); 
		yourself
]
