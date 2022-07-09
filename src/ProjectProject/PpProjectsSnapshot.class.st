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
	^ children ifNil: [ children := Array new ]
]

{ #category : #accessing }
PpProjectsSnapshot >> allChildren: aCollection [
	children := aCollection
]

{ #category : #accessing }
PpProjectsSnapshot >> asOrderedCollection [
	^ self rootChildren
]

{ #category : #magritte }
PpProjectsSnapshot >> childrenDescription [
	<magritteDescription>
	
	^ super childrenDescription
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

{ #category : #accessing }
PpProjectsSnapshot >> gtViewGraphFor: aView [
	<gtView>
	| nodes |
	nodes := self allChildren asOrderedCollection 
		add: self; 
		yourself.
	^ aView mondrian
		title: 'Graph';
		painting: [ :m |
			m nodes
				stencil: [ :obj | 
					BlTextElement new
						text: obj gtDisplayText;
						background: Color white;
						margin: (BlInsets all: 20);
						padding: (BlInsets all: 5);
						effect:
							(BlGaussianShadowEffect
								color: (Color gray alpha: 0.5)
								width: 5
								offset: 0 @ 0);
						yourself ];
				with: nodes.
			m edges 
				connect: (nodes reject: [ :n | n rootChildren isEmpty]) 
				fromAll: [ :n | n rootChildren ].
			m layout horizontalTree.
			m ]
]

{ #category : #magritte }
PpProjectsSnapshot >> maGtFormFor: aView [
	"Deprioritize this view because it is not very useful and super slow"
	
	^ (super maGtFormFor: aView)
		priority: 190
]

{ #category : #accessing }
PpProjectsSnapshot >> rootChildren [
	^ self allChildren select: [ :c | 
		self dependencyLinks noneSatisfy: [ :link |
			link dependency = c ] ]
]
