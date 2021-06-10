"
A NoteDataTest is a test class for testing the behavior of NoteData
"
Class {
	#name : #SONoteDataTest,
	#superclass : #TestCase,
	#category : #'SOSolfege-Tests-core'
}

{ #category : #tests }
SONoteDataTest >> testAsGeneratorNote [
	| nBefore nAfter |
	nBefore := SONoteData fromRank: 1.
	nAfter := nBefore asGeneratorNote.
	self assert: nAfter class equals: SOGeneratorNote.
	self assert: nAfter rank equals: nBefore rank.
	self assert: nAfter name equals: nBefore name.
	self assert: nAfter origin equals: #generator
]

{ #category : #tests }
SONoteDataTest >> testAsKeyboardNote [
	| nBefore nAfter |
	nBefore := SONoteData fromRank: 1.
	nAfter := nBefore asKeyboardNote.
	self assert: nAfter class equals: SOKeyboardNote.
	self assert: nAfter rank equals: nBefore rank.
	self assert: nAfter name equals: nBefore name.
	self assert: nAfter origin equals: #keyboard
]

{ #category : #tests }
SONoteDataTest >> testIsNextTo [
	| aNoteData1 aNoteData2 aNoteData10 |
	aNoteData1 := SONoteData fromRank: 1.
	aNoteData2 := SONoteData fromRank: 2.
	aNoteData10 := SONoteData fromRank: 10.
	self assert: (aNoteData1 isNextTo: aNoteData2).
	self deny: (aNoteData1 isNextTo: aNoteData10)
]

{ #category : #test }
SONoteDataTest >> testLessThan [
	| noteData1 noteData2 |
	noteData1 := SONoteData fromRank: 1.
	noteData2 := SONoteData fromRank: 2.
	self assert: noteData1 < noteData2
]

{ #category : #test }
SONoteDataTest >> testMatch [
	| noteFromGenerator noteFromKeyboard |
	noteFromGenerator := SOGeneratorNote fromRank: 1.
	noteFromKeyboard := SOKeyboardNote fromRank: 1.
	self assert: (noteFromGenerator match: noteFromKeyboard)
]
