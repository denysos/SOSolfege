Class {
	#name : #SOSingleDrawToScore,
	#superclass : #SOSingleDrawToTranscript,
	#category : #'SOSolfege-app'
}

{ #category : #rendering }
SOSingleDrawToScore >> rendering [
	"	Transcript
		show: 'coucou';
		cr.
	Morph new openInWorld"

	renderer renderScoreFrom: collector
]
