"
Store the notes of a Chord

A Dictionary to store a generated chord.

Chords are generated y the generator, and the go thru DisplayCollector and DisplayRenderer





Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 



    Instance Variables
	chord:		<Object>


    Implementation Points
"
Class {
	#name : #SOChord,
	#superclass : #Object,
	#instVars : [
		'chord'
	],
	#category : #'SOSolfege-deprecated'
}

{ #category : #testing }
SOChord class >> isDeprecated [
	^ true
]

{ #category : #adding }
SOChord >> addANote: anInteger [
	chord at: anInteger put: (SONotes nameWithRank: anInteger)
]

{ #category : #initialization }
SOChord >> initialize [
	"a Dictionary is used to store notes
key : rank of the notes in allNOtesOnScore
value : name of the note in allNotesOnScore
a Dictionary to make sure that there is no duplicate notes in a chord"

	super initialize.
	chord := Dictionary new
]
