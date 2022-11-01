Extension { #name : #MsalOneNotePage }

{ #category : #'*ProjectProject' }
MsalOneNotePage >> asPpProject [

	| result |
	result := PpProject titled: self title.
	result status timestamp: self creationTimestamp.			
	^ result
]

{ #category : #'*ProjectProject' }
MsalOneNotePage >> delete [

	self application delete: self url.
	
	"Reference: https://learn.microsoft.com/en-us/graph/api/page-delete?view=graph-rest-1.0&tabs=http"
]

{ #category : #'*ProjectProject' }
MsalOneNotePage >> htmlBody [

	^ self htmlDocument findElementNamed: #body.
]

{ #category : #'*ProjectProject' }
MsalOneNotePage >> moveToPpProject [
	| project |
	project := self asPpProject.
	PpProjectList uniqueInstance addChild: project.
	self delete.
	^ project
]
