"
this Class save all exercices param as SOExercice
"
Class {
	#name : #SOExerciceShelf,
	#superclass : #Object,
	#instVars : [
		'exercices'
	],
	#category : #'SOSolfege-core'
}

{ #category : #'as yet unclassified' }
SOExerciceShelf class >> exerciceShelfExemple1 [
	| exercice1 exercice2 exercice3 anExercicesShelf |
	exercice1 := SOExercice new.
	anExercicesShelf := self new.
	"utilisation de l'exercice par defaut"
	anExercicesShelf save: exercice1.
	exercice2 := SOExercice new
		info: 'info exercice2';
		notesNumberInADraw: 2;
		tempo: 50;
		yourself.
	anExercicesShelf save: exercice2.
	exercice3 := SOExercice new
		info: 'info exercice3';
		notesNumberInADraw: 3;
		tempo: 40;
		noteSet: SONoteSet newGKeyNoteSet;
		yourself.
	anExercicesShelf save: exercice3.
	^ anExercicesShelf
]

{ #category : #'as yet unclassified' }
SOExerciceShelf >> delete: anInteger [
	exercices removeAt: anInteger
]

{ #category : #initialization }
SOExerciceShelf >> initialize [
	super initialize.
	exercices := OrderedCollection new
]

{ #category : #'as yet unclassified' }
SOExerciceShelf >> pickAnExercice: anInteger [
	^ exercices at: anInteger
]

{ #category : #printing }
SOExerciceShelf >> printOn: aStream [
	exercices do: [ :each | aStream print: each ]
]

{ #category : #'element access' }
SOExerciceShelf >> save: aSOExercice [ 
	exercices add: aSOExercice 
]

{ #category : #accessing }
SOExerciceShelf >> size [
	^ exercices size
]
