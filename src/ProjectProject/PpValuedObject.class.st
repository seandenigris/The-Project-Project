Class {
	#name : #PpValuedObject,
	#superclass : #PpValue,
	#instVars : [
		'model'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #'instance creation' }
PpValuedObject class >> on: anObject [

	^ self new
		model: anObject;
		yourself.
]

{ #category : #accessing }
PpValuedObject >> ensureLepiterPage [

	^ self model ensureLepiterPage
]

{ #category : #'gt inspector' }
PpValuedObject >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: (super gtDefaultInspectorTool
			name: 'Project';
			withLabelAndIconAptitude);
		addTool: (self model gtDefaultInspectorTool
			name: 'Model';
			withLabelAndIconAptitude)
]

{ #category : #accessing }
PpValuedObject >> lepiterDB [

	^ self model lepiterDB
]

{ #category : #accessing }
PpValuedObject >> lepiterDB: anObject [

	^ self error: 'should we forward to model?'
]

{ #category : #accessing }
PpValuedObject >> lepiterPageID [

	^ self model lepiterPageID
]

{ #category : #accessing }
PpValuedObject >> lepiterPageID: anObject [

	^ self error: 'should we forward to model?'
]

{ #category : #accessing }
PpValuedObject >> masterList: aProjectList [
	"Now that I am registered somewhere, store me"

	self model 
		propertyAt: #ppProject
		put: self.
		
	^ super masterList: aProjectList
]

{ #category : #accessing }
PpValuedObject >> model [
	^ model
]

{ #category : #accessing }
PpValuedObject >> model: anObject [
	model := anObject
]

{ #category : #accessing }
PpValuedObject >> newLepiterPage [
	^ LePage dbObject: self model
]

{ #category : #accessing }
PpValuedObject >> title [

	^ title ifNil: [ self model ppProjectTitle ]
]
