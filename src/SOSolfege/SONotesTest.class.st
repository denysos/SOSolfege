Class {
	#name : #SONotesTest,
	#superclass : #TestCase,
	#category : #'SOSolfege-deprecated'
}

{ #category : #testing }
SONotesTest class >> isDeprecated [
	^ true
]

{ #category : #tests }
SONotesTest >> testIsRankWithinBounds [
	self assert: (SONotes isRankWithinBounds: 1).
	self assert: (SONotes isRankWithinBounds: 29).
	self assert: (SONotes isRankWithinBounds: 10).
	self deny: (SONotes isRankWithinBounds: 40)
]

{ #category : #'as yet unclassified' }
SONotesTest >> testnameWithRank [
	self assert: (SONotes nameWithRank: 5) equals: 'g1'
]
