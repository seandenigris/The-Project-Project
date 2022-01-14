Class {
	#name : #PpEvent,
	#superclass : #Object,
	#traits : 'QuTLeCitable + MATPropertyOwner',
	#classTraits : 'QuTLeCitable classTrait + MATPropertyOwner classTrait',
	#instVars : [
		'endDate',
		'startDate',
		'endTime',
		'startTime',
		'notes',
		'participants',
		'title',
		'location'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #examples }
PpEvent class >> examplePointInTime [
	<gtExample>
	^ self
		given: []
		when: [ PpEvent new startDate: '4/5/2021' asDate; yourself ]
		then: [ :evt | evt startDate should equal: '4/5/2021' asDate ]
]

{ #category : #accessing }
PpEvent >> endDate [
	^ self maLazyInstVarUsing: self endDateDescription
]

{ #category : #accessing }
PpEvent >> endDate: aDate [
	endDate := aDate
]

{ #category : #'magritte-accessing' }
PpEvent >> endDateDescription [

	<magritteDescription>
	^ MADateDescription new
		  accessor: #endDate;
		  yourself
]

{ #category : #accessing }
PpEvent >> endTime [
	^ self maLazyInstVarUsing: self endTimeDescription
]

{ #category : #accessing }
PpEvent >> endTime: aTime [
	endTime := aTime
]

{ #category : #'magritte-accessing' }
PpEvent >> endTimeDescription [

	<magritteDescription>
	^ MATimeDescription new
		  accessor: #endTime;
		  yourself
]

{ #category : #accessing }
PpEvent >> location [
	^ self maLazyInstVarUsing: self locationDescription
]

{ #category : #accessing }
PpEvent >> location: aString [
	location := aString
]

{ #category : #'magritte-accessing' }
PpEvent >> locationDescription [

	<magritteDescription>
	^ MAStringDescription new
		  name: #location;
		  accessor: #location;
		  yourself
]

{ #category : #accessing }
PpEvent >> notes [
	^ notes
]

{ #category : #accessing }
PpEvent >> notes: anObject [
	notes := anObject
]

{ #category : #magritte }
PpEvent >> notesDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
			accessor: #notes;
			label: 'Notes';
			priority: 200;
			default: OrderedCollection new;
			classes: { PpNote };
			yourself
]

{ #category : #accessing }
PpEvent >> participants [
	^ self maLazyInstVarUsing: self participantsDescription
]

{ #category : #accessing }
PpEvent >> participants: anObject [
	participants := anObject
]

{ #category : #magritte }
PpEvent >> participantsDescription [
	<magritteDescription>
	
	^ MAMultipleOptionDescription new
			accessor: #participants;
			label: 'Participants';
			priority: 100;
			default: OrderedCollection new;
			options: MpAddressBook default contacts;
			shouldCacheDefault: true;
			yourself
]

{ #category : #accessing }
PpEvent >> startDate [
	^ self maLazyInstVarUsing: self startDateDescription
]

{ #category : #accessing }
PpEvent >> startDate: aDate [
	startDate := aDate
]

{ #category : #'magritte-accessing' }
PpEvent >> startDateDescription [

	<magritteDescription>
	^ MADateDescription new
		accessor: #startDate;
		yourself
]

{ #category : #accessing }
PpEvent >> startTime [
	^ self maLazyInstVarUsing: self startTimeDescription
]

{ #category : #accessing }
PpEvent >> startTime: aTime [
	startTime := aTime
]

{ #category : #'magritte-accessing' }
PpEvent >> startTimeDescription [

	<magritteDescription>
	^ MATimeDescription new
		  accessor: #startTime;
		  yourself
]

{ #category : #accessing }
PpEvent >> title [
	^ self maLazyInstVarUsing: self titleDescription
]

{ #category : #accessing }
PpEvent >> title: aString [
	title := aString
]

{ #category : #'magritte-accessing' }
PpEvent >> titleDescription [

	<magritteDescription>
	^ MAStringDescription new
		  name: #title;
		  accessor: #title;
		  yourself
]
