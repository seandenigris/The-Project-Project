Extension { #name : #MpPerson }

{ #category : #'*ProjectProject-GToolkit' }
MpPerson >> gtViewAgendaOn: aView [
	<gtView>
	
	| agenda |
	agenda := self projects.
	
	agenda allChildren ifEmpty: [ ^ aView empty ].
	
	^ aView forward
		title: 'Agenda' translated;
		priority: 55;
		object: agenda;
		view: #gtViewProjectsFor:;
		actionUpdateButton
]
