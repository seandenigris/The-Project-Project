Class {
	#name : #PpChecklist,
	#superclass : #Object,
	#instVars : [
		'title',
		'items'
	],
	#classVars : [
		'Pad'
	],
	#category : #'ProjectProject-Core-Checklists'
}

{ #category : #adding }
PpChecklist class >> addFromClipboard [
	"This is an easy way to create a new checklist, because one can make the list anywhere text can be typed (e.g. a playground, text editor, browser URL bar lol). Just put each item on a separate line and copy to the system clipboard"
	
	<script>
	^ self pad add: (self new addAllFromClipboard)
]

{ #category : #'world menu' }
PpChecklist class >> menuCommandOn: aBuilder [ 
	"Add a custom menu item to the world menu"	
	<worldMenu> 
	
	(aBuilder item: #'Checklists') with: [
		(aBuilder item: #'Browse')
			action: [ PpChecklist pad inspect ].
		(aBuilder item: #'Add from clipboard')
			action: [ PpChecklist addFromClipboard inspect ] ].

]

{ #category : #accessing }
PpChecklist class >> pad [
	^ Pad ifNil: [ Pad := OrderedCollection new ]
]

{ #category : #accessing }
PpChecklist class >> pad: anObject [
	Pad := anObject
]

{ #category : #persistence }
PpChecklist class >> restoreFrom: anObject [
	self pad: anObject.
]

{ #category : #persistence }
PpChecklist class >> spData [
	^ self pad
]

{ #category : #adding }
PpChecklist >> addAllFromClipboard [
	| itemsString |
	itemsString := Clipboard clipboardText asString.
	itemsString lines do: [ :e |
		| item |
		item := PpChecklistItem new
			description: e trimBoth;
			yourself.
		self items add: item ]
]

{ #category : #adding }
PpChecklist >> addItemNamed: aString [
	^ self items add: (PpChecklistItem new description: aString; yourself)
]

{ #category : #Magritte }
PpChecklist >> descriptionItems [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #items;
		classes: { PpChecklistItem };
		yourself
]

{ #category : #Magritte }
PpChecklist >> descriptionView [
	<magritteActionDescription>
	^ MAActionDescription new
		action: #morphOpen;
		yourself
]

{ #category : #accessing }
PpChecklist >> items [
	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #accessing }
PpChecklist >> items: anObject [
	items := anObject
]

{ #category : #viewing }
PpChecklist >> morphOpen [
	| panel win scrollpane |
	scrollpane := GeneralScrollPane new.
	scrollpane changeScrollerTableLayout.
	panel := PanelMorph new
		changeTableLayout;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		cellInset: 0 @ -7;
		yourself.
	scrollpane
		scrollTarget: panel;
		hResizing: #shrinkWrap;
		height: 400.
	self items do: [ :i | panel addMorphBack: i asMorph buildWithSpec ].
	scrollpane
		hResizing: #shrinkWrap;
		height: 400.
	win := scrollpane openInWindowLabeled: self title.
	win extent:  559.0@457.0
]

{ #category : #printing }
PpChecklist >> printOn: aStream [
	title
		ifNotNil: [ aStream nextPutAll: title ]
		ifNil: [ 
			super printOn: aStream.
			items printElementsOn: aStream ].
]

{ #category : #accessing }
PpChecklist >> title [
	^ title
]

{ #category : #accessing }
PpChecklist >> title: anObject [
	title := anObject
]
