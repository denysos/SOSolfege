"
A SODisplayRendererTest is a test class for testing the behavior of SODisplayRenderer
"
Class {
	#name : #SODisplayRendererTest,
	#superclass : #TestCase,
	#category : #'SOSolfege-Tests-core'
}

{ #category : #test }
SODisplayRendererTest >> addGeneratorNotes: notesFromGenerator to: aNoteSet [
	notesFromGenerator
		do: [ :each | aNoteSet addANote: (SOGeneratorNote withRank: each) ]
]

{ #category : #test }
SODisplayRendererTest >> addKeyboardNotes: notesFromKeyboard to: aNoteSet [
	notesFromKeyboard
		do: [ :each | aNoteSet addANote: (SOKeyboardNote withRank: each) ]
]

{ #category : #test }
SODisplayRendererTest >> testAssessDisplayColors [
	"when 2 notes from different origin are at the same place on the score, their match, and the color of the note displayed is changed to green"

	| aNoteSet aNoteSetWithMatchedColor notesFromGenerator notesFromKeyboard aDisplayRenderer |
	notesFromGenerator := #(1 5 10) asOrderedCollection.
	notesFromKeyboard := #(5 6) asOrderedCollection.
	aNoteSet := SONoteSet new.
	self addGeneratorNotes: notesFromGenerator to: aNoteSet.
	self addKeyboardNotes: notesFromKeyboard to: aNoteSet.
	aNoteSetWithMatchedColor := aNoteSet copy.
	aDisplayRenderer := SODisplayRenderer new.
	aDisplayRenderer assessDisplayColors: aNoteSetWithMatchedColor.
	aNoteSetWithMatchedColor
		ranksDo: [ :each | 
			each rank = 1
				ifTrue: [ self assert: each color = Color black ].	"no match, generator default color = black"
			each rank = 5
				ifTrue: [ self assert: each color = Color green ].	"match, color = green"
			each rank = 6
				ifTrue: [ self assert: each color = Color red ].	"no match, keyboard default color = red"
			each rank = 10
				ifTrue:
					[ self assert: each color = Color black ] "no match, generator default color = black"  ]
]

{ #category : #tests }
SODisplayRendererTest >> testAssessPositionShift [

"if 2 notes are next to eachother, the position of second is shifted, even if their origin is different"
	| aNoteSet aNoteSetWithNotePositionShifted notesFromGenerator notesFromKeyboard aDisplayRenderer |
	notesFromGenerator := #(1 5 10) asOrderedCollection.
	notesFromKeyboard := #(5 6 11) asOrderedCollection.
	aNoteSet := SONoteSet new.
	self addGeneratorNotes: notesFromGenerator to: aNoteSet.
	self addKeyboardNotes: notesFromKeyboard to: aNoteSet.
	aNoteSetWithNotePositionShifted := aNoteSet copy.
	aDisplayRenderer := SODisplayRenderer new.
	aDisplayRenderer assessPositionShift: aNoteSetWithNotePositionShifted.
	aNoteSetWithNotePositionShifted
		ranksDo: [ :each | 
			each rank = 1
				ifTrue: [ self deny: each positionShift ].	"first note, next to nothing ! "
			each rank = 5
				ifTrue: [ self deny: each positionShift ].	"5 not next to 1, no position shift"
			each rank = 6
				ifTrue: [ self assert: each positionShift ].	"6 next to 5, position Shifted"
			each rank = 10
				ifTrue: [ self deny: each positionShift ].	"10 not next to 6, no position shift"
			each rank = 11
				ifTrue: [ self assert: each positionShift ]	"11 next to 10, even if origin different" ]
]
