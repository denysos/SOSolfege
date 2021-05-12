Class {
	#name : #SONoteSetTest,
	#superclass : #TestCase,
	#category : #'SOSolfege-Tests-core'
}

{ #category : #tests }
SONoteSetTest >> testAddANoteWIthRank [
	| rank1 rank2 rank3 aNoteSet |
	rank1 := 1.
	rank2 := 10.
	rank3 := 15.
	aNoteSet := SONoteSet new
		addANoteWithRank: rank1;
		addANoteWithRank: rank2;
		addANoteWithRank: rank3.
	self assert: aNoteSet size equals: 3
]

{ #category : #tests }
SONoteSetTest >> testIsEmpty [
	| aNoteSet |
	aNoteSet := SONoteSet new.
	self assert: aNoteSet isEmpty.
	aNoteSet addANoteWithRank: 1.
	self assert: aNoteSet size equals: 1.
	self deny: aNoteSet isEmpty
]

{ #category : #tests }
SONoteSetTest >> testRemoveDuplicate [
	| ranksWithDup ranksNoDup aNoteSet aNoteSetRanks |
	ranksWithDup := #(1 3 3 5 7) asOrderedCollection.
	ranksNoDup := ranksWithDup copy removeDuplicates.
	aNoteSetRanks := OrderedCollection new.
	aNoteSet := SONoteSet new.
	ranksWithDup do: [ :each | aNoteSet addANoteWithRank: each ].
	aNoteSet ranksDo: [ :each | aNoteSetRanks add: each rank ].
	self deny: ranksNoDup equals: ranksWithDup.
	self assert: ranksNoDup equals: aNoteSetRanks
]

{ #category : #tests }
SONoteSetTest >> testSetOriginTo [
	| aNoteSet aNoteSetFromGenerator aNoteSetFromKeyboard |
	aNoteSet := SONoteSet new
		addANoteWithRank: 1;
		addANoteWithRank: 2;
		addANoteWithRank: 3;
		yourself.
	aNoteSetFromGenerator := aNoteSet setOriginTo: #asGeneratorNote.
	aNoteSetFromKeyboard := aNoteSet setOriginTo: #asKeyboardNote.
	aNoteSetFromGenerator
		ranksDo: [ :eachNote | self assert: eachNote class equals: SOGeneratorNote ].
	aNoteSetFromKeyboard
		ranksDo: [ :eachNote | self assert: eachNote class equals: SOKeyboardNote ]
]

{ #category : #tests }
SONoteSetTest >> testSubsetAtRandomWith [
	| noteSetInit noteSetCreated size |
	noteSetInit := SONoteSet newFullNoteSet.
	noteSetCreated := noteSetInit subsetAtRandomWith: 4.
	size := noteSetCreated size.
	self assert: (size <= 4 and: size >= 1).
	self assert: noteSetInit class identicalTo: noteSetCreated class
]

{ #category : #tests }
SONoteSetTest >> testranksDo [
	"test that the noteSet is enumerated ordered from lower to higher rank"

	| unsortedRanks aNoteSet outputRanks |
	unsortedRanks := #(1 15 10 3 11 5 7 29 19) asOrderedCollection.
	"rank added unordered in the noteSet"
	aNoteSet := SONoteSet new.
	unsortedRanks do: [ :each | aNoteSet addANoteWithRank: each ].
	outputRanks := OrderedCollection new.
	aNoteSet ranksDo: [ :each | outputRanks add: each rank ].
	self
		assert: outputRanks
		equals: unsortedRanks asSortedCollection asOrderedCollection
]
