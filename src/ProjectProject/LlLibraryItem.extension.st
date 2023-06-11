Extension { #name : #LlLibraryItem }

{ #category : #'*ProjectProject' }
LlLibraryItem >> ppSupportMaterialDisplayString [

	^ self name ifNil: [ self displayString ]
]
