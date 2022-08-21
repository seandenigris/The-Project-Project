Extension { #name : #MpPerson }

{ #category : #'*ProjectProject-GToolkit' }
MpPerson >> gtViewAgendaOn: aView [
	<gtView>
	
	self projects allChildren ifEmpty: [ ^ aView empty ].
	
	^ aView forward
		title: 'Agenda' translated;
		priority: 55;
		object: [ self projects ];
		view: #gtViewProjectsFor:;
		actionUpdateButton
]
