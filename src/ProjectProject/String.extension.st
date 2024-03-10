Extension { #name : #String }

{ #category : #'*ProjectProject' }
String >> asPpNote [

	^ PpNote fromString: self
]
