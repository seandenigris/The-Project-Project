Class {
	#name : #PpContactAction,
	#superclass : #PpAction,
	#instVars : [
		'strategy'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpContactAction class >> gtSpotterItemsFromString: aString [

	| receivers receiverString receiverMatches strategies |
	
	receivers := OrderedCollection with: nil.
	strategies := OrderedCollection with: nil.
	
	receiverString := PpContactStrategy allSubclasses 
		detect: [ :stratCls | 
			aString 
				beginsWith: stratCls label 
				caseSensitive: false ]
		ifFound: [ :stratCls |
			strategies add: stratCls new.
			(aString allButFirst: stratCls label size) trimLeft. ]
		ifNone: [ aString ].
	
	receiverString ifNotEmpty: [
		receiverMatches := MpAddressBook uniqueInstance contacts 
			sorted: [ :a :b | (a fullName alike: aString) > (b fullName alike: aString) ].
		receivers addAll: (receiverMatches first: 7).
		"if we want to handle a new/unknown person
		receiverMatches first = aString ifFalse: [ 
			| loc |
			loc := PpInventoryItem named: aString.
			receiverMatches add: loc ]" ].
	
	^ strategies flatCollect: [ :strat |
		receivers collect: [ :rec |
			self new
				strategy: strat;
				receiver: rec;
				yourself ] ].
				
	"Implementation note:
	- tried to have all e.g. receivers available, but too slow
	- tried to have all strategies available when none specified, but too confusing"
]

{ #category : #accessing }
PpContactAction >> completeAndWait [

	| waitingFor |
	self status: PpCompleteStatus new.
	self flag: 'why not #beComplete? What about children?'.
	
	waitingFor := PpWaitingForProject new
		title: self title;
		waitee: self receiver;
		yourself.
			
	self parents do: [ :p | p addChild: waitingFor ]
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
PpContactAction >> doIt [
	CwMacMail new
		newMessageTo: self receiver fullName 
		at: self receiver emailAddresses atRandom address 
		re: self title asFollows: ''
]

{ #category : #accessing }
PpContactAction >> gtSpotterText [

	^ String streamContents: [ :str |
		self printStrategyOn: str.
		str 
			<< ' action: '
			<< self displayString ].
		
]

{ #category : #accessing }
PpContactAction >> printStrategyOn: aStream [

	strategy ifNotNil: [ 
		aStream 
			nextPutAll: self strategy class label;
			space ].
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

	| result |
	result := super titleDescription.
	self parents ifNotEmpty: [ :parents |
		| defTitle |
		defTitle := String streamContents: [ :str |
			parents
				do: [ :proj | str << proj title ]
				separatedBy: [ str nextPutAll: '; ' ] ].
		result default: defTitle ].
		
	^ result
]
