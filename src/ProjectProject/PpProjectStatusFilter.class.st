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
		creator: [ :anItem |
			anItem
				ifSome: [ :aValue | 
					self new
						status: aValue;
						yourself ]
				ifNone: [ self new ] ];
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
