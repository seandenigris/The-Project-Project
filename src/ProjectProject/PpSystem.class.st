"
If we keep this object, we can bring the projects list under it as well. Still not sure if ""Media to Review"" warrants a whole new domain concept, but ""project per item to review"" seems a bit heavyweight.
"
Class {
	#name : #PpSystem,
	#superclass : #Object,
	#instVars : [
		'mediaToReview',
		'inbox',
		'library',
		'msalApplication'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #accessing }
PpSystem class >> example [
	<gtExample>
	
	^ self new
		inbox: PpProjectList example;
		library: LlLibrary example;
		yourself
]

{ #category : #persistence }
PpSystem class >> restoreFrom: anObject [

	UniqueInstance := anObject.
]

{ #category : #persistence }
PpSystem class >> spData [

	^ UniqueInstance.
]

{ #category : #accessing }
PpSystem class >> uniqueInstance [

	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #accessing }
PpSystem class >> uniqueInstance: anObject [

	^ UniqueInstance := anObject
]

{ #category : #accessing }
PpSystem >> inbox [

	^ inbox ifNil: [ PpProjectList uniqueInstance ]
]

{ #category : #accessing }
PpSystem >> inbox: anObject [
	inbox := anObject
]

{ #category : #accessing }
PpSystem >> library [
	^ library ifNil: [ LlLibrary uniqueInstance ]
]

{ #category : #accessing }
PpSystem >> library: anObject [
	library := anObject
]

{ #category : #accessing }
PpSystem >> mediaToReview [

	^ mediaToReview ifNil: [ mediaToReview := Set new ]
]

{ #category : #accessing }
PpSystem >> mediaToReview: anObject [

	mediaToReview := anObject
]

{ #category : #accessing }
PpSystem >> mediaToReviewDescription [
	<magritteDescription>
	
	| gtSearchSource classes libraryItemSource |
	gtSearchSource := PeGtCollectedSearch new.
	libraryItemSource := PeGtDelegatedSearch 
		to: LlLibraryItem 
		message: #gtSpotterNewFor:.
	gtSearchSource children 
		"add: self inventory;"
		add: self library;
		add: libraryItemSource";
		add: self resourceLibrary".
		
	classes := LlAuthoredWork withAllSubclasses
		addAll: LlLibraryItem allSubclasses;
		"addAll: PpInventoryItem withAllSubclasses;
		addAll: RlResource withAllSubclasses;"
		yourself.
	
	^ MAToManyRelationDescription new
			accessor: #mediaToReview;
			priority: 100;
			default: Set new;
			classes: classes;
			display: #displayString;
			morphicClass: MAMorphicTokenCompletion;
			gtSearchSource: gtSearchSource;
			yourself
]

{ #category : #accessing }
PpSystem >> mediaToReviewViewOn: aView [
	<gtView>
	
	^ aView list
		title: 'Media to Review';
		priority: 10;
		items: [ self mediaToReview asOrderedCollection ];
		actionUpdateButton
]

{ #category : #accessing }
PpSystem >> msalApplication [

	^ msalApplication value
]

{ #category : #accessing }
PpSystem >> msalApplication: anMsalApplication [
	msalApplication := anMsalApplication
]

{ #category : #accessing }
PpSystem >> oneNote [

	^ self msalApplication oneNote
]
