Class {
	#name : #SODemoDrawAndKB,
	#superclass : #Object,
	#instVars : [
		'keyboard',
		'generator',
		'timeBeforeKBNote'
	],
	#category : #'SOSolfege-app'
}

{ #category : #initialization }
SODemoDrawAndKB >> initialize [
	super initialize.
	timeBeforeKBNote := 1.
	generator := SOSingleDrawToScore new.
	keyboard := SOKeyBoardSimulator new.
	keyboard collector: generator collector.
	keyboard renderer: generator renderer
]

{ #category : #'as yet unclassified' }
SODemoDrawAndKB >> runExercice: anExercice [
	| aNoteSet aNoteSetFromKB |
	aNoteSet := generator generateNoteSetFrom: anExercice.
	generator sendToCollector: aNoteSet.
	generator rendering.
	(Delay forSeconds: timeBeforeKBNote) wait.
	aNoteSetFromKB := keyboard generateNoteSetFrom: anExercice.
	keyboard sendToCollector: aNoteSetFromKB.
	keyboard rendering
]
