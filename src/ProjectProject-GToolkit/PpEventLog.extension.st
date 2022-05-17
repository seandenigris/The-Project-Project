Extension { #name : #PpEventLog }

{ #category : #'*ProjectProject-GToolkit' }
PpEventLog >> timeline [
	| points aPlotter |
	points := self events select: [ :e | e startDate isNotNil ].
	aPlotter := GtPlotter new.
	aPlotter horizontalTimeline
		withProjectionAxis;
		timelineData: #startDate;
		projectionData: #displayString;
		timelineFrom: 2021 asYear to: 2023 asYear;
		with: points.
	^ aPlotter
]
