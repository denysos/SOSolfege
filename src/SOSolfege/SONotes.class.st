"
knows the names of all the notes that can be on the score


Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #SONotes,
	#superclass : #Object,
	#classVars : [
		'MaxRank',
		'Notes'
	],
	#category : #'SOSolfege-deprecated'
}

{ #category : #parameters }
SONotes class >> allNotesOnScore [
	"to be moved in a param class ?"

	^ {'c1' . 'd1' . 'e1' . 'f1' . 'g1' . 'a1' . 'b1' . 'c2' . 'd2' . 'e2'.
	'f2' . 'g2' . 'a2' . 'b2' . 'c3' . 'd3' . 'e3' . 'f3' . 'g3' . 'a3'.
	'b3' . 'c4' . 'd4' . 'e4' . 'f4' . 'g4' . 'a4' . 'b4' . 'c5'}
		asOrderedCollection
]

{ #category : #'class initialization' }
SONotes class >> initialize [
	Notes := self allNotesOnScore.
	MaxRank := Notes size
]

{ #category : #testing }
SONotes class >> isDeprecated [
	^ true
]

{ #category : #testing }
SONotes class >> isRankWithinBounds: anInteger [
	^ (anInteger <= MaxRank) and: (anInteger >= 1)
]

{ #category : #accessing }
SONotes class >> nameWithRank: anInteger [
	^ Notes at: anInteger
]
