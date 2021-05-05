"
represent a note coming from the generator
"
Class {
	#name : #SOGeneratorNote,
	#superclass : #SONoteData,
	#category : #'SOSolfege-core'
}

{ #category : #accessing }
SOGeneratorNote >> origin [
	^ #generator
]
