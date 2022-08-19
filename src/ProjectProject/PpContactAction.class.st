Class {
	#name : #PpContactAction,
	#superclass : #PpAction,
	#instVars : [
		'strategy',
		'receiver'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #'instance creation' }
PpContactAction class >> fromString: aString [
	| strategy personName |
	strategy := PpContactStrategy allSubclasses 
		detect: [ :stratCls | 
			aString 
				beginsWith: stratCls label 
				caseSensitive: false ]
		ifFound: [ :stratCls |
			personName := (aString allButFirst: stratCls label size) trimLeft.
			stratCls new ]
		ifNone: [ 
			personName := aString.
			nil ].
		
	
	^ self new
		strategy: strategy;
		yourself
]

{ #category : #accessing }
PpContactAction >> addressBook [
	^ MpAddressBook uniqueInstance
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
	receiver ifNotNil: [ aStream print: receiver ].
	
	title ifNotNil: [ 
		aStream 
			nextPutAll: ' re ';
			nextPutAll: title ].
]

{ #category : #accessing }
PpContactAction >> person [
	^ self receiver
]

{ #category : #accessing }
PpContactAction >> receiver [

	^ receiver
]

{ #category : #accessing }
PpContactAction >> receiver: anObject [

	receiver := anObject
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
