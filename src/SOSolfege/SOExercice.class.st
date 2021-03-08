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
		'notesNumber',
		'noteSet',
		'info'
	],
	#category : #'SOSolfege-core'
}

{ #category : #initialization }
SOExercice >> initialize [
	super initialize.
	tempo := 60.
	notesNumber := 1.
	noteSet := SONoteSet newFullNoteSet.
	info := 'où en êtes vous avec cet exercice ?'
]

{ #category : #accessing }
SOExercice >> noteSet [
	^ noteSet
]

{ #category : #accessing }
SOExercice >> noteSet: anObject [
	noteSet := anObject
]

{ #category : #accessing }
SOExercice >> notesNumber [
	^ notesNumber
]

{ #category : #accessing }
SOExercice >> notesNumber: anObject [
	notesNumber := anObject
]

{ #category : #'as yet unclassified' }
SOExercice >> selectMeAsNew [
	^ self copy
]

{ #category : #accessing }
SOExercice >> tempo [
	^ tempo
]

{ #category : #accessing }
SOExercice >> tempo: anObject [
	tempo := anObject
]
