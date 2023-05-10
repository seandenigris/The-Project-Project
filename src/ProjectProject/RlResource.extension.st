Extension { #name : #RlResource }

{ #category : #'*ProjectProject' }
RlResource >> ppSupportMaterialDisplayString [

	^ self name ifNil: [ self displayString ]
]
