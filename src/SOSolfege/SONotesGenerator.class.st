"
purpose : Draw notes from the list of notes selected to learn

  | responsibilities                                     | collaboration               |
  |------------------------------------------------------+-----------------------------|
  | select notes at random in the list of notes to learn | SOParam, SODisplayCollector |
  |                                                      |                             |

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #SONotesGenerator,
	#superclass : #Object,
	#category : #'SOSolfege-core'
}

{ #category : #'sub item creating' }
SONotesGenerator >> singleDrawFrom: anExercice [
	^ anExercice noteSet
		subsetAtRandomWith: anExercice notesNumberInADraw
]
