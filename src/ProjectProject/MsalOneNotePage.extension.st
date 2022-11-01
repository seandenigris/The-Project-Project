Extension { #name : #MsalOneNotePage }

{ #category : #'*ProjectProject' }
MsalOneNotePage >> asPpProject [

	| result body |
	
	result := PpProject titled: self title.
	result status timestamp: self creationTimestamp.
	
	body := self htmlDocument findElementNamed: #body.
	body descendantElements
		detect: [ :el | el name = 'a' and: [ LlTweet peCanHandleFromString: (el attributeAt: #href) ] ]
		ifFound: [ :el |
			| tweet urlString |
			urlString := el attributeAt: #href.
			tweet := LlTweet fromString: urlString.
			"In iOS, sharing from the Twitter app to One Note duplicates the Tweet URL in the content and title, which doesn't seem that useful"
			result title = urlString ifTrue: [ result title: 'Review tweet from ', tweet user ].
			result supportMaterials add: tweet ].
			
	^ result
]

{ #category : #'*ProjectProject' }
MsalOneNotePage >> delete [

	self application delete: self url.
	
	"Reference: https://learn.microsoft.com/en-us/graph/api/page-delete?view=graph-rest-1.0&tabs=http"
]

{ #category : #'*ProjectProject' }
MsalOneNotePage >> moveToPpProject [
	| project |
	project := self asPpProject.
	PpProjectList uniqueInstance addChild: project.
	self delete.
	^ project
]
