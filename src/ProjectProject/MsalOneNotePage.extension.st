Extension { #name : #MsalOneNotePage }

{ #category : #'*ProjectProject' }
MsalOneNotePage >> asPpProject [
	^ PpProject titled: self title.
]

{ #category : #'*ProjectProject' }
MsalOneNotePage >> delete [

	self application delete: self url.
	
	"Reference: https://learn.microsoft.com/en-us/graph/api/page-delete?view=graph-rest-1.0&tabs=http"
]

{ #category : #'*ProjectProject' }
MsalOneNotePage >> moveToPpProject [
	PpProjectList uniqueInstance addChild: self asPpProject.
	self delete.
]
