Class {
	#name : #PpWaitingForStatus,
	#superclass : #PpStatus,
	#instVars : [
		'person'
	],
	#category : #'ProjectProject-Core-Projects-Support'
}

{ #category : #accessing }
PpWaitingForStatus >> addressBook [
	^ MpAddressBook uniqueInstance
]

{ #category : #accessing }
PpWaitingForStatus >> isInactive [
	^ true
]

{ #category : #accessing }
PpWaitingForStatus >> person [

	^ person
]

{ #category : #accessing }
PpWaitingForStatus >> person: anObject [

	person := anObject
]

{ #category : #'magritte-descriptions' }
PpWaitingForStatus >> personDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #person;
		priority: 200;
		classes: MpRelatableEntity allSubclasses;
		gtSearchSource: (MessageSend receiver: self selector: #addressBook); 
		yourself
]

{ #category : #accessing }
PpWaitingForStatus >> printOn: aStream [
	
	super printOn: aStream
	"aStream
		space;
		print: person"
]
