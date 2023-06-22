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
