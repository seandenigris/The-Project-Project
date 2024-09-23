Class {
	#name : #PpEventDocumentImport,
	#superclass : #Object,
	#instVars : [
		'event',
		'file',
		'work',
		'materialName'
	],
	#category : #ProjectProject
}

{ #category : #accessing }
PpEventDocumentImport >> event [
	^ event
]

{ #category : #accessing }
PpEventDocumentImport >> event: anObject [
	event := anObject
]

{ #category : #accessing }
PpEventDocumentImport >> eventDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #event;
		priority: 100;
		gtSearchSource: self eventLog;
		classes: PpEvent withAllSubclasses;
		yourself
]

{ #category : #accessing }
PpEventDocumentImport >> eventLog [

	^ PpEventLog uniqueInstance
]

{ #category : #'as yet unclassified' }
PpEventDocumentImport >> execute [

	| resource material |
	
	resource := self file asRlResource import
		source: self event;
		yourself.
		
	self materialName ifNotNil: [ :aString | resource name: aString ].
	
	material := self work
		ifNil: [ resource ]
		ifNotNil: [
			self library
				addCopy: resource
				of: self work.
			self work ].
		
	self event supportMaterials add: material
]

{ #category : #accessing }
PpEventDocumentImport >> file [
	^ file
]

{ #category : #accessing }
PpEventDocumentImport >> file: anObject [
	file := anObject
]

{ #category : #accessing }
PpEventDocumentImport >> fileDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #file;
		priority: 100;
		classes: AbstractFileReference allSubclasses;
		yourself
]

{ #category : #'as yet unclassified' }
PpEventDocumentImport >> fileOpenGtActionFor: anAction [
	<gtAction>
	
	^ self file gtActionWebBrowseFor: anAction
]

{ #category : #accessing }
PpEventDocumentImport >> library [

	^ LlLibrary uniqueInstance
]

{ #category : #accessing }
PpEventDocumentImport >> materialName [
	^ materialName
]

{ #category : #accessing }
PpEventDocumentImport >> materialName: anObject [
	materialName := anObject
]

{ #category : #accessing }
PpEventDocumentImport >> materialNameDescription [
	<magritteDescription>
	
	^ MAStringDescription new
		accessor: #materialName;
		priority: 100;
		yourself
]

{ #category : #accessing }
PpEventDocumentImport >> work [
	^ work
]

{ #category : #accessing }
PpEventDocumentImport >> work: anObject [
	work := anObject
]

{ #category : #accessing }
PpEventDocumentImport >> workDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #work;
		priority: 100;
		gtSearchSource: self library;
		classes: LlAuthoredWork withAllSubclasses;
		yourself
]
