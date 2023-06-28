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
		actionUpdateButtonTooltip: 'Update'.
]
