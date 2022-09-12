Class {
	#name : #PpProjectRequirement,
	#superclass : #Object,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #'spotter - instance creation' }
PpProjectRequirement class >> gtSpotterNewFor: aStep [
	<gtSearch>
	
	aStep listProcessor
		title: self label;
		priority: 50;
		wantsToDisplayOnEmptyQuery: false;
		filter: (PeGtSubInstancesFilter new rootClass: self; yourself)
]

{ #category : #testing }
PpProjectRequirement class >> label [

	^ (self name allButFirst: 'Pp' size) allButLast: 'Requirement' size
]

{ #category : #testing }
PpProjectRequirement class >> peCanHandleFromString: aString [
	^ self ~= PpProjectRequirement
]
