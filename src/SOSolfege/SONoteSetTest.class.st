Class {
	#name : #SONoteSetTest,
	#superclass : #TestCase,
	#category : #'SOSolfege-tests'
}

{ #category : #tests }
SONoteSetTest >> testAddANote [
	| rank1 rank2 rank3 aNoteSet |
	rank1 := 1.
	rank2 := 10.
	rank3 := 15.
	aNoteSet := SONoteSet new
		addANote: rank1;
		addANote: rank2;
		addANote: rank3.
	self assert: aNoteSet size equals: 3
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
	unsortedRanks do: [ :each | aNoteSet addANote: each ].
	outputRanks := OrderedCollection new.
	aNoteSet ranksDo: [ :each | outputRanks add: each ].
	self
		assert: outputRanks
		equals: unsortedRanks asSortedCollection asOrderedCollection
]
