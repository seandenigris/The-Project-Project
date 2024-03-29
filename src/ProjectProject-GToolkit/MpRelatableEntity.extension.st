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
		column: 'Item' text: [ :p | p titleWithAncestorsGtText ] weight: 3;
		column: 'Due Date' text: [ :p | p dueDateString ] weight: 1;
		actionUpdateButton
]
