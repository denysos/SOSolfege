"
holds all information to order and to generate a morph later
"
Class {
	#name : #SONoteData,
	#superclass : #Object,
	#instVars : [
		'name',
		'rank',
		'origin'
	],
	#classVars : [
		'FullNotesCollection',
		'MaxRank'
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
	MaxRank := FullNotesCollection size
]

{ #category : #'as yet unclassified' }
SONoteData class >> withRank: aRank [
	^ self new rank: aRank
]

{ #category : #comparing }
SONoteData >> < aNoteData [
	^ self rank < aNoteData rank
]

{ #category : #testing }
SONoteData >> isNextTo: aNoteData [
	^ (self rank - aNoteData rank) abs = 1
]

{ #category : #'accessing colors' }
SONoteData >> matchColor [
	^ Color blue 
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
