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
		'shouldDoIt'
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

	| project |
	project := PpProject titled: self outcome.
	self masterList ensureChild: project.
	self stuff value do: [ :e | project supportMaterialsAdd: e ].
	project ensureChild: (self nextAction beComplete; yourself).
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
		priority: 200;
		default: false;
		comment: 'Will I commit to take action?';
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
		priority: 300;
		comment: 'What does "Done" look like?';
		yourself
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
