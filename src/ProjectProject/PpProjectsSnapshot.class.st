Class {
	#name : #PpProjectsSnapshot,
	#superclass : #PpAbstractProjectContainer,
	#instVars : [
		'children'
	],
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpProjectsSnapshot >> allChildren [
	^ children
]

{ #category : #accessing }
PpProjectsSnapshot >> asOrderedCollection [
	^ self rootChildren
]

{ #category : #magritte }
PpProjectsSnapshot >> childrenDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
			label: 'Projects (roots)';
			priority: 100;
			default: Bag new;
			classes: { PpProject };
			yourself
]

{ #category : #accessing }
PpProjectsSnapshot >> childrenLabel [
	^ 'Projects'
]

{ #category : #accessing }
PpProjectsSnapshot >> dueBy: aDate [
	"For a list, we want to search recursively so that we don't miss a child buried way down that is due"
	^ self newFromChildrenBlock: [ 
		self activeChildrenList allChildren
			inject: Bag new
			into: [ :result :root |
				root allChildrenDo: [ :e |
					(e isActiveDueBy: aDate)
						ifTrue: [ result add: e ] ].
				result ] ]
]

{ #category : #magritte }
PpProjectsSnapshot >> gtMagritteFor: aView [
	"Suppress GT4Magritte's form view, which is slow and not particularly useful for project lists"
	^ aView empty
]

{ #category : #magritte }
PpProjectsSnapshot >> maGtFormFor: aView [
	"Deprioritize this view because it is not very useful and super slow"
	
	^ (super maGtFormFor: aView)
		priority: 190
]

{ #category : #accessing }
PpProjectsSnapshot >> rootChildren [
	^ children ifNil: [ children := OrderedCollection new ]
]

{ #category : #accessing }
PpProjectsSnapshot >> rootChildren: aCollection [
	children := aCollection
]
