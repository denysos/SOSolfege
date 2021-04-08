"
This class take a NoteSet, may be collected in a CollectedDrawAndTry, and create a morph of the corresponding score

a score is a collection of 29 positions, on each position differents graphic elements can take place.
- a line
- a supplementary line 
- a note 

when the score is empty, only lines are presented 
"
Class {
	#name : #SODisplayRenderer,
	#superclass : #Object,
	#instVars : [
		'scoreMorph'
	],
	#classInstVars : [
		'NotesModel',
		'LinesModel',
		'SupLinesModel',
		'NotesMorphDict',
		'SupLinesMorphDict',
		'ScoreMorph',
		'H',
		'L',
		'LineGap',
		'LineLength',
		'SupLineLength'
	],
	#category : #'SOSolfege-core'
}

{ #category : #'class initialization' }
SODisplayRenderer class >> initialize [
	H := 200.
	L := 150.
	LineGap := (H / 20) rounded asInteger.
	LineLength := (L * 0.90) rounded asInteger.
	SupLineLength := (L * 0.10) rounded asInteger.
	ScoreMorph := Morph
		newBounds: (0 @ 0 extent: L @ H)
		color: Color white.
	NotesModel := Interval from: 1 to: 29 by: 1.
	NotesMorphDict := Dictionary new.
	LinesModel := #(5 7 9 11 13 17 19 21 23 25) asOrderedCollection.
	SupLinesModel := #(1 3 15 27 29) asOrderedCollection.
	SupLinesMorphDict := Dictionary new.
	self makeLinesMorph.
	self makeSupLinesMorph.
	self makeNotesMorph.
]

{ #category : #'as yet unclassified' }
SODisplayRenderer class >> makeLinesMorph [
"inverser l'ordre des lignes !
la ligne 1 est la ligne du bas !!!"
	LinesModel
		do: [ :aLineIndex | 
			| aNewLine linePosition |
			linePosition := aLineIndex * LineGap.
			aNewLine := LineMorph
				from: (L * 0.1) rounded asInteger @ linePosition
				to: (L * 0.9) rounded asInteger @ linePosition
				color: Color black
				width: 1.
			ScoreMorph addMorph: aNewLine ]
]

{ #category : #'as yet unclassified' }
SODisplayRenderer class >> makeNotesMorph [
"creer un morph Ellipse aux bonnes dimensions et le positionner !!!"
	NotesModel
		do: [ :aNoteIndex | 
			| aNewNote notePosition |
			notePosition := aNoteIndex * LineGap.
			aNewNote := EllipseMorph
				newBounds:
					((L * 0.45) rounded asInteger
						@ (notePosition - (LineGap / 2)) rounded asInteger
						extent:
							(L * 0.55) rounded asInteger
								@ (notePosition + (LineGap / 2)) rounded asInteger)
				color: Color black.
			ScoreMorph addMorph: aNewNote.
			NotesMorphDict at: aNoteIndex put: aNewNote ]
]

{ #category : #'as yet unclassified' }
SODisplayRenderer class >> makeScoreMorph [

	| h l largeurInterligne longueurLigne longueurLigneSup partition |
	h := 200.
	l := 150.
	largeurInterligne := (h / 20) rounded asInteger .
	longueurLigne := (l * 0.90) rounded asInteger.
	longueurLigneSup := (l * 0.10) rounded asInteger.
	
	partition := Morph
		newBounds: (0 @ 0 extent: l @ h)
		color: Color white.
]

{ #category : #'as yet unclassified' }
SODisplayRenderer class >> makeSupLinesMorph [
	SupLinesModel
		do: [ :aLineIndex | 
			| aNewLine linePosition |
			linePosition := aLineIndex * LineGap.
			aNewLine := LineMorph
				from: (L * 0.4) rounded asInteger @ linePosition
				to: (L * 0.6) rounded asInteger @ linePosition
				color: Color black
				width: 1.
			ScoreMorph addMorph: aNewLine.
			SupLinesMorphDict at: aLineIndex put: aNewLine ]
]

{ #category : #'as yet unclassified' }
SODisplayRenderer >> morphFromNoteSet: aNoteSet [
	self shouldBeImplemented
]

{ #category : #rendering }
SODisplayRenderer >> renderScore [
	self shouldBeImplemented
]

{ #category : #'basic tests' }
SODisplayRenderer >> toTranscriptFromNoteSet: aNoteSet [
	aNoteSet
		ranksDo: [ :aRank | 
			Transcript
				show: aRank;
				space;
				show: (SONoteSet allNotesOnScore at: aRank);
				cr ].
	Transcript cr
]
