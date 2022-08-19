Class {
	#name : #PpAction,
	#superclass : #PpProject,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpAction >> defaultStatus [
	^ PpActiveStatus new
]

{ #category : #testing }
PpAction >> isAction [
	^ true
]
