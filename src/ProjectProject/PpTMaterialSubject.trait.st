Trait {
	#name : #PpTMaterialSubject,
	#instVars : [
		'supportMaterials'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #magritte }
PpTMaterialSubject >> inventory [
	^ PpInventory uniqueInstance
]

{ #category : #magritte }
PpTMaterialSubject >> library [
	^ LlLibrary uniqueInstance
]

{ #category : #accessing }
PpTMaterialSubject >> resourceLibrary [

	^ RlResourceLibrary uniqueInstance
]

{ #category : #private }
PpTMaterialSubject >> sanitizedSupportMaterial: anObject [
	
	^ anObject olAsReference
]

{ #category : #accessing }
PpTMaterialSubject >> supportMaterials [
	^ self maLazyInstVarUsing: self supportMaterialsDescription
]

{ #category : #accessing }
PpTMaterialSubject >> supportMaterials: anObject [
	supportMaterials := anObject
]

{ #category : #accessing }
PpTMaterialSubject >> supportMaterialsDescription [
	<magritteDescription>
	
	| gtSearchSource classes libraryItemSource |
	gtSearchSource := PeGtCompositeSearch new.
	libraryItemSource := PeGtDelegatedSearch 
		to: LlLibraryItem 
		message: #gtSpotterNewFor:.
	gtSearchSource children 
		add: self eventLog;
		add: self inventory;
		add: self lepiterDB;
		add: self library;
		add: libraryItemSource;
		add: self resourceLibrary.
		
	classes := LlAuthoredWork withAllSubclasses
		addAll: LlLibraryItem allSubclasses;
		add: OlLepiterPage;
		add: OlLepiterSnippet;
		addAll: PpEvent withAllSubclasses;
		addAll: PpInventoryItem withAllSubclasses;
		addAll: RlResource withAllSubclasses;
		yourself.
	
	^ MAToManyRelationDescription new
			accessor: #supportMaterials;
			priority: 650;
			default: IdentitySet new;
			classes: classes;
			referenceDisplay: #ppSupportMaterialDisplayString;
			morphicClass: MAMorphicTokenCompletion;
			gtSearchSource: gtSearchSource;
			gtSearchTransform: (MessageSend receiver: self selector: #sanitizedSupportMaterial:);
			comment: 'See ', PpProject className, ' comment for more info';
			yourself
]

{ #category : #accessing }
PpTMaterialSubject >> supportMaterialsGtViewFor: aView [
	<gtView>
	
	self supportMaterials ifEmpty: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Materials' translated;
		priority: 25;
		items: [ self supportMaterials asOrderedCollection ];
		column: 'Name' translated 
			text: #ppSupportMaterialDisplayString;
		column: 'Type' translated 
			text: #displayName;
		inspectButtonFor: [ self supportMaterials ];
		actionUpdateButton.
]
