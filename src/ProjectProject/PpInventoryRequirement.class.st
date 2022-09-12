Class {
	#name : #PpInventoryRequirement,
	#superclass : #PpProjectRequirement,
	#instVars : [
		'item'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpInventoryRequirement >> item [

	^ item
]

{ #category : #accessing }
PpInventoryRequirement >> item: anObject [

	item := anObject
]

{ #category : #accessing }
PpInventoryRequirement >> printOn: aStream [

	aStream
		"nextPut: $@;"
		print: self item;
		nextPutAll: ' requirement'
]
