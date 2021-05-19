"
holds all information to order and to generate a morph later
"
Class {
	#name : #SONoteData,
	#superclass : #Object,
	#instVars : [
		'name',
		'rank',
		'color',
		'positionShift'
	],
	#classVars : [
		'FullNotesCollection',
		'MaxRank',
		'SuppLinesSlotsForANote'
	],
	#category : #'SOSolfege-core'
}

{ #category : #parameters }
SONoteData class >> allNotesOnScore [
	"to be moved in a param class ?"

	^ {'c1' . 'd1' . 'e1' . 'f1' . 'g1' . 'a1' . 'b1' . 'c2' . 'd2' . 'e2'.
	'f2' . 'g2' . 'a2' . 'b2' . 'c3' . 'd3' . 'e3' . 'f3' . 'g3' . 'a3'.
	'b3' . 'c4' . 'd4' . 'e4' . 'f4' . 'g4' . 'a4' . 'b4' . 'c5'}
		asOrderedCollection
]

{ #category : #'class initialization' }
SONoteData class >> initialize [
	FullNotesCollection := self allNotesOnScore.
	MaxRank := FullNotesCollection size.
	SuppLinesSlotsForANote := {(1 -> #(1 3)).
	(3 -> #(3)).
	(15 -> #(15)).
	(27 -> #(27)).
	(29 -> #(27 29))} asDictionary
]

{ #category : #'as yet unclassified' }
SONoteData class >> withRank: aRank [
	^ self new rank: aRank
]

{ #category : #comparing }
SONoteData >> < aNoteData [
	^ self rank < aNoteData rank
]

{ #category : #comparing }
SONoteData >> = aNoteData [
	^ self rank = aNoteData rank and: [ self origin = aNoteData origin ]
]

{ #category : #converting }
SONoteData >> asGeneratorNote [
	^ (SOGeneratorNote newFrom: self) initialize
]

{ #category : #converting }
SONoteData >> asKeyboardNote [
	^ (SOKeyboardNote newFrom: self) initialize
]

{ #category : #accessing }
SONoteData >> color [
	^ color
]

{ #category : #accessing }
SONoteData >> color: anObject [
	color := anObject
]

{ #category : #initialization }
SONoteData >> defaultColor [
	^ Color black
]

{ #category : #comparing }
SONoteData >> hash [
	^ self rank hash bitXor: self origin hash
]

{ #category : #initialization }
SONoteData >> initialize [
	super initialize.
	color := self defaultColor.
	positionShift := false
]

{ #category : #testing }
SONoteData >> isNextTo: aNoteData [
	^ (self rank - aNoteData rank) abs = 1

	"^ (self rank - aNoteData rank) abs <= 1"
]

{ #category : #testing }
SONoteData >> isNotShifted [
	^ positionShift not
]

{ #category : #testing }
SONoteData >> isShifted [
	^ positionShift
]

{ #category : #accessing }
SONoteData >> match: aNoteData [
	^ self rank = aNoteData rank and: [ self origin ~= aNoteData origin ]
]

{ #category : #'accessing colors' }
SONoteData >> matchColor [
	^ Color green
]

{ #category : #accessing }
SONoteData >> name [
	^ name
]

{ #category : #accessing }
SONoteData >> origin [
	^ nil
]

{ #category : #accessing }
SONoteData >> positionShift [
	^ positionShift
]

{ #category : #accessing }
SONoteData >> rank [
	^ rank
]

{ #category : #accessing }
SONoteData >> rank: aRank [
	rank := aRank.
	name := FullNotesCollection at: aRank
]

{ #category : #'as yet unclassified' }
SONoteData >> shiftPosition [
	" the note is moved on the right on the score to make it easier to read !"

	positionShift := true
]

{ #category : #'as yet unclassified' }
SONoteData >> suppLines [
	^ SuppLinesSlotsForANote at: self rank ifAbsent: [ #() ]
]
