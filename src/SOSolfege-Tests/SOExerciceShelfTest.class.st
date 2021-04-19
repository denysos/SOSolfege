"
A SOExerciceShelfTest is a test class for testing the behavior of SOExerciceShelf
"
Class {
	#name : #SOExerciceShelfTest,
	#superclass : #TestCase,
	#instVars : [
		'anExercicesShelf',
		'aNoteSet',
		'exercice1',
		'exercice2',
		'exercice3'
	],
	#category : #'SOSolfege-Tests-core'
}

{ #category : #running }
SOExerciceShelfTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	anExercicesShelf := SOExerciceShelf new.
	aNoteSet := SONoteSet new
		addANoteWithRank: 1;
		addANoteWithRank: 3;
		addANoteWithRank: 5;
		addANoteWithRank: 7;
		yourself.
	exercice1 := SOExercice new
		noteSet: aNoteSet;
		notesNumberInADraw: 2;
		maxNotesRange: 10;
		tempo: 61;
		info: 'test info';
		yourself.
	exercice2 := SOExercice new
		noteSet: aNoteSet;
		notesNumberInADraw: 2;
		maxNotesRange: 10;
		tempo: 62;
		info: 'test info';
		yourself.
	exercice3 := SOExercice new
		noteSet: aNoteSet;
		notesNumberInADraw: 2;
		maxNotesRange: 10;
		tempo: 63;
		info: 'test info';
		yourself
]

{ #category : #tests }
SOExerciceShelfTest >> testDelete [
	self assert: anExercicesShelf size equals: 0.
	anExercicesShelf save: exercice1.
	anExercicesShelf save: exercice2.
	anExercicesShelf save: exercice3.
	self assert: anExercicesShelf size equals: 3.
	anExercicesShelf delete: 3.
	self assert: anExercicesShelf size equals: 2.
	self assert: (anExercicesShelf pickAnExercice: 1) tempo equals: 61.
	self assert: (anExercicesShelf pickAnExercice: 2) tempo equals: 62
]

{ #category : #tests }
SOExerciceShelfTest >> testPickAnExercice [
	| exerciceTest |
	self assert: anExercicesShelf size equals: 0.
	anExercicesShelf save: exercice1.
	anExercicesShelf save: exercice2.
	anExercicesShelf save: exercice3.
	self assert: anExercicesShelf size equals: 3.
	exerciceTest := anExercicesShelf pickAnExercice: 3.
	self assert: exerciceTest identicalTo: exercice3. 
]

{ #category : #tests }
SOExerciceShelfTest >> testSave [ 

self assert: anExercicesShelf size equals: 0.

anExercicesShelf save: exercice1 .
self assert: anExercicesShelf size equals: 1.

]
