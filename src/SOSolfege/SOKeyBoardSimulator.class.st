Class {
	#name : #SOKeyBoardSimulator,
	#superclass : #SOSingleDrawToScore,
	#category : #'SOSolfege-app'
}

{ #category : #'helper methods' }
SOKeyBoardSimulator >> sendToCollector: aNoteSet [
	collector addNewTry: aNoteSet
]
