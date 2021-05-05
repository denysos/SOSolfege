"
represent a note coming from the Keyboard
"
Class {
	#name : #SOKeyboardNote,
	#superclass : #SONoteData,
	#category : #'SOSolfege-core'
}

{ #category : #initialization }
SOKeyboardNote >> defaultColor [
	^ Color red
]

{ #category : #accessing }
SOKeyboardNote >> origin [
	^ #keyboard
]
