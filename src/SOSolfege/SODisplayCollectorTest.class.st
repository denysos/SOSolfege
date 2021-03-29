Class {
	#name : #SODisplayCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'aDisplayCollector',
		'aDraw',
		'aTry',
		'aNoteSet'
	],
	#category : #'SOSolfege-tests'
}

{ #category : #running }
SODisplayCollectorTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
aDisplayCollector := SODisplayCollector new .

aNoteSet := SONoteSet newFullNoteSet .
aDraw := aNoteSet subsetAtRandomWith: 3.
aTry := aNoteSet subsetAtRandomWith: 3.


]

{ #category : #test }
SODisplayCollectorTest >> testAddNewDraw [
	self assert: aDisplayCollector isEmpty.
	aDisplayCollector addNewDraw: aDraw.
	self deny: aDisplayCollector isADrawEmpty.
	self assert: aDisplayCollector isATryEmpty 
]

{ #category : #test }
SODisplayCollectorTest >> testAddNewTry [
	self assert: aDisplayCollector isEmpty.
	aDisplayCollector addNewTry: aTry.
	self deny: aDisplayCollector isATryEmpty.
	self assert: aDisplayCollector isADrawEmpty
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
