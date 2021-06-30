Class {
	#name : #SOKeyBoardToScore,
	#superclass : #SOKeyBoardSimulator,
	#instVars : [
		'portNumber',
		'port',
		'receptMIDI',
		'midiKBNotes',
		'midiNoteSetConverter',
		'KBRendererProcess'
	],
	#classVars : [
		'DisplayKB'
	],
	#category : #'SOSolfege-commands'
}

{ #category : #'as yet unclassified' }
SOKeyBoardToScore class >> runKeyboardToScore [
	"run the use case :
	- hit keys on the keyboard
	- the notes are displayed on the score"

	<script>
	DisplayKB := SOKeyBoardToScore new.
	DisplayKB runExercice: nil
]

{ #category : #'as yet unclassified' }
SOKeyBoardToScore class >> stopKeyboardToScore [
	<script>
	DisplayKB stop
]

{ #category : #initialization }
SOKeyBoardToScore >> initialize [
	super initialize.
	portNumber := SimpleMIDIPort inputPortNumFromUser.	"integer"
	port := SimpleMIDIPort openOnPortNumber: portNumber.
	receptMIDI := MIDIInputParserForSOSolfege on: port.
	midiNoteSetConverter := SOMidiNoteSetConverter new
]

{ #category : #'as yet unclassified' }
SOKeyBoardToScore >> runExercice: anExercice [
	"no exercice needed ! call with anExercice := nil"

	| aNoteSet renderingDelay |
	renderingDelay := Delay forMilliseconds: 100.
	"	receptMIDI monitorMidiDataCollector."
		receptMIDI clearBuffers.
	KBRendererProcess := [ [ true ]
		whileTrue: [ renderingDelay wait.
			receptMIDI getMidiKBNotesCodes.
			midiKBNotes := receptMIDI midiDataCollector.
			midiKBNotes isEmpty
				ifFalse: [ aNoteSet := midiNoteSetConverter fromMidiToNoteSet: midiKBNotes.
					self sendToCollector: aNoteSet.
					self rendering.
					receptMIDI resetMidiDataCollector ] ] ]
		forkNamed: 'SOSolfege:KB Rendering '
]

{ #category : #accessing }
SOKeyBoardToScore >> stop [
	| delayBeforeClosePort |
	delayBeforeClosePort := Delay forSeconds: 1.
	KBRendererProcess terminate.
	delayBeforeClosePort wait.
	port close
]
