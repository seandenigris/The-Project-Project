Class {
	#name : #PpContactAction,
	#superclass : #PpAction,
	#instVars : [
		'strategy'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #'instance creation' }
PpContactAction class >> fromString: aString [
	| title result |
	
	result := self new.
	
	title := PpContactStrategy allSubclasses 
		detect: [ :stratCls | 
			aString 
				beginsWith: stratCls label 
				caseSensitive: false ]
		ifFound: [ :stratCls |
			result strategy: stratCls new.
			(aString allButFirst: stratCls label size) trimLeft. ]
		ifNone: [ aString ].
	
	title ifNotEmpty: [ result title: title ].	
	
	^ result
]

{ #category : #accessing }
PpContactAction >> completeAndWait [
	self status: PpCompleteStatus new.
	self parents do: [ :p |
		| waitingFor |
		waitingFor := PpWaitingForProject new
			title: self title;
			person: self receiver;
			yourself.
			
		p addChild: waitingFor ]
]

{ #category : #accessing }
PpContactAction >> defaultStatus [
	^ PpActiveStatus new
]

{ #category : #accessing }
PpContactAction >> displayStringOn: aStream [

	strategy ifNotNil: [ 
		aStream 
			nextPutAll: self strategy class label;
			space ].
	self receiver ifNotNil: [ aStream print: self receiver ].
	
	self title ifNotNil: [ :ttl |
		aStream 
			nextPutAll: ' re: ';
			nextPutAll: ttl ].
]

{ #category : #accessing }
PpContactAction >> receiver [

	^ self stakeholders 
		detect: [ :e | e role = #receiver ]
		ifFound: [ :e | e person ]
		ifNone: [ nil ]
]

{ #category : #accessing }
PpContactAction >> receiver: aPerson [

	^ self stakeholders 
		detect: [ :e | e role = #receiver ]
		ifFound: [ :e | e person: aPerson ]
		ifNone: [ (PpStakeholder project: self person: aPerson role: #receiver) link ]
]

{ #category : #accessing }
PpContactAction >> receiverDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #receiver;
		priority: 200;
		classes: MpRelatableEntity allSubclasses;
		gtSearchSource: (MessageSend receiver: self selector: #addressBook); 
		yourself
]

{ #category : #accessing }
PpContactAction >> strategy [

	^ strategy
]

{ #category : #accessing }
PpContactAction >> strategy: anObject [

	strategy := anObject
]

{ #category : #accessing }
PpContactAction >> strategyDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #strategy;
		priority: 250;
		morphicClass: MAMorphicDropList;
		options: PpContactStrategy all;
		default: PpContactStrategy all first;
		yourself
]

{ #category : #accessing }
PpContactAction >> titleDescription [

	| result parents |
	result := super titleDescription.
	parents := self parents.
	
	parents size = 1
		ifTrue: [ result default: parents atRandom title ].
		
	^ result
]
