Class {
	#name : #SOSingleDrawToScore,
	#superclass : #SOSingleDrawToTranscript,
	#category : #'SOSolfege-commands'
}

{ #category : #accessing }
SOSingleDrawToScore >> collector [
	^ collector
]

{ #category : #accessing }
SOSingleDrawToScore >> renderer [
	^ renderer
]

{ #category : #rendering }
SOSingleDrawToScore >> rendering [
	"	Transcript
		show: 'coucou';
		cr.
	Morph new openInWorld"

	"	renderer renderScoreFrom: collector"

	renderer renderScoreInWorldFrom: collector
]
