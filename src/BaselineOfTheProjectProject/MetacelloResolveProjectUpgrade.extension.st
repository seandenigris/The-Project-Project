Extension { #name : #MetacelloResolveProjectUpgrade }

{ #category : #'*BaselineOfTheProjectProject' }
MetacelloResolveProjectUpgrade >> theProjectProjectResolve [
	
	| urlStrings |
	urlStrings := #(
		'github://pharo-contributions/XML-XMLWriter:v3.1.x/src'.
		'github://pharo-contributions/OrderPreservingDictionary:v1.6.x/src'
		'github://pharo-contributions/BitmapCharacterSet:v1.2.x/src'
		'github://pharo-contributions/XML-XMLParser'
	).
	
	(urlStrings anySatisfy: [ :aString | self newProjectRegistration printString endsWith: aString ]) ifTrue: [ ^ self useIncoming ].
	(urlStrings anySatisfy: [ :aString | self existingProjectRegistration printString endsWith: aString ]) ifTrue: [ ^ self useExisting ].
	
	^ self pass
]
