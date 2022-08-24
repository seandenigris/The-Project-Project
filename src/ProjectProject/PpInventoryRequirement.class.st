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
