Class {
	#name : #PpProjectDependency,
	#superclass : #Object,
	#instVars : [
		'project',
		'dependency',
		'masterList'
	],
	#category : #'ProjectProject-Core-Projects-Support'
}

{ #category : #accessing }
PpProjectDependency class >> project: aPpProject dependsOn: anotherPpProject in: aPpProjectList [

	^ self new
		project: aPpProject;
		dependency: anotherPpProject;
		masterList: aPpProjectList;
		yourself
]

{ #category : #accessing }
PpProjectDependency >> = rhs [

	self species = rhs species ifFalse: [ ^ false ].
	
	self masterList == rhs masterList ifFalse: [ ^ false ]. "This should always be true because the domain currently has only one"
	
	self project == rhs project ifFalse: [ ^ false ].
	
	self dependency == rhs dependency ifFalse: [ ^ false ].
	
	^ true
]

{ #category : #accessing }
PpProjectDependency >> dependency [

	^ dependency
]

{ #category : #accessing }
PpProjectDependency >> dependency: anObject [

	dependency := anObject
]

{ #category : #accessing }
PpProjectDependency >> hash [
	^ self project hash bitXor: self dependency hash
]

{ #category : #accessing }
PpProjectDependency >> includes: aProject [
	^ self project = aProject or: [ self dependency = aProject ]
]

{ #category : #accessing }
PpProjectDependency >> link [
	self masterLinks
		detect: [ :link | link = self ]
		ifNone: [ self masterLinks add: self ].

	self masterList 
		ensureChild: self project;
		ensureChild: self dependency.
]

{ #category : #accessing }
PpProjectDependency >> masterLinks [
	^ self masterList dependencyLinks
]

{ #category : #accessing }
PpProjectDependency >> masterList [

	^ masterList ifNil: [ PpProjectList uniqueInstance ]
]

{ #category : #accessing }
PpProjectDependency >> masterList: anObject [

	masterList := anObject
]

{ #category : #accessing }
PpProjectDependency >> printOn: aStream [

	aStream 
		nextPut: $";
		print: project;
		nextPutAll: '" depends on "';
		print: dependency;
		nextPut: $"
]

{ #category : #accessing }
PpProjectDependency >> project [

	^ project
]

{ #category : #accessing }
PpProjectDependency >> project: anObject [

	project := anObject
]

{ #category : #accessing }
PpProjectDependency >> unlink [
	self masterList dependencyLinks remove: self
]
