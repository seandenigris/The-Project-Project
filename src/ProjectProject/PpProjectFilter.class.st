Class {
	#name : 'PpProjectFilter',
	#superclass : 'GtSearchFilter',
	#category : 'ProjectProject-UI-Bloc',
	#package : 'ProjectProject',
	#tag : 'UI-Bloc'
}

{ #category : 'as yet unclassified' }
PpProjectFilter class >> availableFilters [

	^ {
		GtFilterTextModel new 
			creator: [ :value | 
				GtFilterTextModel new
					name: 'Due before';
					yourself ];
		named: 'Due';
		order: 12 }
]
