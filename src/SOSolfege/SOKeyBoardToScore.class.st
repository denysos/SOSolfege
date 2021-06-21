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
	#category : #'SOSolfege-commands'
}

{ #category : #initialization }
SOKeyBoardToScore >> initialize [
	super initialize.
	portNumber := SimpleMIDIPort inputPortNumFromUser.	"integer"
	port := SimpleMIDIPort openOnPortNumber: portNumber.
	receptMIDI := MIDIInputParserTestForSOS on: port.
	midiNoteSetConverter := SOMidiNoteSetConverter new
]

{ #category : #'as yet unclassified' }
SOKeyBoardToScore >> runExercice: anExercice [
	"no exercice needed ! call with anExercice := nil"

	| scanDelay aNoteSet renderingDelay |
	scanDelay := receptMIDI scanDelay.
	renderingDelay := Delay forMilliseconds: 50.
	receptMIDI monitorMidiDataCollector.
	KBRendererProcess := [ [ true ]
		whileTrue: [ renderingDelay wait.
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
	receptMIDI stopReception.
	KBRendererProcess terminate.
"	port close"
]
