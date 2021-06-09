Class {
	#name : #SOKeyBoardSimulator,
	#superclass : #SOSingleDrawToScore,
	#category : #'SOSolfege-commands'
}

{ #category : #accessing }
SOKeyBoardSimulator >> collector: anObject [
	collector := anObject
]

{ #category : #accessing }
SOKeyBoardSimulator >> renderer: anObject [
	renderer := anObject
]

{ #category : #'helper methods' }
SOKeyBoardSimulator >> sendToCollector: aNoteSet [
	collector addNewTry: aNoteSet
]
