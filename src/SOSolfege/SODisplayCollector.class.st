"
Collect Chords from the Generator and the Keyboard.
Will be asked by the DisplayRenderer to create a graphic representation of the chords to be displayed.

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
	displayHistory:		<Object>
	toDisplay:		<Object>


    Implementation Points
"
Class {
	#name : #SODisplayCollector,
	#superclass : #Object,
	#instVars : [
		'toDisplay',
		'displayHistory'
	],
	#category : #'SOSolfege-core'
}

{ #category : #adding }
SODisplayCollector >> addChordNew: aChord [
	toDisplay := SOCollectedChordsAndGuess new addChordNew.
]

{ #category : #initialization }
SODisplayCollector >> initialize [
	toDisplay := SOCollectedChordsAndGuess new.
	displayHistory := OrderedCollection new
]
