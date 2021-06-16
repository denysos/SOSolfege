Class {
	#name : #SOMidiNoteSetConverter,
	#superclass : #Object,
	#instVars : [
		'midiToNoteSetTable'
	],
	#category : #'SOSolfege-core'
}

{ #category : #'instance creation' }
SOMidiNoteSetConverter >> fromMidiToNoteSet: aMidiCodeCollection [
	| aNoteSet aRank |
	aNoteSet := SONoteSet new.
	aMidiCodeCollection
		do: [ :aMidiKeyCode | 
			aRank := midiToNoteSetTable at: aMidiKeyCode.
			aNoteSet addANoteWithRank: aRank ].
	^ aNoteSet
	"ifAbsent: [ continue value ]"
]

{ #category : #initialization }
SOMidiNoteSetConverter >> initialize [
	"midiToNoteSetTable connects midi code of keyboards keys to the sequence of notes on the score, beginning with the bass C1.
decimal sequence numbers represent black keys which can be represented on the score by a '#' (sharp)  or a 'b' (flat) note "

	midiToNoteSetTable := {(36 -> 1).
	(37 -> 1.5).
	(38 -> 2).
	(39 -> 2.5).
	(40 -> 3).
	(41 -> 4).
	(42 -> 4.5).
	(43 -> 5).
	(44 -> 5.5).
	(45 -> 6).
	(46 -> 6.5).
	(47 -> 7).
	(48 -> 8).
	(49 -> 8.5).
	(50 -> 9).
	(51 -> 9.5).
	(52 -> 10).
	(53 -> 11).
	(54 -> 11.5).
	(55 -> 12).
	(56 -> 12.5).
	(57 -> 13).
	(58 -> 13.5).
	(59 -> 14).
	(60 -> 15).
	(61 -> 15.5).
	(62 -> 16).
	(63 -> 16.5).
	(64 -> 17).
	(65 -> 18).
	(66 -> 18.5).
	(67 -> 19).
	(68 -> 19.5).
	(69 -> 20).
	(70 -> 20.5).
	(71 -> 21).
	(72 -> 22).
	(73 -> 22.5).
	(74 -> 23).
	(75 -> 23.5).
	(76 -> 24).
	(77 -> 25).
	(78 -> 25.5).
	(79 -> 26).
	(80 -> 26.5).
	(81 -> 27).
	(82 -> 27.5).
	(83 -> 28).
	(84 -> 29)} asDictionary
]
