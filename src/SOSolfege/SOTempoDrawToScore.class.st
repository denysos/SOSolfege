Class {
	#name : #SOTempoDrawToScore,
	#superclass : #SOSingleDrawToScore,
	#instVars : [
		'exerciceProcess'
	],
	#category : #'SOSolfege-commands'
}

{ #category : #'as yet unclassified' }
SOTempoDrawToScore >> launchProcessExercice: anExercice stepDelay: tempoPeriodDelay [
	exerciceProcess := [ [ super runExercice: anExercice.
	tempoPeriodDelay wait ] whileTrue: [ true ] ] fork
]

{ #category : #'as yet unclassified' }
SOTempoDrawToScore >> runExercice: anExercice [
	| tempo tempoPeriod tempoPeriodDelay |
	tempo := anExercice tempo.
	tempoPeriod := 60 / tempo.
	tempoPeriodDelay := Delay forSeconds: tempoPeriod.
	exerciceProcess := [ [ true ]
		whileTrue: [ super runExercice: anExercice.
			tempoPeriodDelay wait ] ] fork
]

{ #category : #accessing }
SOTempoDrawToScore >> stop [
	"stop the running exercice"

	exerciceProcess terminate
]
