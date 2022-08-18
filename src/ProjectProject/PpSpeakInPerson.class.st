"
# Pros
- good if sensitive

# Cons
- diverts attention on both sides
- may delay completion if person not immediately available
- no written record
"
Class {
	#name : #PpSpeakInPerson,
	#superclass : #PpContactStrategy,
	#category : #'ProjectProject-Core-Projects-Support'
}

{ #category : #accessing }
PpSpeakInPerson class >> label [

	^ 'Meet'
]

{ #category : #accessing }
PpSpeakInPerson class >> priority [

	^ 500
]
