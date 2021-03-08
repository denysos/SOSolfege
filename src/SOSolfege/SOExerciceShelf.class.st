Class {
	#name : #SOExerciceShelf,
	#superclass : #Object,
	#instVars : [
		'exercices'
	],
	#category : #'SOSolfege-core'
}

{ #category : #initialization }
SOExerciceShelf >> initialize [
	super initialize.
	exercices := OrderedCollection new
]
