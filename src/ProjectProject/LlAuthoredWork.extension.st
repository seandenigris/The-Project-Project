Extension { #name : #LlAuthoredWork }

{ #category : #'*ProjectProject' }
LlAuthoredWork >> isbn [

	^ self
		propertyAt: #isbn
		ifAbsent: [ nil ]
]

{ #category : #'*ProjectProject' }
LlAuthoredWork >> isbn: aString [
	"aString - ISBNs are acutally numbers, but may be padded with zeroes. The number of zeroes (i.e. 9 vs. 10 vs. 13 digit ISBN format) seems to matter. For example, Open Library Cover API fails if leading zero(s) are omitted or repeated. Therefore, we can't store a number"

	^ self
		propertyAt: #isbn
		putRemovingNil: aString
]
