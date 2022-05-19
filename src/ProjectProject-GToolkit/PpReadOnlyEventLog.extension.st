Extension { #name : #PpReadOnlyEventLog }

{ #category : #'*ProjectProject-GToolkit' }
PpReadOnlyEventLog >> timeline [
	| points aPlotter |
	points := self events select: [ :e | e startDate isNotNil ].
	aPlotter := GtPlotter new.
	aPlotter verticalTimeline
		withProjectionAxis;
		timelineData: #startDate;
		projectionData: #displayString;
		timelineFrom: (points first startDate subtractDays: 7) 
			to: (points last startDate addDays: 7);
		with: points.
	^ aPlotter
]
