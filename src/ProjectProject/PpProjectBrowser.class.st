Class {
	#name : #PpProjectBrowser,
	#superclass : #SpPresenter,
	#category : #'ProjectProject-UI-Morphic'
}

{ #category : #building }
PpProjectBrowser >> compose [
	self tabulator with: [ :browser |
		browser
			initialExtent: 1250@500;
			column: [ :c |
				c row: #list span: 2 ];
			column: #detail span: 2;
			yourself.

	browser transmit 
		to: #list; 
 		andShow: [ :a :b | self projectListsIn: a for: b ].

	browser transmit 
		from: #list;
		to: #detail;
		andShow: [ :a |a magritte ] ]

]

{ #category : #building }
PpProjectBrowser >> doesProject: project matchFilterString: text [
	| source isBlock | 
	isBlock := text first = $[. 
	source := isBlock ifTrue: [ text, ' value' ] ifFalse: [ 'e title asLowercase includesSubstring: ', text printString, ' asLowercase' ].
	^ [ Smalltalk compiler
				source: source;
				bindings: { #e -> project } asDictionary;
				logged: false;
				receiver: project;
				evaluate ] on: Exception do: [ true ]
]

{ #category : #building }
PpProjectBrowser >> listTextFor: aProject [
	^ aProject isComplete
			ifTrue: [ 
				aProject displayString asText
					addAttribute: TextEmphasis struckOut;
					yourself ]
			ifFalse: [ aProject displayString ]
]

{ #category : #building }
PpProjectBrowser >> projectListsIn: container for: projectList [
	(projectList magritteAllDescriptionsFor: #childrenDescription)
		do: [ :d | 
			container tree
				glmAddActions;
				act: [ :tree :projects | tree pane update ]
					on: $u
					entitled: 'Update';
				display: [ :l | 
					| value |
					value := d read: projectList ];
				title: d label;
				children: #children;
				glmAddSelectionActions;
				filterOn: [ :text :each | self doesProject: each matchFilterString: text ];
				helpMessage: 'Filter (either block or title match)';
				format: [ :p | self listTextFor: p ] ]
]
