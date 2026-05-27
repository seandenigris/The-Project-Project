Class {
	#name : 'PpFilterStatusItem',
	#superclass : 'GtFilterModelItem',
	#category : 'ProjectProject-GToolkit',
	#package : 'ProjectProject-GToolkit'
}

{ #category : 'as yet unclassified' }
PpFilterStatusItem >> itemValue [

	^ PpReadReviewStatus
]

{ #category : 'as yet unclassified' }
PpFilterStatusItem >> label [

	^ 'Read / Review'
]
