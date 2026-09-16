"
I provide Bloc examples for visualizing the GTD Clarifying and Organizing workflow.

The main example, #gtdWorkflowElement, follows the topology of the classic GTD Processing and Organizing diagram while using newer terminology where it clarifies the model.

The diagram distinguishes workflow from supporting relationships. Arrowed connectors indicate directional workflow, while plain connectors can indicate association, such as the relationship between a Project and its Project Support Material.

This class is intentionally a visualization prototype rather than a GTD domain model. Nodes and routes are positioned explicitly to make the diagram easy to inspect and refine. Consequently, connector attachment coordinates currently duplicate some node geometry; a future version may derive route endpoints from nodes through a more declarative connection API.
"
Class {
	#name : 'PpGtdWorkflowExamples',
	#superclass : 'Object',
	#category : 'ProjectProject-GTD',
	#package : 'ProjectProject',
	#tag : 'GTD'
}

{ #category : 'building' }
PpGtdWorkflowExamples class >> addActionChoiceNodesOn: root [
	self
		addNodeId: #doIt
		text: 'Do it'
		position: 430 @ 600
		extent: 160 @ 48
		on: root.

	self
		addNodeId: #delegate
		text: 'Delegate it'
		position: 430 @ 675
		extent: 160 @ 48
		on: root.

	self
		addNodeId: #defer
		text: 'Defer it'
		position: 430 @ 750
		extent: 160 @ 48
		on: root
]

{ #category : 'building' }
PpGtdWorkflowExamples class >> addActionChoiceRoutesOn: root [
	"Next Action feeds a short stem, then a chooser spine.
	This makes Do / Delegate / Defer read as alternatives, not a sequence."

	self
		addRoute: {
			510 @ 550.
			410 @ 575 }
		arrow: false
		on: root.

	self
		addRoute: {
			410 @ 575.
			410 @ 774 }
		arrow: false
		on: root.

	self
		addRoute: {
			410 @ 624.
			430 @ 624 }
		arrow: true
		on: root.

	self
		addCaption: ('If less than', String cr, '2 minutes')
		position: 600 @ 615
		fontSize: 11
		on: root.

	self
		addRoute: {
			410 @ 699.
			430 @ 699 }
		arrow: true
		on: root.

	self
		addRoute: {
			590 @ 699.
			690 @ 699 }
		arrow: true
		on: root.

	self
		addCaption: ('In comm. system')
		position: 595 @ 680
		fontSize: 11
		on: root.
		
	self
		addCaption: ('Track in…')
		position: 605 @ 705
		fontSize: 11
		on: root.

	self
		addRoute: {
			410 @ 774.
			430 @ 774 }
		arrow: true
		on: root
]

{ #category : 'building' }
PpGtdWorkflowExamples class >> addActionOrganizationNodesOn: root [
	self
		addNodeId: #waitingFor
		text: ('Waiting', String cr, 'For')
		position: 690 @ 660
		extent: 170 @ 80
		on: root.

	self
		addNodeId: #calendar
		text: 'Calendar'
		position: 170 @ 850
		extent: 180 @ 75
		on: root.

	self
		addNodeId: #nextActions
		text: ('Next', String cr, 'Actions')
		position: 430 @ 850
		extent: 180 @ 75
		on: root
]

{ #category : 'building' }
PpGtdWorkflowExamples class >> addActionOrganizationRoutesOn: root [
	"Defer splits into two different commitments:
	a real calendar commitment vs next-action inventory."

	self
		addRoute: {
			510 @ 798.
			510 @ 825 }
		arrow: false
		on: root.

	self
		addRoute: {
			510 @ 825.
			260 @ 825.
			260 @ 850 }
		arrow: true
		on: root.

	self
		addCaption: ('For me to do, specific to a', String cr, 'day or time')
		position: 170 @ 940
		fontSize: 11
		on: root.

	self
		addRoute: {
			510 @ 825.
			520 @ 825.
			520 @ 850 }
		arrow: true
		on: root.

	self
		addCaption: ('For me to do, as soon as I can')
		position: 450 @ 940
		fontSize: 11
		on: root
]

{ #category : 'helpers' }
PpGtdWorkflowExamples class >> addCaption: aString position: aPoint fontSize: anInteger on: root [
	| label |

	label := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
			fontSize: anInteger;
			foreground: Color darkGray;
			yourself);
		text: aString;
		relocate: aPoint;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		yourself.

	root addChild: label.

	^ label
]

{ #category : 'building' }
PpGtdWorkflowExamples class >> addCaptureAndClarifyNodesOn: root [
	self
		addNodeId: #stuff
		text: 'Stuff'
		position: 460 @ 100
		extent: 100 @ 45
		on: root.

	self
		addNodeId: #in
		text: 'IN'
		position: 430 @ 175
		extent: 160 @ 50
		on: root.

	self
		addNodeId: #whatIsIt
		text: 'What is it?'
		position: 390 @ 255
		extent: 240 @ 50
		on: root.

	self
		addNodeId: #actionable
		text: 'Is it actionable?'
		position: 390 @ 330
		extent: 240 @ 50
		on: root
]

{ #category : 'building' }
PpGtdWorkflowExamples class >> addCaptureAndClarifyRoutesOn: root [
	self
		addRoute: {
			510 @ 145.
			510 @ 175 }
		arrow: true
		on: root.

	self
		addRoute: {
			510 @ 225.
			510 @ 255 }
		arrow: true
		on: root.

	self
		addRoute: {
			510 @ 305.
			510 @ 330 }
		arrow: true
		on: root
]

{ #category : 'helpers' }
PpGtdWorkflowExamples class >> addNodeId: anId text: aString position: aPoint extent: anExtent on: root [
	| element label |

	element := BlElement new
		id: anId;
		layout: BlFrameLayout new;
		size: anExtent;
		relocate: aPoint;
		background: (self fillColorForNodeId: anId);
		border: (BlBorder
			paint: Color darkGray
			width: (self borderWidthForNodeId: anId));
		geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
		yourself.

	label := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
			fontSize: (self fontSizeForNodeId: anId);
			foreground: Color black;
			yourself);
		text: aString;
		constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		yourself.

	element addChild: label.
	root addChild: element.

	^ element
]

{ #category : 'building' }
PpGtdWorkflowExamples class >> addNonActionableNodesOn: root [
	self
		addNodeId: #trash
		text: 'Trash'
		position: 850 @ 220
		extent: 150 @ 60
		on: root.

	self
		addNodeId: #possibleLaterActions
		text: ('Possible', String cr, 'later actions')
		position: 830 @ 340
		extent: 190 @ 70
		on: root.

	self
		addNodeId: #somedayMaybe
		text: ('Someday', String cr, '/ Maybe')
		position: 745 @ 455
		extent: 150 @ 65
		on: root.

	self
		addNodeId: #dateTrigger
		text: ('Tickler /', String cr, 'date-specific trigger')
		position: 905 @ 455
		extent: 185 @ 65
		on: root.

	self
		addNodeId: #reference
		text: ('Reference', String cr, 'material')
		position: 850 @ 565
		extent: 150 @ 70
		on: root
]

{ #category : 'building' }
PpGtdWorkflowExamples class >> addNonActionableRoutesOn: root [
	"NO is a junction with three independent outcomes."

	self
		addRoute: {
			630 @ 355.
			690 @ 355 }
		arrow: false
		on: root.

	self
		addCaption: 'NO'
		position: 650 @ 322
		fontSize: 18
		on: root.

	"Trash"

	self
		addRoute: {
			690 @ 355.
			750 @ 250.
			850 @ 250 }
		arrow: true
		on: root.

	self
		addCaption: 'Eliminate'
		position: 755 @ 255
		fontSize: 12
		on: root.

	"Incubate"

	self
		addRoute: {
			690 @ 355.
			750 @ 375.
			830 @ 375 }
		arrow: true
		on: root.

	self
		addCaption: 'Incubate'
		position: 755 @ 350
		fontSize: 12
		on: root.

	"Incubate splits into two distinct future reminders."

	self
		addRoute: {
			925 @ 410.
			925 @ 435 }
		arrow: false
		on: root.

	self
		addRoute: {
			925 @ 435.
			820 @ 435.
			820 @ 455 }
		arrow: true
		on: root.

	self
		addRoute: {
			925 @ 435.
			997 @ 435.
			997 @ 455 }
		arrow: true
		on: root.

	"Reference"

	self
		addRoute: {
			690 @ 355.
			750 @ 600.
			850 @ 600 }
		arrow: true
		on: root.

	self
		addCaption: 'Reference'
		position: 755 @ 575
		fontSize: 12
		on: root
]

{ #category : 'helpers' }
PpGtdWorkflowExamples class >> addPortAt: aPoint on: root [
	| port |

	port := BlElement new
		size: 1 @ 1;
		relocate: aPoint;
		yourself.

	root addChild: port.

	^ port
]

{ #category : 'building' }
PpGtdWorkflowExamples class >> addProjectAndNextActionNodesOn: root [
	self
		addNodeId: #projects
		text: 'Projects'
		position: 80 @ 420
		extent: 180 @ 100
		on: root.

	self
		addNodeId: #projectSupport
		text: ('Project Support', String cr, 'Material')
		position: 65 @ 600
		extent: 210 @ 80
		on: root.

	self
		addNodeId: #nextAction
		text: ('What''s the Next', String cr, 'Action?')
		position: 390 @ 470
		extent: 240 @ 80
		on: root
]

{ #category : 'building' }
PpGtdWorkflowExamples class >> addProjectAndNextActionRoutesOn: root [
	"YES is the semantic junction.
	Every actionable item requires a Next Action.
	A multi-step item additionally creates a Project."

	self
		addRoute: {
			510 @ 380.
			510 @ 420 }
		arrow: false
		on: root.

	self
		addCaption: 'YES'
		position: 525 @ 392
		fontSize: 18
		on: root.

	"YES -> Next Action"

	self
		addRoute: {
			510 @ 420.
			510 @ 470 }
		arrow: true
		on: root.

	"YES -> Projects, if multi-step"

	self
		addRoute: {
			510 @ 420.
			330 @ 420.
			260 @ 455 }
		arrow: true
		on: root.

	self
		addCaption: ('If multi-step, what''s the', String cr, 'desired outcome?')
		position: 275 @ 395
		fontSize: 12
		on: root.

	"Projects -> Next Action"

	self
		addRoute: {
			260 @ 470.
			"325 @ 470."
			390 @ 510 }
		arrow: true
		on: root.

	"Projects -- Project Support Material
	This is an association / support relationship, not workflow."

	self
		addRoute: {
			170 @ 520.
			170 @ 600 }
		arrow: false
		on: root.

	self
		addCaption: 'Planning / support'
		position: 120 @ 550
		fontSize: 12
		on: root.

	"Project Support Material -> review for actions -> Next Action
	Only the final leg gets the arrowhead."

	self
		addRoute: {
			275 @ 640.
			320 @ 640.
			"350 @ 575."
			350 @ 525.
			390 @ 525 }
		arrow: true
		on: root.

	self
		addCaption: 'Review for actions'
		position: 282 @ 585
		fontSize: 12
		on: root
]

{ #category : 'helpers' }
PpGtdWorkflowExamples class >> addRoute: points arrow: hasArrow on: root [
	1 to: points size - 1 do: [ :index |
		self
			addSegmentFrom: (points at: index)
			to: (points at: index + 1)
			arrow: (hasArrow and: [ index = (points size - 1) ])
			on: root ]
]

{ #category : 'helpers' }
PpGtdWorkflowExamples class >> addSegmentFrom: fromPoint to: toPoint arrow: hasArrow on: root [
	| fromPort toPort line |

	fromPort := self addPortAt: fromPoint on: root.
	toPort := self addPortAt: toPoint on: root.

	line := BlLineElement new.
	line constraints ignoreByLayout.

	line
		zIndex: -1;
		border: (BlBorder
			paint: Color darkGray
			width: 1.5);
		fromAnchor: (BlElementTopCenterAnchor element: fromPort);
		toAnchor: (BlElementTopCenterAnchor element: toPort).

	hasArrow ifTrue: [
		line toHead:
			(BlArrowheadSimpleArrow new
				border: (BlBorder builder
					paint: Color darkGray;
					width: 2;
					build)) ].

	root addChild: line.

	^ line
]

{ #category : 'building' }
PpGtdWorkflowExamples class >> addWorkflowHeaderOn: root [
	| header label |

	header := BlElement new
		layout: BlFrameLayout new;
		size: 1060 @ 50;
		relocate: 20 @ 20;
		background: (Color lightBlue alpha: 0.35);
		yourself.

	label := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
			bold;
			fontSize: 21;
			foreground: Color darkGray;
			yourself);
		text: 'GTD WORKFLOW — CLARIFYING & ORGANIZING';
		constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		yourself.

	header addChild: label.
	root addChild: header
]

{ #category : 'helpers' }
PpGtdWorkflowExamples class >> borderWidthForNodeId: anId [
	(self isQuestionNodeId: anId) ifTrue: [
		^ 2 ].

	^ 1
]

{ #category : 'helpers' }
PpGtdWorkflowExamples class >> fillColorForNodeId: anId [
	(self isDestinationNodeId: anId) ifTrue: [
		^ Color veryLightGray ].

	^ Color white
]

{ #category : 'helpers' }
PpGtdWorkflowExamples class >> fontSizeForNodeId: anId [
	anId = #nextAction ifTrue: [
		^ 18 ].

	^ 14
]

{ #category : 'examples' }
PpGtdWorkflowExamples class >> gtdWorkflowElement [
	<gtExample>
	<return: #BlElement>

	| root |

	root := self newWorkflowRoot.

	self addWorkflowHeaderOn: root.

	self addCaptureAndClarifyNodesOn: root.
	self addNonActionableNodesOn: root.
	self addProjectAndNextActionNodesOn: root.
	self addActionChoiceNodesOn: root.
	self addActionOrganizationNodesOn: root.

	self addCaptureAndClarifyRoutesOn: root.
	self addNonActionableRoutesOn: root.
	self addProjectAndNextActionRoutesOn: root.
	self addActionChoiceRoutesOn: root.
	self addActionOrganizationRoutesOn: root.

	^ root asPannableElement
]

{ #category : 'helpers' }
PpGtdWorkflowExamples class >> isDestinationNodeId: anId [
	^ #(
		trash
		somedayMaybe
		dateTrigger
		reference
		projects
		projectSupport
		waitingFor
		calendar
		nextActions
	) includes: anId
]

{ #category : 'helpers' }
PpGtdWorkflowExamples class >> isQuestionNodeId: anId [
	^ #(
		whatIsIt
		actionable
		nextAction
	) includes: anId
]

{ #category : 'building' }
PpGtdWorkflowExamples class >> newWorkflowRoot [
	| root |

	root := BlElement new
		size: 1120 @ 980;
		background: Color white;
		clipChildren: false;
		yourself.

	^ root
]
