"
PpPhoneCall new maEdit
"
Class {
	#name : #PpPhoneCall,
	#superclass : #Object,
	#instVars : [
		'participants',
		'notes',
		'start',
		'end'
	],
	#category : 'ProjectProject-Core'
}

{ #category : #magritte }
PpPhoneCall >> descriptionEnd [
	<magritteDescription>
	
	^ MADateAndTimeDescription new
			accessor: #end;
			label: 'End';
			priority: 160;
			yourself
]

{ #category : #magritte }
PpPhoneCall >> descriptionNotes [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
			accessor: #notes;
			label: 'Notes';
			priority: 200;
			default: OrderedCollection new;
			classes: { PpNote };
			yourself
]

{ #category : #magritte }
PpPhoneCall >> descriptionParticipants [
	<magritteDescription>
	
	^ MAMultipleOptionDescription new
			accessor: #participants;
			label: 'Participants';
			priority: 100;
			default: OrderedCollection new;
			options: PpLifeHistory mine addressBook;
			yourself
]

{ #category : #magritte }
PpPhoneCall >> descriptionStart [
	<magritteDescription>
	
	^ MADateAndTimeDescription new
			accessor: #start;
			label: 'Start';
			priority: 130;
			yourself
]

{ #category : #accessing }
PpPhoneCall >> end [
	^ end
]

{ #category : #accessing }
PpPhoneCall >> end: anObject [
	end := anObject
]

{ #category : #accessing }
PpPhoneCall >> notes [
	^ notes
]

{ #category : #accessing }
PpPhoneCall >> notes: anObject [
	notes := anObject
]

{ #category : #accessing }
PpPhoneCall >> participants [
	^ participants
]

{ #category : #accessing }
PpPhoneCall >> participants: anObject [
	participants := anObject
]

{ #category : #printing }
PpPhoneCall >> printOn: aStream [
	aStream
		nextPutAll: 'Phone call'.
	self participants ifNotNil: [ :people |
		aStream nextPutAll: ' with '.
		people
			do: [ :e | aStream nextPutAll: e name ]
			separatedBy: [ aStream nextPutAll: ' & ' ] ].
		notes ifNotNil: [ 
			aStream
				nextPutAll: ': '.
			notes
				do: [ :n | aStream nextPutAll: n text asString ]
				separatedBy: [ aStream crlf ] ]
]

{ #category : #accessing }
PpPhoneCall >> start [
	^ start
]

{ #category : #accessing }
PpPhoneCall >> start: anObject [
	start := anObject
]
