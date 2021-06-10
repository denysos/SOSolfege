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
	#classVars : [
		'H',
		'L',
		'LineGap',
		'LineLength',
		'LinesModel',
		'NoteSize',
		'NotesModel',
		'ScoreMorph',
		'ScoreSlotsPosition',
		'SlotGap',
		'SupLineLength'
	],
	#category : #'SOSolfege-core'
}

{ #category : #'class initialization' }
SODisplayRenderer class >> computeSlotsPositionOn: aCollectionOfInteger [
	| scoreSlotsPosition |
	scoreSlotsPosition := OrderedCollection new.
	aCollectionOfInteger
		do: [ :eachSlot | 
			| position |
			position := eachSlot * SlotGap.
			scoreSlotsPosition add: ((L // 2) @ position) ].
	scoreSlotsPosition sort: [ :a :b | a > b ].
	^ scoreSlotsPosition
]

{ #category : #'class initialization' }
SODisplayRenderer class >> initialize [
	H := 210.
	L := 150.
	SlotGap := (H // 30) .
	LineGap := SlotGap * 2 .
	NoteSize := (LineGap * 1.5) rounded asInteger @ LineGap.
	LineLength := (L * 0.80) rounded asInteger.
	SupLineLength := (L * 0.20) rounded asInteger.
	ScoreMorph := Morph new
		extent: L @ H;
		color: Color white.
	NotesModel := Interval from: 1 to: 29 by: 1.
	ScoreSlotsPosition := self computeSlotsPositionOn: NotesModel.
"	NotesMorphDict := Dictionary new."
	LinesModel := #(5 7 9 11 13 17 19 21 23 25) asOrderedCollection.
"	SupLinesModel := #(1 3 15 27 29) asOrderedCollection."
"	SupLinesMorphDict := Dictionary new."
	self makeLinesMorphOn: ScoreMorph  .
"	self makeSupLinesMorph.
	self makeNotesMorph"
]

{ #category : #'class initialization' }
SODisplayRenderer class >> makeLinesMorphOn: aScoreMorph [
	LinesModel
		do: [ :aLineIndex | 
			| aNewLine linePosition |
			linePosition := ScoreSlotsPosition at: aLineIndex.
			aNewLine := LineMorph
				from: 0 @ 0
				to: LineLength @ 0
				color: Color black
				width: 1.
			"aNewLine center: (L // 2) @ linePosition."
			aNewLine center: linePosition.
			aScoreMorph addMorph: aNewLine ]
]

{ #category : #accessing }
SODisplayRenderer class >> scoreMorph [
	^ ScoreMorph
]

{ #category : #deprecated }
SODisplayRenderer class >> xmakeNotesMorph [
"creer un morph Ellipse aux bonnes dimensions et le positionner !!!"
	NotesModel
		do: [ :aNoteIndex | 
			| aNewNote notePosition |
			notePosition := aNoteIndex * SlotGap.
			aNewNote := EllipseMorph
				newBounds:
					((L * 0.45) rounded asInteger
						@ (notePosition - (SlotGap / 2)) rounded asInteger
						extent:
							(L * 0.55) rounded asInteger
								@ (notePosition + (SlotGap / 2)) rounded asInteger)
				color: Color black.
			ScoreMorph addMorph: aNewNote.
			NotesMorphDict at: aNoteIndex put: aNewNote ]
]

{ #category : #deprecated }
SODisplayRenderer class >> xmakeScoreMorph [

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

{ #category : #deprecated }
SODisplayRenderer class >> xmakeSupLinesMorph [
	SupLinesModel
		do: [ :aLineIndex | 
			| aNewLine linePosition |
			linePosition := aLineIndex * SlotGap.
			aNewLine := LineMorph
				from: (L * 0.4) rounded asInteger @ linePosition
				to: (L * 0.6) rounded asInteger @ linePosition
				color: Color black
				width: 1.
			ScoreMorph addMorph: aNewLine.
			SupLinesMorphDict at: aLineIndex put: aNewLine ]
]

{ #category : #adding }
SODisplayRenderer >> addNote: aNote on: aScoreMorph [
	| aNoteMorph |
	""
	aNoteMorph := EllipseMorph new
		position: 0 @ 0;
		extent: NoteSize;
		color: aNote color;
		setBalloonText: aNote name.
	""
	aScoreMorph addMorph: aNoteMorph.
	""
	aNoteMorph
		center:
			(aNote positionShift
				ifFalse: [ ScoreSlotsPosition at: aNote rank ]
				ifTrue: [ (ScoreSlotsPosition at: aNote rank) + (16 @ 0) ])
]

{ #category : #composition }
SODisplayRenderer >> assessDisplayColors: aNoteSet [
	aNoteSet applyRule: self ruleToSetNoteColor
]

{ #category : #composition }
SODisplayRenderer >> assessPositionShift: aNoteSet [
	aNoteSet applyRule: self ruleToShiftNotePosition
]

{ #category : #rendering }
SODisplayRenderer >> getNotesFromCollector: aCollector [
	| noteSetToRender |
	noteSetToRender := SONoteSet new.
	aCollector getCollectedDrawAndTry aTry
		notesDo: [ :eachNote | noteSetToRender addANote: eachNote ].
	aCollector getCollectedDrawAndTry aDraw
		notesDo: [ :eachNote | noteSetToRender addANote: eachNote ].
	^ noteSetToRender
]

{ #category : #initialization }
SODisplayRenderer >> initialize [
	scoreMorph := ScoreMorph copy
]

{ #category : #composition }
SODisplayRenderer >> makeLinesSuppMorphFor: aNoteData On: aScoreMorph [
	aNoteData suppLines
		do: [ :rank | 
			| aNewLine linePosition |
			linePosition := ScoreSlotsPosition at: rank.
			aNewLine := LineMorph
				from: 0 @ 0
				to: SupLineLength @ 0
				color: Color black
				width: 1.
			aNewLine center: linePosition.
			aScoreMorph addMorph: aNewLine ]
]

{ #category : #rendering }
SODisplayRenderer >> morphFromNoteSet: aNoteSet [
	| aScoreMorph |
	aScoreMorph := ScoreMorph copy.
	aNoteSet
		notesDo: [ :eachNote | 
			self makeLinesSuppMorphFor: eachNote On: aScoreMorph.
			self addNote: eachNote on: aScoreMorph ].
	^ aScoreMorph
]

{ #category : #rendering }
SODisplayRenderer >> renderScoreFrom: aCollector [
	| noteSetToRender aScoreMorph |
	noteSetToRender := self getNotesFromCollector: aCollector.
	self setNotesProperties: noteSetToRender.
	aScoreMorph := self morphFromNoteSet: noteSetToRender.
	^ aScoreMorph
]

{ #category : #rendering }
SODisplayRenderer >> renderScoreInWorldFrom: aCollector [
	scoreMorph delete.
	scoreMorph := self renderScoreFrom: aCollector.
	scoreMorph openInWorld
]

{ #category : #composition }
SODisplayRenderer >> ruleToSetNoteColor [
	^ [ :aNoteChoice | 
	aNoteChoice
		doAdjacentPairs: [ :prevNote :nextNote | 
			prevNote
				ifNotNil: [ (prevNote match: nextNote)
						ifTrue: [ nextNote color: nextNote matchColor.
							prevNote color: prevNote matchColor ] ] ] ]
]

{ #category : #composition }
SODisplayRenderer >> ruleToShiftNotePosition [
	"a note is shifted if :
- prevNote and nextNote have adjacent ranks
- prevNote and nextNote have same ranks (different origin because noDups)
   and prevNote is shifted already ! "

	^ [ :aNoteChoice | 
	aNoteChoice
		doAdjacentPairs: [ :prevNote :nextNote | 
			prevNote
				ifNotNil: [ (((prevNote isNextTo: nextNote) and: [ prevNote isNotShifted ])
						or: [ prevNote rank = nextNote rank and: [ prevNote isShifted ] ])
						ifTrue: [ nextNote shiftPosition ] ] ] ]
]

{ #category : #rendering }
SODisplayRenderer >> setNotesProperties: noteSetToRender [
	self assessDisplayColors: noteSetToRender.
	noteSetToRender removeDuplicates.
	self assessPositionShift: noteSetToRender
]

{ #category : #'basic tests' }
SODisplayRenderer >> toTranscriptFromNoteSet: aNoteSet [
	aNoteSet
		notesDo: [ :aNote | 
			Transcript
				show: aNote asString;
				space;
				"show: (SONoteData allNotesOnScore at: aRank);"
					cr ].
	Transcript cr
]
