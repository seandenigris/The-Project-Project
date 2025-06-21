Class {
	#name : #PpWorkflowEventListener,
	#superclass : #BlEventListener,
	#instVars : [
		'pageID'
	],
	#category : #'ProjectProject-GToolkit'
}

{ #category : #'as yet unclassified' }
PpWorkflowEventListener >> clickEvent: anEvent [

	| page |
	page := LeDatabasesRegistry defaultPrimaryDatabase pageWithID: self pageID.
	anEvent currentTarget phlow spawnObject: page
]

{ #category : #'as yet unclassified' }
PpWorkflowEventListener >> mouseEnterEvent: anEvent [
	| anAnimation |
	anAnimation := (BlTransformAnimation scale: 2.0 @ 2.0)
		absolute;
		duration: 0.2 seconds.
	anEvent currentTarget addAnimation: anAnimation
]

{ #category : #'as yet unclassified' }
PpWorkflowEventListener >> mouseLeaveEvent: anEvent [
	| anAnimation |
	anAnimation := (BlTransformAnimation scale: 1.0 @ 1.0)
		absolute;
		duration: 0.5 seconds.
	anEvent currentTarget addAnimation: anAnimation
]

{ #category : #accessing }
PpWorkflowEventListener >> pageID [
	^ pageID
]

{ #category : #accessing }
PpWorkflowEventListener >> pageID: anObject [
	pageID := anObject
]
