Extension { #name : #MetacelloResolveProjectUpgrade }

{ #category : #'*BaselineOfTheProjectProject' }
MetacelloResolveProjectUpgrade >> theProjectProjectResolve [
	
	"XMLParser - depedencies were conflicting, just use the baseline version"
	self projectName = 'XMLParser' ifFalse: [ ^ self pass ].
	self newProjectRegistration baselineProjectSpec versionString = 'baseline' ifTrue: [ ^ self useIncoming ].
	self existingProjectRegistration baselineProjectSpec versionString = 'baseline' ifTrue: [ ^ self useExisting ].
	
	^ self pass
]
