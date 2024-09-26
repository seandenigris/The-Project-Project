Extension { #name : #DbTDomainObject }

{ #category : #'*ProjectProject' }
DbTDomainObject >> eventLog [

	^ PpEventLog uniqueInstance
]

{ #category : #'*ProjectProject' }
DbTDomainObject >> inventory [
	^ PpInventory uniqueInstance
]

{ #category : #'*ProjectProject' }
DbTDomainObject >> ppTimelineStamp [

	^ self
		propertyAt: #ppTimelineStamp
		ifPresent: [ :aValuable | aValuable valueWithArguments: { self } ]
		ifAbsent: [ nil ]
]

{ #category : #'*ProjectProject' }
DbTDomainObject >> ppTimelineStamp: aValuable [
	"aValuable - aDateAndTime or returns one" 

	^ self
		propertyAt: #ppTimelineStamp
		put: aValuable
]

{ #category : #'*ProjectProject' }
DbTDomainObject >> projectList [

	^ PpProjectList uniqueInstance
]

{ #category : #'*ProjectProject' }
DbTDomainObject >> sanitizedSupportMaterial: anObject [
	
	^ anObject olAsReference
]

{ #category : #'*ProjectProject' }
DbTDomainObject >> supportEmailsImportFromMailClient [

	Smalltalk tools mailClient new selectedMessagesImport do: [ :msg | self supportMaterialsAdd: msg ].
]

{ #category : #'*ProjectProject' }
DbTDomainObject >> supportMaterials [
	^ self maLazyPropertyUsing: self supportMaterialsDescription
]

{ #category : #'*ProjectProject' }
DbTDomainObject >> supportMaterials: aCollection [

	^ self
		propertyAt: #supportMaterials
		put: aCollection
]

{ #category : #'*ProjectProject' }
DbTDomainObject >> supportMaterialsAdd: anObject [
	^ self supportMaterials add: anObject
]

{ #category : #'*ProjectProject' }
DbTDomainObject >> supportMaterialsDescription [
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
		add: self projectList;
		add: self resourceLibrary.
		
	classes := LlAuthoredWork withAllSubclasses
		addAll: LlLibraryItem allSubclasses;
		add: OlLepiterPage;
		add: OlLepiterSnippet;
		addAll: PpEvent withAllSubclasses;
		addAll: PpInventoryItem withAllSubclasses;
		addAll: RlResource withAllSubclasses;
		addAll: PpValue withAllSubclasses;
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

{ #category : #'*ProjectProject' }
DbTDomainObject >> supportMaterialsGtViewFor: aView [
	<gtView>
	
	self supportMaterials ifEmpty: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Materials' translated;
		priority: 25;
		items: [ self supportMaterials asOrderedCollection ];
		column: 'Name' translated 
			text: #ppSupportMaterialDisplayString;
		column: 'Type' translated 
			text: #typeDisplayName;
		inspectButtonFor: [ self supportMaterials ];
		actionUpdateButton.
]
