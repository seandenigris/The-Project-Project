"
Built in subclasses are from GTD Chapter 8 - ""Delegate It""
"
Class {
	#name : #PpContactStrategy,
	#superclass : #Object,
	#category : #'ProjectProject-Core-Projects-Support'
}

{ #category : #accessing }
PpContactStrategy class >> all [

	^ (self subclasses sort: #priority ascending) collect: #new
]

{ #category : #accessing }
PpContactStrategy >> = rhs [
	^ self class = rhs class
]

{ #category : #accessing }
PpContactStrategy >> hash [
	^ self class hash
]
