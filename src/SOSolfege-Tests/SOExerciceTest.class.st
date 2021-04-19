Class {
	#name : #SOExerciceTest,
	#superclass : #TestCase,
	#instVars : [
		'anExercice',
		'aNoteSet'
	],
	#category : #'SOSolfege-Tests-core'
}

{ #category : #running }
SOExerciceTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	aNoteSet := SONoteSet new
		addANoteWithRank: 1;
		addANoteWithRank: 3;
		addANoteWithRank: 5;
		addANoteWithRank: 7;
		yourself.
	anExercice := SOExercice new
		noteSet: aNoteSet;
		notesNumberInADraw: 2;
		maxNotesRange: 10;
		tempo: 60;
		info: 'test info';
		yourself
]

{ #category : #'as yet unclassified' }
SOExerciceTest >> testInfo [
	self assert: anExercice info equals: 'test info'
]

{ #category : #tests }
SOExerciceTest >> testMaxNotesRange [
	self assert: anExercice maxNotesRange equals: 10
]

{ #category : #'as yet unclassified' }
SOExerciceTest >> testNotesNumberInADraw [
	self assert: anExercice notesNumberInADraw equals: 2
]

{ #category : #tests }
SOExerciceTest >> testSelectMeAsNew [
	| aNewExercice |
	aNewExercice := anExercice selectMeAsNew.
	self deny: aNewExercice identicalTo: anExercice.
	self assert: aNewExercice info equals: anExercice info.
	self assert: aNewExercice maxNotesRange equals: anExercice maxNotesRange.
	self deny: aNewExercice noteSet identicalTo: anExercice noteSet.	"!!! ne doit pas être identique !!!"
	self
		assert: aNewExercice notesNumberInADraw
		equals: anExercice notesNumberInADraw.
	self assert: aNewExercice tempo equals: anExercice tempo
]

{ #category : #'as yet unclassified' }
SOExerciceTest >> testTempo [
	self assert: anExercice tempo equals: 60
]

{ #category : #'as yet unclassified' }
SOExerciceTest >> testnoteSet [
	self assert: anExercice noteSet class equals: SONoteSet.
	"self
		assert:
			(#(1 3 5 7)
				includes: ((anExercice noteSet subsetAtRandomWith: 1) ranksDo: [ :each | each printString  ]) )"
]
