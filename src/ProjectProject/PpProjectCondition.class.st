"
A `condition` is like a `context`  in GTD i.e. a required tool, location or situation. More generally, where, when and under what circumstances can I do this? When is this relevant? e.g. when I have an internet connection

In fact, there may be no useful distinction between a `condition` and `context`, but we are playing with the terminology to see.

For example, let's say I'm installing a window air conditioner.

Here's what I need:
- to be in the installation location
- to have tools (e.g. caulk, a screwdriver)

The location condition is pretty straightforward.

The tool one is more interesting. What if it's a tool you don't have? So then there's an additional step: get the tool, but how to model the condition? Maybe it's to check to see if you have the tool or to buy the tool or whatever. So that's actually another project with its own conditions e.g. I have to look at work for a tool, so work is the location condition, but I'm doing the actual job at home, so home is that location condition.
"
Class {
	#name : #PpProjectCondition,
	#superclass : #Object,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #'spotter - instance creation' }
PpProjectCondition class >> gtSpotterNewFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: self label;
		priority: 50;
		wantsToDisplayOnEmptyQuery: false;
		filter: (PeGtSubInstancesFilter new
				rootClass: self;
				yourself)
]

{ #category : #testing }
PpProjectCondition class >> label [

	^ (self name allButFirst: 'Pp' size) allButLast: 'Requirement' size
]

{ #category : #testing }
PpProjectCondition class >> peCanHandleFromString: aString [
	^ self ~= PpProjectCondition
]
