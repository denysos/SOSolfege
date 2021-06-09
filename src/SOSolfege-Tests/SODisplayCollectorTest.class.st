Class {
	#name : #SODisplayCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'aDisplayCollector',
		'aDraw',
		'aTry',
		'aNoteSet'
	],
	#category : #'SOSolfege-Tests-core'
}

{ #category : #running }
SODisplayCollectorTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	aDisplayCollector := SODisplayCollector new.
	aNoteSet := SONoteSet newFullNoteSet.
	aDraw := (aNoteSet subsetAtRandomWith: 3)
		setOriginTo: #asGeneratorNote.
	aTry := (aNoteSet subsetAtRandomWith: 3) setOriginTo: #asKeyboardNote
]

{ #category : #test }
SODisplayCollectorTest >> testAddNewDraw [
	self assert: aDisplayCollector isEmpty.
	aDisplayCollector addNewDraw: aDraw.
	self deny: aDisplayCollector isADrawEmpty.
	self assert: aDisplayCollector isATryEmpty.
	aDisplayCollector getCollectedDrawAndTry aDraw
		ranksDo: [ :eachNote | self assert: eachNote class equals: SOGeneratorNote ].

]

{ #category : #test }
SODisplayCollectorTest >> testAddNewTry [
	self assert: aDisplayCollector isEmpty.
	aDisplayCollector addNewTry: aTry.
	self deny: aDisplayCollector isATryEmpty.
	self assert: aDisplayCollector isADrawEmpty.
	aDisplayCollector getCollectedDrawAndTry aTry
		ranksDo: [ :eachNote | self assert: eachNote class equals: SOKeyboardNote ]
]

{ #category : #test }
SODisplayCollectorTest >> testResetDisplay [
	self assert: aDisplayCollector isEmpty.
	aDisplayCollector addNewDraw: aDraw.
	self deny: aDisplayCollector isADrawEmpty.
	aDisplayCollector addNewTry: aTry.
	self deny: aDisplayCollector isATryEmpty.
	aDisplayCollector resetDisplay.
	self assert: aDisplayCollector isEmpty
]
