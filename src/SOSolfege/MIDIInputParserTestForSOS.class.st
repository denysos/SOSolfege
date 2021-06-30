"
test for receiving MIDI Data
"
Class {
	#name : #MIDIInputParserTestForSOS,
	#superclass : #MIDIInputParser,
	#instVars : [
		'midiReceptionProcess',
		'scanDelay',
		'midiDataCollector'
	],
	#category : #'SOSolfege-core'
}

{ #category : #'midi monitor' }
MIDIInputParserTestForSOS >> getMidiKBNotesCodes [
	self
		midiDoEvents:
			[ :cmd :arg1 :arg2 | self sendMidiDataCollectorCmd: cmd with: arg1 with: arg2 ]
]

{ #category : #initialization }
MIDIInputParserTestForSOS >> initialize [
	super initialize.
	scanDelay := Delay forMilliseconds: 100.
	midiDataCollector := OrderedCollection new
]

{ #category : #accessing }
MIDIInputParserTestForSOS >> midiDataCollector [
	^ midiDataCollector
]

{ #category : #'as yet unclassified' }
MIDIInputParserTestForSOS >> midiDoEvents: midiActionBlock [
	| time cmd arg1 arg2 |
	"	self clearBuffers."
	self
		midiDo: [ :item | 
			time := item at: 1.
			cmd := item at: 2.
			arg1 := arg2 := nil.
			item size > 2
				ifTrue: [ arg1 := item at: 3.
					item size > 3
						ifTrue: [ arg2 := item at: 4 ] ].
			midiActionBlock value: cmd value: arg1 value: arg2 ]
]

{ #category : #'as yet unclassified' }
MIDIInputParserTestForSOS >> midiDoEvents: midiActionBlock every: aDelay [
	"to implement !!!!!"

	| time cmd arg1 arg2 |
	self clearBuffers.
	midiReceptionProcess := [ [ true ]
		whileTrue: [ aDelay wait.
			self
				midiDo: [ :item | 
					time := item at: 1.
					cmd := item at: 2.
					arg1 := arg2 := nil.
					item size > 2
						ifTrue: [ arg1 := item at: 3.
							item size > 3
								ifTrue: [ arg2 := item at: 4 ] ].
					midiActionBlock value: cmd value: arg1 value: arg2 ] ] ]
		forkNamed: 'SOSolfege:MIDIReception'
]

{ #category : #'midi monitor' }
MIDIInputParserTestForSOS >> monitor [
	self
		"midiDoEvents:    [ :cmd :arg1 :arg2 | self printCmd: cmd with: arg1 with: arg2 ] every: scanDelay "
		midiDoEvents:    [ :cmd :arg1 :arg2 | self sendToRenderCmd: cmd with: arg1 with: arg2 ] every: scanDelay 
]

{ #category : #'midi monitor' }
MIDIInputParserTestForSOS >> monitorMidiDataCollector [
	self
		midiDoEvents:
			[ :cmd :arg1 :arg2 | self sendMidiDataCollectorCmd: cmd with: arg1 with: arg2 ]
		every: scanDelay
	"midiDoEvents:    [ :cmd :arg1 :arg2 | self printCmd: cmd with: arg1 with: arg2 ] every: scanDelay "
]

{ #category : #initialization }
MIDIInputParserTestForSOS >> resetMidiDataCollector [
	midiDataCollector := OrderedCollection new
]

{ #category : #accessing }
MIDIInputParserTestForSOS >> scanDelay [
	^ scanDelay
]

{ #category : #'as yet unclassified' }
MIDIInputParserTestForSOS >> sendMidiDataCollectorCmd: cmdByte with: arg1 with: arg2 [
	| cmd ch bend |
		"	cmd = 144 ifTrue: [
		^ Transcript show: ('key down: ', arg1 printString, ' vel: ', arg2 printString, ' chan: ', ch printString); cr]."
	cmdByte < 240
		ifTrue: [ "channel message"
			cmd := cmdByte bitAnd: 2r11110000.
			ch := (cmdByte bitAnd: 2r00001111) + 1 ]
		ifFalse: [ cmd := cmdByte ].	"system message"
	(cmd = 144 and: [ arg2 > 0 ])
		ifTrue: [ midiDataCollector  add: arg1  ]
]

{ #category : #'as yet unclassified' }
MIDIInputParserTestForSOS >> sendToRenderCmd: cmdByte with: arg1 with: arg2 [
	| cmd ch bend |
	"	cmd = 144 ifTrue: [
		^ Transcript show: ('key down: ', arg1 printString, ' vel: ', arg2 printString, ' chan: ', ch printString); cr]."
	cmdByte < 240
		ifTrue: [ "channel message"
			cmd := cmdByte bitAnd: 2r11110000.
			ch := (cmdByte bitAnd: 2r00001111) + 1 ]
		ifFalse: [ cmd := cmdByte ].	"system message"
	(cmd = 144 and: [ arg2 > 0 ])
		ifTrue: [ ^ Transcript
				show:
					'key down: ' , arg1 printString , ' vel: ' , arg2 printString
						, ' chan: ' , ch printString;
				cr ]
]

{ #category : #'as yet unclassified' }
MIDIInputParserTestForSOS >> stopReception [
	midiReceptionProcess terminate
]
