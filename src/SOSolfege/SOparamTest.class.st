Class {
	#name : #SOparamTest,
	#superclass : #TestCase,
	#instVars : [
		'notesGenerator',
		'allNotesOnScore',
		'notesForScore'
	],
	#category : #'SOSolfege-tests'
}

{ #category : #running }
SOparamTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
notesGenerator := SONotesGenerator new .
allNotesOnScore := notesGenerator allNotesOnScore.
]

{ #category : #tests }
SOparamTest >> testDrawNotesFromNotesToLearn [

| generator notesToLearn |

generator := SONotesGenerator new .

"for this test, notes to learn are chosen from notes in allNotesOnScore with an even index"
notesToLearn := (generator allNotesOnScore)  withIndexSelect: [ :each :i | i even ].
generator notesToLearn: notesToLearn.

generator notesNumberToDraw: 1.
self assert: (generator drawNotesFromNotesToLearn) size equals: 1.

" drawn notes are in a set, and a note can be dawn more than ones ! so the size can be less than the number of notes to be drawn !"
generator notesNumberToDraw: 2.
self assert: (generator drawNotesFromNotesToLearn) size <= 2.

generator  notesNumberToDraw: 3.
self assert: (generator drawNotesFromNotesToLearn) size <= 3.
]

{ #category : #tests }
SOparamTest >> testNotesForScore [
	self assert: allNotesOnScore size equals: 29.
	self assert: (allNotesOnScore at: 1) equals: 'c1'.
	self assert: (allNotesOnScore at: 10) equals: 'e2'
]
