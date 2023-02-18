Extension { #name : #LeTextSnippet }

{ #category : #'*ProjectProject-GToolkit' }
LeTextSnippet >> asPpProject: aClass [

	| result |
	result := aClass new
		title: self string;
		yourself.
		
	result 
		propertyAt: #source
		put: self olAsReference. "or should it be added to sourceMaterials?"
	
	^ result
]
