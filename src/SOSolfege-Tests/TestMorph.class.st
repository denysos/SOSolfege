Class {
	#name : #TestMorph,
	#superclass : #Morph,
	#category : #'SOSolfege-tests'
}

{ #category : #drawing }
TestMorph >> drawOn: aCanvas [
	| colors |
	colors := color wheel: 6.
	colors
		withIndexDo: [ :c :i | aCanvas fillOval: (self bounds insetBy: 4 * i) color: c ]
]
