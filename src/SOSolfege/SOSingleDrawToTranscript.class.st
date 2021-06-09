Class {
	#name : #SOSingleDrawToTranscript,
	#superclass : #SOManager,
	#category : #'SOSolfege-commands'
}

{ #category : #'helper methods' }
SOSingleDrawToTranscript >> rendering [
	renderer toTranscriptFromNoteSet: (collector getCollectedDrawAndTry) aDraw 
]
