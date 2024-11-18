Class {
	#name : #PpClarify,
	#superclass : #Object,
	#instVars : [
		'stuff',
		'outcome',
		'nextAction',
		'whatIsIt',
		'isActionable',
		'needsProject',
		'shouldDoIt',
		'isComplete'
	],
	#category : #ProjectProject
}

{ #category : #'as yet unclassified' }
PpClarify >> childrenNewSearches [

	self flag: 'copy/pasted. See implementors'.
	^ PpAction withAllSubclasses collect: [ :cls |
		GtSpotterProtoSearch new list
			title: 'New ' , cls name;
			priority: 50;
			itemName: #gtSpotterText;
			items: [ {} asAsyncStream ];
			filter: (PeGtInstancesFilter new
					rootClass: cls;
					yourself);
			send: [ :result | self nextAction: result. result ] ]
]

{ #category : #'as yet unclassified' }
PpClarify >> didIt [

	self setUpProjects.
	self nextAction beComplete
]

{ #category : #accessing }
PpClarify >> isActionable [
	^ isActionable
]

{ #category : #accessing }
PpClarify >> isActionable: anObject [
	isActionable := anObject
]

{ #category : #accessing }
PpClarify >> isActionableDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
		accessor: #isActionable;
		label: 'Commit to action?';
		
		priority: 300;
		default: false;
		comment: 'Is there an action to which I will commit?';
		yourself
]

{ #category : #accessing }
PpClarify >> isComplete [
	^ isComplete
]

{ #category : #accessing }
PpClarify >> isComplete: anObject [
	isComplete := anObject
]

{ #category : #accessing }
PpClarify >> isCompleteDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
		accessor: #isComplete;
		priority: 150;
		label: 'Is it complete for me?';
		default: false;
		comment: 'Is it complete for me';
		yourself
]

{ #category : #'as yet unclassified' }
PpClarify >> masterList [

	^ PpProjectList uniqueInstance
]

{ #category : #accessing }
PpClarify >> needsProject [
	^ needsProject
]

{ #category : #accessing }
PpClarify >> needsProject: anObject [
	needsProject := anObject
]

{ #category : #accessing }
PpClarify >> needsProjectDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
		accessor: #needsProject;
		label: 'Action will complete?';
		priority: 500;
		default: false;
		comment: 'Will this action achieve the outcome?';
		yourself
]

{ #category : #accessing }
PpClarify >> nextAction [
	^ nextAction
]

{ #category : #accessing }
PpClarify >> nextAction: anObject [
	nextAction := anObject
]

{ #category : #accessing }
PpClarify >> nextActionDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #nextAction;
		priority: 400;
		gtSearchSource: (PeGtCompositeSearch new children: self childrenNewSearches; yourself);
		yourself
]

{ #category : #accessing }
PpClarify >> outcome [
	^ outcome
]

{ #category : #accessing }
PpClarify >> outcome: anObject [
	outcome := anObject
]

{ #category : #accessing }
PpClarify >> outcomeDescription [
	<magritteDescription>
	
	^ MAStringDescription new
		accessor: #outcome;
		priority: 200;
		comment: 'What does "Done" look like?';
		yourself
]

{ #category : #'as yet unclassified' }
PpClarify >> setUpProjects [

	| project |
	project := PpProject titled: self outcome.
	self masterList ensureChild: project.
	self stuff value do: [ :e | project supportMaterialsAdd: e ].
	project ensureChild: self nextAction.
]

{ #category : #accessing }
PpClarify >> shouldDoIt [
	^ shouldDoIt
]

{ #category : #accessing }
PpClarify >> shouldDoIt: anObject [
	shouldDoIt := anObject
]

{ #category : #accessing }
PpClarify >> shouldDoItDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
		accessor: #shouldDoIt;
		label: 'Action < 2 min?';
		priority: 600;
		default: false;
		comment: 'Will this take less than 2 minutes?';
		yourself
]

{ #category : #accessing }
PpClarify >> stuff [
	^ stuff
]

{ #category : #accessing }
PpClarify >> stuff: anObject [
	stuff := anObject
]

{ #category : #'as yet unclassified' }
PpClarify >> wait [

	self nextAction: PpWaitingForProject new.
	self setUpProjects.
]

{ #category : #accessing }
PpClarify >> whatIsIt [
	^ whatIsIt
]

{ #category : #accessing }
PpClarify >> whatIsIt: anObject [
	whatIsIt := anObject
]

{ #category : #accessing }
PpClarify >> whatIsItDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
		accessor: #whatIsIt;
		priority: 100;
		default: false;
		yourself
]
