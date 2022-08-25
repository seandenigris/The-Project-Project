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
PpStakeholder class >> project: aProject person: aPerson role: titleString [

	^ self new
		project: aProject;
		person: aPerson;
		role: titleString;
		yourself
]

{ #category : #accessing }
PpStakeholder >> = rhs [
	^ self project = rhs project and: [ self person = rhs person and: [ self role = rhs role ] ]
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
