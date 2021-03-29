"
This class take a NoteSet, may be collected in a CollectedDrawAndTry, and create a morph of the corresponding score
"
Class {
	#name : #SODisplayRenderer,
	#superclass : #Object,
	#instVars : [
		'scoreMorph'
	],
	#category : #'SOSolfege-core'
}

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
