Class {
	#name : #SODemoDrawAndKB,
	#superclass : #SOSingleDrawToScore,
	#instVars : [
		'keyboard'
	],
	#category : #'SOSolfege-app'
}

{ #category : #initialization }
SODemoDrawAndKB >> initialize [
	super initialize.
	keyboard := SOKeyBoardSimulator new
]

{ #category : #'as yet unclassified' }
SODemoDrawAndKB >> runExercice: anExercice [
	| aNoteSet aNoteSetFromKB |
	aNoteSet := super generateNoteSetFrom: anExercice.
	super sendToCollector: aNoteSet.
	super rendering.
	(Delay forSeconds: 2) wait.
	aNoteSetFromKB := self generateNoteSetFrom: anExercice.
	self sendToCollector: aNoteSetFromKB.
	self rendering
]

{ #category : #'helper methods' }
SODemoDrawAndKB >> sendToCollector: aNoteSet [
	collector addNewTry: aNoteSet
]
