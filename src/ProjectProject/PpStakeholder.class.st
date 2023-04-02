Class {
	#name : #PpStakeholder,
	#superclass : #Object,
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#instVars : [
		'project',
		'person',
		'role'
	],
	#category : #'ProjectProject-Core-Projects-Support'
}

{ #category : #accessing }
PpStakeholder class >> gtSpotterItemsFromString: aString [

	| receiver result nameParser parser nameAndRole |
	
	result := self new.
	
	nameParser := $@ asPParser negate starLazy flatten.
	parser := nameParser, (#space asPParser plus, $@ asPParser, #any asPParser plus flatten ==> #third) optional.
	nameAndRole := parser parse: aString.
	
	receiver := MpAddressBook uniqueInstance contacts 
		detectMax: [ :e | e fullName alike: nameAndRole first ].
	result person: receiver.
	nameAndRole size > 1 ifTrue: [ result role: nameAndRole second ].
	
	^ { result }
]

{ #category : #accessing }
PpStakeholder class >> peCanHandleFromString: aString [
	^ true
]

{ #category : #accessing }
PpStakeholder class >> project: aProject person: aPerson role: titleString [

	^ self new
		project: aProject;
		person: aPerson;
		role: titleString;
		yourself
]

{ #category : #accessing }
PpStakeholder >> = rhs [
	
	(rhs isKindOf: self class) ifFalse: [ ^ false ].
	
	^ self project = rhs project and: [ self person = rhs person and: [ self role = rhs role ] ]
]

{ #category : #accessing }
PpStakeholder >> addressBook [

	^ self propertyAt: #addressBook ifAbsent: [ MpAddressBook uniqueInstance ]
]

{ #category : #accessing }
PpStakeholder >> displayStringNoProject [

	^ self role, ' => ', self person displayString
]

{ #category : #accessing }
PpStakeholder >> hash [
	^ self project hash bitXor: (self person hash bitXor: self role hash)
]

{ #category : #accessing }
PpStakeholder >> link [
	self project stakeholders add: self.
]

{ #category : #accessing }
PpStakeholder >> person [

	^ person
]

{ #category : #accessing }
PpStakeholder >> person: anObject [

	person := anObject
]

{ #category : #magritte }
PpStakeholder >> personDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #person;
		priority: 200;
		classes: MpRelatableEntity allSubclasses;
		gtSearchSource: (MessageSend receiver: self selector: #addressBook); 
		yourself
]

{ #category : #accessing }
PpStakeholder >> printOn: aStream [

	aStream
		print: self project;
		space;
		nextPutAll: self role;
		space;
		print: self person
]

{ #category : #accessing }
PpStakeholder >> project [

	^ project
]

{ #category : #accessing }
PpStakeholder >> project: anObject [

	project := anObject
]

{ #category : #accessing }
PpStakeholder >> role [

	^ role ifNil: [ #stakeholder ]
]

{ #category : #accessing }
PpStakeholder >> role: anObject [

	role := anObject
]

{ #category : #accessing }
PpStakeholder >> unlink [
	self project stakeholders remove: self
]
