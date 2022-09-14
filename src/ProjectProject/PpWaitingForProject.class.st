Class {
	#name : #PpWaitingForProject,
	#superclass : #PpProject,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpWaitingForProject class >> gtSpotterItemsFromString: aString [

	| waitees waiteeMatches waiteeString titleString |
	
	waitees := OrderedCollection with: nil.
	
	aString ifNotEmpty: [
		| parser nameParser titleParser |
		titleParser := 're: ' asPParser, #any asPParser plus flatten 
			==> [ :n | titleString := n second trimBoth ].
		nameParser := 're: ' asPParser not, #any asPParser starLazy flatten 
			==> [ :n | waiteeString := n second ].
		parser := (nameParser, #space asPParser, titleParser)
			/ nameParser
			/ titleParser.
		parser parse: aString ].
	
	waiteeString isEmptyOrNil ifFalse: [
		waiteeMatches := MpAddressBook uniqueInstance contacts 
			sorted: [ :a :b | (a fullName alike: aString) > (b fullName alike: aString) ].
		waitees addAll: (waiteeMatches first: 7) ].
	
	^ waitees collect: [ :waitee |
		| result |
		result := self new.
		waitee ifNotNil: [ result waitee: waitee ].
		titleString ifNotNil: [ result title: titleString ].
		result ].
]

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
			nextPutAll: ' re: ';
			nextPutAll: title ].
]

{ #category : #testing }
PpWaitingForProject >> isWaitingFor [
	^ true
]

{ #category : #accessing }
PpWaitingForProject >> titleDescription [

	| result parents |
	result := super titleDescription.
	parents := self parents.
	
	parents size = 1
		ifTrue: [ result default: parents atRandom title ].
		
	^ result
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

	self stakeholders 
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
