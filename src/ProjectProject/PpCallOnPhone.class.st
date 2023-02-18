"
# Pros
- immediate
- good if sensitive

# Cons
- diverts attention on both sides
- no written record
"
Class {
	#name : #PpCallOnPhone,
	#superclass : #PpContactStrategy,
	#category : #'ProjectProject-Core-Projects-Support'
}

{ #category : #accessing }
PpCallOnPhone class >> label [

	^ 'Call'
]

{ #category : #accessing }
PpCallOnPhone class >> modelClass [

	^ PpPhoneCall
]

{ #category : #accessing }
PpCallOnPhone class >> priority [

	^ 400
]
