Class {
	#name : #SOSingleDrawToTranscript,
	#superclass : #SOManager,
	#category : #'SOSolfege-app'
}

{ #category : #'helper methods' }
SOSingleDrawToTranscript >> rendering [
	renderer toTranscriptFromNoteSet: (collector getCollectedDrawAndTry) aDraw 
]
