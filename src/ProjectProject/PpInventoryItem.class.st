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
PpInventoryItem class >> replacementStringSeparator [

	^ "'; '"String crlf, '- '
]

{ #category : #accessing }
PpInventoryItem >> displayStringOn: aStream [
	
	name ifNotNil: [ aStream nextPutAll: name ].
		
	self location ifNotNil: [ :loc | 
		aStream 
			nextPutAll: ' @ ';
			nextPutAll: self location fullName ].
]

{ #category : #accessing }
PpInventoryItem >> import [
		
	self inventory addItem: self
]

{ #category : #accessing }
PpInventoryItem >> importDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		gtIcon: BrGlamorousVectorIcons down;
		comment: 'Import into Singleton Inventory';
		action: #import;
		"enableBlock: [ :anItem | anItem inventory isNil ];"
		yourself
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
			classes: PpAbstractLocation allSubclasses;
			yourself
]

{ #category : #accessing }
PpInventoryItem >> name [

	^ self maLazyInstVarUsing: self nameDescription
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
			default: '';
			yourself
]

{ #category : #accessing }
PpInventoryItem >> photos [

	^ self supportMaterials select: [ :e | e isKindOf: RlPicture ]
]

{ #category : #accessing }
PpInventoryItem >> printOn: aStream [
	
	self printFromDisplayStringOn: aStream
]

{ #category : #accessing }
PpInventoryItem >> replacementGtViewFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Replacement';
		priority: 62;
		text: (self replacementStringWithSeparator: String crlf, '- ');
		actionUpdateButton;
		yourself.
]

{ #category : #accessing }
PpInventoryItem >> replacementString [

	^ self replacementStringWithSeparator: self class replacementStringSeparator
]

{ #category : #accessing }
PpInventoryItem >> replacementStringOldFormat [

	^ self replacementStringWithSeparator: ', '
]

{ #category : #accessing }
PpInventoryItem >> replacementStringWithSeparator: aString [
	self subclassResponsibility
]
