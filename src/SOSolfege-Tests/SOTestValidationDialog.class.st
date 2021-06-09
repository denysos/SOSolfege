"
this dialog present the result of a test case as a Morph, and launch the testcase with the expected result : test pass or test fail
"
Class {
	#name : #SOTestValidationDialog,
	#superclass : #PluggableDialogWindow,
	#instVars : [
		'testResult',
		'testTitle',
		'aScoreMorph',
		'infoTest',
		'testToPerform',
		'testClass'
	],
	#category : #'SOSolfege-Tests-core'
}

{ #category : #actions }
SOTestValidationDialog >> cancel [
	super cancel.
	(testClass history at: #passed) remove: testToPerform ifAbsent: [  ].
	(testClass history at: #errors) remove: testToPerform ifAbsent: [  ].
	(testClass history at: #failures) add: testToPerform.
	testClass testPassed: false
]

{ #category : #initialization }
SOTestValidationDialog >> initialize [
	super initialize.
	testTitle := self title
]

{ #category : #actions }
SOTestValidationDialog >> ok [
	| testInstance |
	super ok.
	"	testInstance := testClass new.
	testInstance testResult: true.
	testInstance setTestSelector: testToPerform.
	testInstance testTitle: self title."
	"testClass run: testToPerform"
	(testClass history at: #failures)
		remove: testToPerform
		ifAbsent: [  ].
	(testClass history at: #errors) remove: testToPerform ifAbsent: [  ].
	(testClass history at: #passed) add: testToPerform
]

{ #category : #accessing }
SOTestValidationDialog >> testClass [
	^ testClass
]

{ #category : #accessing }
SOTestValidationDialog >> testClass: anObject [
	testClass := anObject
]

{ #category : #accessing }
SOTestValidationDialog >> testToPerform [
	^ testToPerform
]

{ #category : #accessing }
SOTestValidationDialog >> testToPerform: anObject [
	testToPerform := anObject
]
