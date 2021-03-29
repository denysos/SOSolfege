"
group of parameters to run an exercice
- tempo
- number of notes being drawn at the same time 
- a NoteSet : all the notes to be used for the exercice



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
	notesNumber:		<Object>
	notesSet:		<Object>
	tempo:		<Object>


    Implementation Points
"
Class {
	#name : #SOExercice,
	#superclass : #Object,
	#instVars : [
		'tempo',
		'noteSet',
		'info',
		'notesNumberInADraw',
		'maxNotesRange'
	],
	#category : #'SOSolfege-core'
}

{ #category : #accessing }
SOExercice >> info [
	^ info
]

{ #category : #accessing }
SOExercice >> info: aString [
	info := aString
]

{ #category : #initialization }
SOExercice >> initialize [
	super initialize.
	tempo := 60.
	notesNumberInADraw := 1.
	noteSet := SONoteSet newFullNoteSet.
	maxNotesRange := 10.
	info := 'où en êtes vous avec cet exercice ?'
]

{ #category : #accessing }
SOExercice >> maxNotesRange [
	^ maxNotesRange
]

{ #category : #accessing }
SOExercice >> maxNotesRange: anInteger [
	maxNotesRange := anInteger
]

{ #category : #accessing }
SOExercice >> noteSet [
	^ noteSet
]

{ #category : #accessing }
SOExercice >> noteSet: aNoteSet [
	noteSet := aNoteSet
]

{ #category : #accessing }
SOExercice >> notesNumberInADraw [
	^ notesNumberInADraw
]

{ #category : #accessing }
SOExercice >> notesNumberInADraw: anInteger [
	notesNumberInADraw := anInteger
]

{ #category : #printing }
SOExercice >> printOn: aStream [
	aStream
		nextPutAll: self info;
		cr;
		nextPutAll: 'tempo: ';
		print: self tempo;
		space;
		nextPutAll: 'notesNumberInADraw: ';
		print: self notesNumberInADraw;
		cr;
		nextPutAll: 'noteSet: ';
		print: self noteSet;
		cr;
		cr
]

{ #category : #'as yet unclassified' }
SOExercice >> selectMeAsNew [
	^ self deepCopy 
]

{ #category : #accessing }
SOExercice >> tempo [
	^ tempo
]

{ #category : #accessing }
SOExercice >> tempo: anInteger [
	tempo := anInteger
]
