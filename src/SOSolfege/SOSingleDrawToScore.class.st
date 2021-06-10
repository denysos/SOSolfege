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
	renderer renderScoreInWorldFrom: collector
]
