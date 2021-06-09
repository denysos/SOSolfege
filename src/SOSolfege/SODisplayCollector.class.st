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
		'displayHistory',
		'isUpdated'
	],
	#category : #'SOSolfege-core'
}

{ #category : #adding }
SODisplayCollector >> addNewDraw: aNoteSet [
	| aNewNoteSet |
	self resetDisplay.
	aNewNoteSet := aNoteSet setOriginTo: #asGeneratorNote.
	toDisplay aDraw: aNewNoteSet.
	self sendUpdatedFlag
]

{ #category : #adding }
SODisplayCollector >> addNewTry: aNoteSet [
	| aNewNoteSet |
	aNewNoteSet := aNoteSet setOriginTo: #asKeyboardNote.
	toDisplay aTry: aNewNoteSet.
	self sendUpdatedFlag
]

{ #category : #accessing }
SODisplayCollector >> getCollectedDrawAndTry [
	^ toDisplay
]

{ #category : #initialization }
SODisplayCollector >> initialize [
	super initialize.
	toDisplay := SOCollectedDrawAndTry new.
	displayHistory := OrderedCollection new
]

{ #category : #testing }
SODisplayCollector >> isADrawEmpty [
	^ toDisplay aDraw isEmpty
]

{ #category : #testing }
SODisplayCollector >> isATryEmpty [
	^ toDisplay aTry isEmpty
]

{ #category : #testing }
SODisplayCollector >> isDisplayHistoryEmpty [
	^ displayHistory isEmpty
]

{ #category : #testing }
SODisplayCollector >> isEmpty [
	^ (self isADrawEmpty) and: [self isATryEmpty]
]

{ #category : #history }
SODisplayCollector >> moveDisplayToHistory [
	displayHistory add: toDisplay
]

{ #category : #history }
SODisplayCollector >> resetDisplay [
	self moveDisplayToHistory.
	toDisplay := SOCollectedDrawAndTry new
	
]

{ #category : #'as yet unclassified' }
SODisplayCollector >> sendUpdatedFlag [
	^ true
]
