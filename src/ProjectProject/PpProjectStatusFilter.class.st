Class {
	#name : 'PpProjectStatusFilter',
	#superclass : 'PpProjectFilter',
	#instVars : [
		'status'
	],
	#category : 'ProjectProject-UI-Bloc',
	#package : 'ProjectProject',
	#tag : 'UI-Bloc'
}

{ #category : 'instance creation' }
PpProjectStatusFilter class >> filterDescriptor [

	^ GtFilterShortListModel new
		creator: [ :anItem | self new ];
		named: 'Status';
		order: 19;
		items: { 
			GtFilterModelAllItem default.
			PpFilterStatusItem new };
		selectFirstItem.
		
	"Adapted from GtSearchSubclassResponsibilityMethodsFilter>>#globalFilterDescriptor2"
]

{ #category : 'as yet unclassified' }
PpProjectStatusFilter >> matches: anObject [

	self status ifNil: [ ^ true ].
	
	^ anObject status isKindOf: self status
]

{ #category : 'accessing' }
PpProjectStatusFilter >> status [

  ^ status
]

{ #category : 'accessing' }
PpProjectStatusFilter >> status: anObject [

  status := anObject
]
