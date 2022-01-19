Class {
	#name : #PpLeTranscriptLineSnippetElement,
	#superclass : #LeTextCoderSnippetElement,
	#instVars : [
		'snippetToolbar',
		'sourceLabel',
		'speakerLabel',
		'speakerChooser'
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
		valuable: [ self snippetViewModel snippetModel page type event participants ];
		icon: BrGlamorousVectorIcons search;
		spotterModelDo: [ :sm |
			sm announcer
				when: GtSpotterActOn
				do: [ :evt | 
					speakerLabel text: evt element.
					self editorElement requestFocus.
					evt actedUpon: true. ] ];
		create
]

{ #category : #accessing }
PpLeTranscriptLineSnippetElement >> onSnippetViewModelChanged [
	"self onSourceChanged."
	super onSnippetViewModelChanged.
]

{ #category : #accessing }
PpLeTranscriptLineSnippetElement >> onSnippetViewModelFocused: aBoolean [

	aBoolean ifFalse: [ ^ self ].
	
	self flag: 'waiting for help on shortcut actions via Discord'.
	"speakerChooser requestFocus."
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
		
	speakerChooser := self newSearchButton
		"addShortcut: Character space asShortcut;"
		yourself.
		
	speakerLabel := BrEditor new 
		aptitude: BrGlamorousEditorAptitude new;
		hFitContent;
		vFitContent.
	
	^ result
		addChild: speakerChooser;
		addChild: speakerLabel;
		addChild: self editorElement;
		yourself
]

{ #category : #accessing }
PpLeTranscriptLineSnippetElement >> snippetToolbar [

	^ nil
]
