Class {
	#name : #PpChecklistItemMorph,
	#superclass : #ComposableModel,
	#instVars : [
		'checkbox',
		'textField'
	],
	#category : 'ProjectProject-Core-Checklists'
}

{ #category : #specs }
PpChecklistItemMorph class >> defaultSpec [
<spec>
	^ SpecLayout composed
			newRow: [:row | row
				add: #checkbox width: 25;
				add: #textField ] height: 35;
		yourself
]

{ #category : #accessing }
PpChecklistItemMorph >> buildWithSpecLayout: layout [
	| result |
	result := super buildWithSpecLayout: layout.
	textField morph owner cellPositioning: #leftCenter.
	"textField morph hResizing: #spaceFill."
	^ result
		vResizing: #rigid;
		yourself
]

{ #category : #accessing }
PpChecklistItemMorph >> checkbox [
	^ checkbox
]

{ #category : #accessing }
PpChecklistItemMorph >> checkbox: anObject [
	checkbox := anObject
]

{ #category : #initialization }
PpChecklistItemMorph >> initializePresenter [
	checkbox whenActivatedDo: [ self strikeOutText ].
	checkbox whenDeactivatedDo: [ self unstrikeText ]
]

{ #category : #initialization }
PpChecklistItemMorph >> initializeWidgets [

	checkbox := self newCheckBox.
	textField := "self newText "TextMorph new asSpecAdapter.
]

{ #category : #accessing }
PpChecklistItemMorph >> model: aPpChecklistItem [
	self text: aPpChecklistItem description asText
]

{ #category : #emphasizing }
PpChecklistItemMorph >> strikeOutText [
	"There is a bug in TextModel which ignores text attribute changes unless the string also changes. Otherwise, this method would be a simple one-liner."
	| originalText |
	originalText := self text.
	self
		text: originalText, '.';
		text: (originalText addAttribute: TextEmphasis struckOut)
]

{ #category : #accessing }
PpChecklistItemMorph >> text [
	^ self textField "text "morph contents
]

{ #category : #accessing }
PpChecklistItemMorph >> text: aText [
	self textField "text: "morph contents: aText
]

{ #category : #accessing }
PpChecklistItemMorph >> textField [
	^ textField
]

{ #category : #accessing }
PpChecklistItemMorph >> textField: anObject [
	textField := anObject
]

{ #category : #emphasizing }
PpChecklistItemMorph >> unstrikeText [
	"There is a bug in TextModel which ignores text attribute changes unless the string also changes. Otherwise, this method would be a simple one-liner."
	| originalText |
	originalText := self text.
	self
		text: originalText, '.';
		text: (originalText addAttribute: TextEmphasis normal)
]
