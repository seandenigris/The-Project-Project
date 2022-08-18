"
# Benefits
- Fast to process
- complements paper-based materials
- recipient has a physical item as a reminder
- receiver can deal with at their convenience
"
Class {
	#name : #PpWriteNote,
	#superclass : #PpContactStrategy,
	#category : #'ProjectProject-Core-Projects-Support'
}

{ #category : #accessing }
PpWriteNote class >> label [

	^ 'Write to'
]

{ #category : #accessing }
PpWriteNote class >> priority [

	^ 200
]
