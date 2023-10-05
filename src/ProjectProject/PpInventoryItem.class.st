Class {
	#name : #PpInventoryItem,
	#superclass : #Object,
	#traits : 'DbTDomainObject',
	#classTraits : 'DbTDomainObject classTrait',
	#instVars : [
		'name',
		'location'
	],
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #accessing }
PpInventoryItem class >> named: aString [ 

	^ self new
		name: aString;
		yourself
]

{ #category : #accessing }
PpInventoryItem >> displayStringOn: aStream [
	aStream
		nextPutAll: name;
		nextPutAll: ' @ ';
		display: location
]

{ #category : #accessing }
PpInventoryItem >> initialize [
	super initialize.
	self ensureUUID
]

{ #category : #accessing }
PpInventoryItem >> location [

	^ location
]

{ #category : #accessing }
PpInventoryItem >> location: anObject [

	location := anObject
]

{ #category : #accessing }
PpInventoryItem >> locationDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
			accessor: #location;
			priority: 200;
			gtSearchSource: (MessageSend receiver: PpLocation selector: #list);
			classes: PpLocation withAllSubclasses;
			yourself
]

{ #category : #accessing }
PpInventoryItem >> name [

	^ name
]

{ #category : #accessing }
PpInventoryItem >> name: anObject [

	name := anObject
]

{ #category : #accessing }
PpInventoryItem >> nameDescription [
	<magritteDescription>
	
	^ MAStringDescription new
			accessor: #name;
			priority: 100;
			yourself
]

{ #category : #accessing }
PpInventoryItem >> printOn: aStream [
	aStream
		nextPutAll: name;
		nextPutAll: ' @ ';
		print: location;
		nextPutAll: ' (Inventory Item)'
]
