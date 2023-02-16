"
# Support Materials vs. Conditions

A material is *what* I want to see/have when my focus is on a project, whereas a condition is *when* I can focus on a project. See {{gtClass:PpProjectCondition|show=#gtLepiterCommentFor:}} for more details.
"
Class {
	#name : #PpProject,
	#superclass : #PpValue,
	#instVars : [
		'dueDate',
		'conditions'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #examples }
PpProject class >> exampleComplete [
	<gtExample>
	^ self
		given: [ self exampleIncomplete title: 'something done'; yourself ]
		when: [ :p | p beComplete ]
		then: [ :p | p isComplete should equal: true ]
]

{ #category : #examples }
PpProject class >> exampleIncomplete [
	<gtExample>
	^ self
		given: [ ]
		when: [ 
			(self titled: 'something to do')
				dueDate: Date tomorrow;
				yourself ]
		then: [ :p | 
			p isComplete should equal: false.
			p dueDate should equal: Date tomorrow ]
]

{ #category : #'instance creation' }
PpProject class >> fromString: aString [
	^ self titled: aString
]

{ #category : #accessing }
PpProject class >> inactiveStatus [
	^ PpInactiveStatus new
]

{ #category : #accessing }
PpProject class >> label [
	^ (self name allButFirst: 'Pp' size) normalizeCamelCase
]

{ #category : #testing }
PpProject class >> peCanHandleFromString: aString [
	^ true
]

{ #category : #accessing }
PpProject class >> statusOptions [
	^ PpStatus allSubclasses collect: #new
]

{ #category : #'instance creation' }
PpProject class >> titled: aString [
	^ self new
		title: aString;
		yourself
]

{ #category : #accessing }
PpProject >> beComplete [

	self status: PpCompleteStatus new.
	
	self allChildren do: [ :e | 
		e isComplete ifFalse: [ 
			self error: 'What to do here? Mark children as done/not? What if they have other parents?'.
			e beComplete ] ]
]

{ #category : #accessing }
PpProject >> conditions [

	^ conditions ifNil: [ conditions := Bag new ]
]

{ #category : #accessing }
PpProject >> conditions: aCollection [

	conditions := aCollection
]

{ #category : #magritte }
PpProject >> conditionsDescription [
	<magritteDescription>
	
	| gtSearchSource librarySource |
	gtSearchSource := PeGtCompositeSearch new.
	PpProjectCondition allSubclasses do: [ :cls |	
			librarySource := PeGtDelegatedSearch 
			to: cls 
			message: #gtSpotterNewFor:.
			
		gtSearchSource children add: librarySource ].
	
	^ MAToManyRelationDescription new
			accessor: #conditions;
			priority: 650;
			default: Bag new;
			classes: PpProjectCondition allSubclasses;
			morphicClass: MAMorphicTokenCompletion;
			gtSearchSource: gtSearchSource;
			comment: 'See ', PpProjectCondition className, ' comment for more info';
			yourself
]

{ #category : #'gt-views' }
PpProject >> conditionsGtViewFor: aView [
	<gtView>
	
	^ aView list
		title: 'Requirements' translated;
		priority: 25;
		items: [ self conditions asOrderedCollection ];
		inspectButtonFor: [ self conditions ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #status }
PpProject >> defaultStatus [
	^ PpInboxStatus new
]

{ #category : #printing }
PpProject >> displayStringOn: aStream [

	self title ifNotNil: [ aStream nextPutAll: self title ].
	dueDate ifNotNil: [
		aStream
			nextPutAll: ' (Due ';
			nextPutAll: self dueDate mmddyyyy;
			nextPut: $) ]
]

{ #category : #accessing }
PpProject >> displayText [
	^ self textFromString: self displayString
]

{ #category : #accessing }
PpProject >> dueBy: aDate [
	
	^ self newFromChildrenBlock: [ 
		self activeChildrenList rootChildren ]
]

{ #category : #accessing }
PpProject >> dueDate [
	^ dueDate
]

{ #category : #accessing }
PpProject >> dueDate: anObject [
	dueDate := anObject
]

{ #category : #magritte }
PpProject >> dueDateDescription [
	<magritteDescription>
	
	^ MADateDescription new
			accessor: #dueDate;
			label: 'Due Date';
			priority: 200;
			"default: Date today;"
			"beRequired;"
			yourself
]

{ #category : #accessing }
PpProject >> dueDateString [
	
	^ self dueDateDescription readToString: self
]

{ #category : #accessing }
PpProject >> gtDisplayText [
	^ self gtTextFromString: self displayString
]

{ #category : #accessing }
PpProject >> gtTextFromString: aString [
	| result |
	result := super gtTextFromString: aString.
	self isComplete ifTrue: [ result strikethrough ].
	^ result.
]

{ #category : #accessing }
PpProject >> import [
	PpProjectList uniqueInstance addChild: self
]

{ #category : #accessing }
PpProject >> importDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		gtIcon: BrGlamorousVectorIcons down;
		comment: 'Import into Singleton Library';
		action: #import;
		enableBlock: [ :proj | proj masterList isNil ];
		yourself
]

{ #category : #testing }
PpProject >> isActive [
	^ self status isActive
]

{ #category : #testing }
PpProject >> isActiveDueBy: aDate [
	^ self isActive and: [ self dueDate isNotNil and: [ self dueDate < aDate ] ]
]

{ #category : #magritte }
PpProject >> isCompleteDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
			accessor: #isComplete;
			label: 'Complete';
			priority: 150;
			beReadOnly;
			yourself
]

{ #category : #testing }
PpProject >> isInactive [
	^ self status isInactive
]

{ #category : #testing }
PpProject >> isProject [

	^ true
]

{ #category : #accessing }
PpProject >> maGtFormFor: aView [
	
	^ (super maGtFormFor: aView)
		priority: 5;
		yourself
]

{ #category : #accessing }
PpProject >> textFromString: aString [
	^ self isComplete
			ifTrue: [ 
				aString asText
					addAttribute: TextEmphasis struckOut;
					yourself ]
			ifFalse: [ aString ]
]
