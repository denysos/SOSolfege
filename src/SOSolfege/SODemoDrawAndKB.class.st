Class {
	#name : #SODemoDrawAndKB,
	#superclass : #Object,
	#instVars : [
		'keyboard',
		'generator',
		'delayBeforeKBNote',
		'delayBeforeGenNote'
	],
	#category : #'SOSolfege-commands'
}

{ #category : #initialization }
SODemoDrawAndKB >> initialize [
	super initialize.
	delayBeforeKBNote := Delay forSeconds: 1.
	delayBeforeGenNote := Delay forSeconds: 1.
	
	"	delayBeforeKBNote := 1."
	generator := SOSingleDrawToScore
		newWithExerciceShelf: SOExerciceShelf exerciceShelfExemple1.
	keyboard := SOKeyBoardSimulator
		newWithExerciceShelf: SOExerciceShelf exerciceShelfExemple1.
	keyboard collector: generator collector.
	keyboard renderer: generator renderer
]

{ #category : #'as yet unclassified' }
SODemoDrawAndKB >> runExercice10Times: anExercice [
	"fork pour eviter de bloquer l'UI pendant les wait !!!"

	[ 10 timesRepeat: [ self runExercice: anExercice ] ] fork
]

{ #category : #'as yet unclassified' }
SODemoDrawAndKB >> runExercice: anExercice [
	| aNoteSet aNoteSetFromKB |
	"generator: "
	 "delayBeforeGenNote wait."
	aNoteSet := generator generateNoteSetFrom: anExercice.
	generator sendToCollector: aNoteSet.
	generator rendering.

	"to prevent Delay to hold the process and then Display everything at the same time :"
	WorldMorph doOneCycle.	"Display world changes before delay !"
	delayBeforeGenNote wait.

	"keyboard :"
	"delayBeforeKBNote wait."
	aNoteSetFromKB := keyboard generateNoteSetFrom: anExercice.
	keyboard sendToCollector: aNoteSetFromKB.
	keyboard rendering.

	" display keyboard now ! "
	WorldMorph doOneCycle.	"Display world changes before delay !"
	delayBeforeKBNote wait 
]
