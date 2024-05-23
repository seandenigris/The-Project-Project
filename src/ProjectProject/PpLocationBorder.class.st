Class {
	#name : #PpLocationBorder,
	#superclass : #PpAbstractLocation,
	#instVars : [
		'locations'
	],
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #accessing }
PpLocationBorder >> childrenDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
		accessor: #locations;
		priority: 200;
		default: IdentitySet new;
		classes: PpAbstractLocation withAllSubclasses;
		gtSearchSource: (MessageSend receiver: self selector: #list); 
		yourself
]

{ #category : #accessing }
PpLocationBorder >> display: aSelector on: aStream [
		
	aStream nextPutAll: 'between '.
	
	self locations 
		do: [ :loc | aStream nextPutAll: (loc perform: aSelector) ]
		separatedBy: [ aStream nextPutAll: ' and ' ]
]

{ #category : #accessing }
PpLocationBorder >> displayStringOn: aStream [

	name ifNotNil: [ 
		aStream nextPutAll: self name.
		^ self ].
		
	self display: #fullName on: aStream
]

{ #category : #accessing }
PpLocationBorder >> fullName [

	^ String streamContents: [ :aStream |
		self display: #fullName on: aStream ]
]

{ #category : #accessing }
PpLocationBorder >> locations [
	^ locations ifNil: [ locations := IdentitySet new ]
]

{ #category : #accessing }
PpLocationBorder >> locations: anObject [
	locations := anObject
]

{ #category : #accessing }
PpLocationBorder >> name [

	name ifNotNil: [ ^ name ].
	
	^ String streamContents: [ :aStream |
		self display: #name on: aStream ]
]
