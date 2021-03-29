"
Store a collection of notes
can be used to store notes as parameters or for any other purpose, ...
used to store a chord, but not limited to chords

A Dictionary is used to store the note collection.
- notes are represented by their rank in the collection of all possible notes on the score
  (see class side) 
- to prevent duplicates
- to keep it ordered

Chords are generated y the generator, and then go thru DisplayCollector and DisplayRenderer





Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	noteChoice:		<Object>


    Implementation Points
"
Class {
	#name : #SONoteSet,
	#superclass : #Object,
	#instVars : [
		'noteChoice'
	],
	#classVars : [
		'FullNotesCollection',
		'MaxRank'
	],
	#category : #'SOSolfege-core'
}

{ #category : #parameters }
SONoteSet class >> allNotesOnScore [
	"to be moved in a param class ?"

	^ {'c1' . 'd1' . 'e1' . 'f1' . 'g1' . 'a1' . 'b1' . 'c2' . 'd2' . 'e2'.
	'f2' . 'g2' . 'a2' . 'b2' . 'c3' . 'd3' . 'e3' . 'f3' . 'g3' . 'a3'.
	'b3' . 'c4' . 'd4' . 'e4' . 'f4' . 'g4' . 'a4' . 'b4' . 'c5'}
		asOrderedCollection
]

{ #category : #'class initialization' }
SONoteSet class >> initialize [
	FullNotesCollection := self allNotesOnScore.
	MaxRank := FullNotesCollection size
]

{ #category : #'instance creation' }
SONoteSet class >> newFullNoteSet [
	| aNoteSet |
	aNoteSet := self new.
	1 to: MaxRank do: [ :i | aNoteSet addANote: i ].
	^ aNoteSet
]

{ #category : #'instance creation' }
SONoteSet class >> newGKeyNoteSet [
	| aNoteSet |
	aNoteSet := self new.
	15 to: 29 do: [ :i | aNoteSet addANote: i ].
	^ aNoteSet
]

{ #category : #adding }
SONoteSet >> addANote: anInteger [
	noteChoice at: anInteger put: (FullNotesCollection at: anInteger)
]

{ #category : #initialization }
SONoteSet >> initialize [
	"a Dictionary is used to store notes
key : rank of the notes in FullNotesCollection
value : name of the note in FullNotesCollection
a Dictionary to make sure that there is no duplicate notes"

	super initialize.
	noteChoice := Dictionary new
]

{ #category : #testing }
SONoteSet >> isEmpty [
	^ self size = 0
]

{ #category : #printing }
SONoteSet >> printOn: aStream [
	aStream print: noteChoice
]

{ #category : #enumerating }
SONoteSet >> ranksDo: aBlockClosure [
	noteChoice keysSortedSafely do: aBlockClosure
]

{ #category : #accessing }
SONoteSet >> size [
	^ noteChoice size
]

{ #category : #adding }
SONoteSet >> subsetAtRandomWith: anInteger [
	"pick some (anInteger) notes from the NoteSet and create a new NoteSet "

	| aNoteSet ranks |
	aNoteSet := self class new.
	ranks := noteChoice keys.
	anInteger timesRepeat: [ aNoteSet addANote: ranks atRandom ].
	^ aNoteSet
]
