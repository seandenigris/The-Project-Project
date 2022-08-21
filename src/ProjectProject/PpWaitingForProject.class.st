Class {
	#name : #PpWaitingForProject,
	#superclass : #PpProject,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpWaitingForProject >> defaultStatus [
	^ PpWaitingForStatus new
]

{ #category : #accessing }
PpWaitingForProject >> displayStringOn: aStream [

	aStream nextPutAll: 'W/F: '.
	
	self waitee ifNotNil: [ :w | aStream print: w ].
	
	title ifNotNil: [ 
		aStream 
			nextPutAll: ' re ';
			nextPutAll: title ].
]

{ #category : #accessing }
PpWaitingForProject >> waitee [

	^ self stakeholders 
		detect: [ :e | e role = #waitee ]
		ifFound: [ :e | e person ]
		ifNone: [ nil ]
]

{ #category : #accessing }
PpWaitingForProject >> waitee: aPerson [

	^ self stakeholders 
		detect: [ :e | e role = #waitee ]
		ifFound: [ :e | e person: aPerson ]
		ifNone: [ (PpStakeholder project: self person: aPerson role: #waitee) link ]
]

{ #category : #accessing }
PpWaitingForProject >> waiteeDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #waitee;
		priority: 200;
		classes: MpRelatableEntity allSubclasses;
		gtSearchSource: (MessageSend receiver: self selector: #addressBook); 
		yourself
]
