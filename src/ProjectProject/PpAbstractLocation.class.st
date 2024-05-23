Class {
	#name : #PpAbstractLocation,
	#superclass : #Object,
	#traits : 'DbTDomainObject',
	#classTraits : 'DbTDomainObject classTrait',
	#instVars : [
		'name'
	],
	#category : #'ProjectProject-Core-Inventories'
}

{ #category : #accessing }
PpAbstractLocation >> displayStringOn: aStream [

	self name ifNotNil: [ aStream nextPutAll: self name ].
]

{ #category : #accessing }
PpAbstractLocation >> distanceFrom: rhs [
	^ self geoLocation distanceFrom: rhs geoLocation
]

{ #category : #accessing }
PpAbstractLocation >> geoLocation [
	^ self propertyAt: #geoLocation ifAbsent: [ nil ]
]

{ #category : #accessing }
PpAbstractLocation >> geoLocation: aPpGeoLocation [
	^ self propertyAt: #geoLocation put: aPpGeoLocation
]

{ #category : #accessing }
PpAbstractLocation >> initialize [
	super initialize.
	self ensureUUID
]

{ #category : #accessing }
PpAbstractLocation >> list [
	^ PpLocationList uniqueInstance
]

{ #category : #accessing }
PpAbstractLocation >> name [

	^ name ifNil: [ '' ]
]

{ #category : #accessing }
PpAbstractLocation >> name: anObject [

	name := anObject
]

{ #category : #accessing }
PpAbstractLocation >> nameDescription [
	<magritteDescription>
	
	^ MAStringDescription new
			accessor: #name;
			priority: 100;
			yourself
]

{ #category : #accessing }
PpAbstractLocation >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]
