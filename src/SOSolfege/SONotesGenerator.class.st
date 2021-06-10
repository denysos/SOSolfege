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
	#category : #'SOSolfege-core'
}

{ #category : #action }
SONotesGenerator >> drawNotesFromNotesToLearn [
	"draw notes from notesToLearn at random, the same note may be draw more than ones
	but there will be only one of each in the Chord (see SOChord)
"

	| chord |
	chord := SONoteSet new.
	notesNumberToDraw
		timesRepeat: [ chord addANoteWithRank: notesToLearn atRandom ].
	^ chord
]

{ #category : #initialization }
SONotesGenerator >> initialize [
	super initialize.
	notesToLearn := SONoteData allNotesOnScore.
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
