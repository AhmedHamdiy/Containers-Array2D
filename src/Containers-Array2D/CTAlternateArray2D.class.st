"
Class inspired by from the book ""Fundamentals of Smalltalk Programming Technique""


The first element of an array2D is located on topleft corner.
"
Class {
	#name : 'CTAlternateArray2D',
	#superclass : 'Object',
	#instVars : [
		'rows',
		'dimension'
	],
	#category : 'Containers-Array2D',
	#package : 'Containers-Array2D'
}

{ #category : 'examples' }
CTAlternateArray2D class >> width2Height3 [
	<sampleInstance>
	"self width2Height3"
	| i |
	i := self new dimension: 2@3.
	i at: 1@1 put: 1.
	i at: 2@1 put: 2.
	i at: 1@2 put: 3.
	i at: 2@2 put: 4.
	i at: 1@3 put: 5.
	i at: 2@3 put: 6.
	^ i
]

{ #category : 'iterate' }
CTAlternateArray2D >> allPositionsDo: aBlock [
	"Execute a Block on all the positions (points) of the receiver."
	1 to: self height do: [ :y |
        1 to: self width do: [ :x |aBlock value: (x @ y)]]
]

{ #category : 'iterate' }
CTAlternateArray2D >> allPositionsWithin: someDistance from: someOrigin [
	| answer xRange yRange |
	answer := OrderedCollection new.
	xRange := (someOrigin x - someDistance x max: 1) to:
		(someOrigin x + someDistance x min: self width).

	yRange := (someOrigin y - someDistance y max: 1) to:
		(someOrigin y + someDistance y min: self height).

	yRange do: [ :y |
		answer addAll: (xRange collect: [ :x | x @ y ]) ].

	^ answer
]

{ #category : 'accessing' }
CTAlternateArray2D >> at: aPoint [
	| row |
	row := self atRow: aPoint y.
	^ row at: aPoint x
]

{ #category : 'accessing' }
CTAlternateArray2D >> at: aPoint put: anObject [
	| row |
	row := self atRow: aPoint y.
	row atWrap: aPoint x put: anObject
]

{ #category : 'accessing' }
CTAlternateArray2D >> atRow: anInteger [
	^ self rows at: anInteger 
]

{ #category : 'accessing' }
CTAlternateArray2D >> dimension [
	^ dimension
]

{ #category : 'initialize' }
CTAlternateArray2D >> dimension: aPoint [
	dimension := aPoint.
	self initializeRows
]

{ #category : 'iterate' }
CTAlternateArray2D >> do: aBlock [
	self rowsDo: [ :eachRow | eachRow do: aBlock ]
]

{ #category : 'accessing' }
CTAlternateArray2D >> firstPosition [
	^ 1@1
]

{ #category : 'accessing' }
CTAlternateArray2D >> height [
	^ self dimension y
]

{ #category : 'initialize' }
CTAlternateArray2D >> initialize [
	self dimension: 0@0
]

{ #category : 'initialize' }
CTAlternateArray2D >> initializeRows [
	| newRows |
	newRows := (1 to: self height) collect: [ :each | self newRow ].
	self rows: newRows asArray 
]

{ #category : 'private' }
CTAlternateArray2D >> newRow [
	^ self newRowWithWidth: self width 
]

{ #category : 'private' }
CTAlternateArray2D >> newRowWithWidth: anInteger [
	^ Array new: anInteger  
]

{ #category : 'copying' }
CTAlternateArray2D >> postCopy [
	| newRows |
	super postCopy.
	newRows := self rows collect: [  :each | each copy ].
	self rows: newRows
]

{ #category : 'accessing' }
CTAlternateArray2D >> rows [
	^ rows
]

{ #category : 'accessing' }
CTAlternateArray2D >> rows: someRows [
	rows := someRows
]

{ #category : 'iterate' }
CTAlternateArray2D >> rowsDo: aBlock [
	self rows do: aBlock 
]

{ #category : 'accessing' }
CTAlternateArray2D >> size [
	^ self dimension x * self dimension y
]

{ #category : 'private' }
CTAlternateArray2D >> storageIndexFor: aPoint [
	^ aPoint y - 1 * self dimension x + aPoint x
]

{ #category : 'accessing' }
CTAlternateArray2D >> width [
	^ self dimension x
]
