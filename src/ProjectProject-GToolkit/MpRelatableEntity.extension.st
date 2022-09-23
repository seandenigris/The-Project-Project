Extension { #name : #MpRelatableEntity }

{ #category : #'*ProjectProject-GToolkit' }
MpRelatableEntity >> gtViewAgendaOn: aView [
	<gtView>
	
	self projects allChildren ifEmpty: [ ^ aView empty ].
	
	^ aView columnedTree
		title: 'Agenda' translated;
		priority: 55;
		items: [ self projects rootChildren ];
		children: #parents;
		column: 'Item' text: [ :p | p gtTextTitleWithParents ] weight: 3;
		column: 'Due Date' text: [ :p | p dueDateDescription readToString: p ] weight: 1;
		actionUpdateButtonTooltip: 'Update'
]
