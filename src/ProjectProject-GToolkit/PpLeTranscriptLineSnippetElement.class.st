Class {
	#name : #PpLeTranscriptLineSnippetElement,
	#superclass : #LeTextCoderSnippetElement,
	#instVars : [
		'snippetToolbar',
		'sourceLabel'
	],
	#category : #'ProjectProject-GToolkit'
}

{ #category : #accessing }
PpLeTranscriptLineSnippetElement >> initialize [

	super initialize.
	
	snippetToolbar := BrHorizontalPane new
		hMatchParent;
		padding: (BlInsets top: 4 bottom: 4);
		alignCenterLeft;
		cellSpacing: 5;
		vFitContent.
		
	sourceLabel := BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		beSmallSize;
		addEventHandlerOn: BlClickEvent
			do: [ :evt | 
				self snippetViewModel snippetModel source 
					ifNotNil: [ :src | evt target phlow spawnObject: src ] ];
		text: ''.
		
	snippetToolbar
		addChild: (BrEditor new
		aptitude: BrGlamorousEditorAptitude new;
			"aptitude: BrGlamorousLabelAptitude;
			beSmallSize;"
			text: 'Source:');
		addChild: sourceLabel;
		addChild: self newSearchButton
]

{ #category : #accessing }
PpLeTranscriptLineSnippetElement >> newSearchButton [

	^ GtSpotterDropdownButtonStencil new
		valuable: [ self snippetViewModel snippetModel ];
		icon: BrGlamorousVectorIcons search;
		spotterModelDo: [ :sm |
			sm announcer
				when: GtSpotterActOn
				do: [ :evt | 
					self snippetViewModel snippetModel sourceID: evt element ensureUUID.
					self onSourceChanged.
					evt actedUpon: true. ] ];
		create
]

{ #category : #accessing }
PpLeTranscriptLineSnippetElement >> onSnippetViewModelChanged [
	"self onSourceChanged."
	super onSnippetViewModelChanged.
]

{ #category : #accessing }
PpLeTranscriptLineSnippetElement >> snippetContent [
	| result |
	result := BrHorizontalPane new
		hMatchParent;
		padding: (BlInsets top: 4 bottom: 4);
		alignCenterLeft;
		cellSpacing: 5;
		vFitContent.
	
	^ result
		addChild: (BrEditor new aptitude: BrGlamorousEditorAptitude new;"aptitude: BrGlamorousLabelAptitude;
			beSmallSize;"
			text: 'hi'; hFitContent; vFitContent);
		addChild: self editorElement;
		yourself
]

{ #category : #accessing }
PpLeTranscriptLineSnippetElement >> snippetToolbar [

	^ nil
]
