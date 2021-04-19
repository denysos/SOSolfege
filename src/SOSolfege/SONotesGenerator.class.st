"
purpose : Draw notes from the list of notes selected to learn

  | responsibilities                                     | collaboration               |
  |------------------------------------------------------+-----------------------------|
  | select notes at random in the list of notes to learn | SOParam, SODisplayCollector |
  |                                                      |                             |

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #SONotesGenerator,
	#superclass : #Object,
	#instVars : [
		'notesToLearn',
		'notesNumberToDraw'
	],
	#category : #'SOSolfege-core'
}

{ #category : #deprecated }
SONotesGenerator >> allNotesOnScore [
"to be moved in a param class"
^ { 'c1' . 'd1' . 'e1' . 'f1' . 'g1' . 'a1' . 'b1' . 
'c2' . 'd2' . 'e2' . 'f2' . 'g2' . 'a2' . 'b2' .  
'c3' . 'd3' . 'e3' . 'f3' . 'g3' . 'a3' . 'b3' .
'c4' . 'd4' . 'e4' . 'f4' . 'g4' . 'a4' . 'b4' .
'c5' } asOrderedCollection 
]

{ #category : #action }
SONotesGenerator >> drawNotesFromNotesToLearn [
	"draw notes from notesToLearn at random, the same note may be draw more than ones
	but there will be only one of each in the Chord (see SOChord)
"

	| chord |
	chord := SOChord new.
	notesNumberToDraw
		timesRepeat: [ chord addANoteWithRank: notesToLearn atRandom ].
	^ chord
]

{ #category : #initialization }
SONotesGenerator >> initialize [
	super initialize.
	notesToLearn := SONotes allNotesOnScore.
	notesNumberToDraw := 1
]

{ #category : #accessing }
SONotesGenerator >> notesNumberToDraw [
	^ notesNumberToDraw
]

{ #category : #accessing }
SONotesGenerator >> notesNumberToDraw: anInteger [
	notesNumberToDraw := anInteger
]

{ #category : #accessing }
SONotesGenerator >> notesToLearn [
	^ notesToLearn
]

{ #category : #accessing }
SONotesGenerator >> notesToLearn: anObject [
	notesToLearn := anObject
]

{ #category : #'as yet unclassified' }
SONotesGenerator >> singleDrawFrom: anExercice [
	^ anExercice noteSet
		subsetAtRandomWith: anExercice notesNumberInADraw
]
