"
The 'Manager' organize all the process 
with the data in 'exercice', the 'generator' draw some notes, sends them to the 'collector'.
for testing purposes, it manage also the 'renderer'.

next, we'll try to make the renderer to be triggered by the collector being filled.

the manager can be used in different ways :
- choose an exercice
- draw a single noteSet 
- draw a noteSet when a key is pressed
- draw noteSets until stop, at a given tempo 

"
Class {
	#name : #SOManager,
	#superclass : #Object,
	#instVars : [
		'exercices',
		'exercice',
		'generator',
		'collector',
		'renderer'
	],
	#category : #'SOSolfege-app'
}

{ #category : #'instance creation' }
SOManager class >> newWithExerciceShelf: anExercicesShelf [
	| aManager |
	aManager := self new.
	^ aManager changeExerciceShelfFor: anExercicesShelf
]

{ #category : #'as yet unclassified' }
SOManager >> changeExerciceShelfFor: anExercicesShelf [
	exercices := anExercicesShelf
]

{ #category : #'helper methods' }
SOManager >> generateNoteSetFrom: anExercice [
	^ generator singleDrawFrom: anExercice
]

{ #category : #initialization }
SOManager >> initialize [
	super initialize.
	exercices := SOExerciceShelf new.
	generator := SONotesGenerator new.
	collector := SODisplayCollector new.
	renderer := SODisplayRenderer new
]

{ #category : #'helper methods' }
SOManager >> rendering [
	renderer toTranscriptFromNoteSet: (collector getCollectedDrawAndTry) aDraw 
]

{ #category : #'helper methods' }
SOManager >> sendToCollector: aNoteSet [
	collector addNewDraw: aNoteSet
]

{ #category : #'as yet unclassified' }
SOManager >> singleDrawFrom: anExercice [
	| aNoteSet |
	aNoteSet := self generateNoteSetFrom: anExercice.
	self sendToCollector: aNoteSet.
	self rendering
]
