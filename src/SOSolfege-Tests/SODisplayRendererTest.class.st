"
A SODisplayRendererTest is a test class for testing the behavior of SODisplayRenderer
"
Class {
	#name : #SODisplayRendererTest,
	#superclass : #TestCase,
	#instVars : [
		'testResult',
		'testTitle',
		'aScoreMorph',
		'infoTest',
		'testProcess'
	],
	#classVars : [
		'Dialog',
		'InfoMorph',
		'TestPassed',
		'TestTitle',
		'TestToPerform'
	],
	#category : #'SOSolfege-Tests-core'
}

{ #category : #'tests - helper' }
SODisplayRendererTest class >> createTestDisplayMorph: aCollectionOfStrings forScore: aMorph [
	| infoMorph infoTestMorph |
	infoMorph := Morph new extent: 350 @ 400.
	infoTestMorph := AlignmentMorph newColumn.
	infoTestMorph addMorph: aMorph.
	aCollectionOfStrings reversed
		do: [ :info | 
			infoTestMorph
				addMorph: ((StringMorph contents: info) backgroundColor: Color blue) ].
	infoMorph addMorph: infoTestMorph.
	^ infoMorph
]

{ #category : #'tests - helper' }
SODisplayRendererTest class >> morphForAdjacentNotesShiftWithMatch [
	| aNoteSetFromKB dr aCollector aNoteSetFromGen aNoteSet aScoreMorph |
	dr := SODisplayRenderer new.
	aCollector := SODisplayCollector new.
	aNoteSet := SONoteSet new
		addANoteWithRank: 16;
		addANoteWithRank: 17;
		addANoteWithRank: 21;
		yourself.
	aNoteSetFromGen := SONoteSet new.
	aNoteSet
		notesDo: [ :eachNote | aNoteSetFromGen addANote: eachNote asGeneratorNote ].
	aNoteSet := SONoteSet new
		addANoteWithRank: 16;
		addANoteWithRank: 17;
		addANoteWithRank: 24;
		yourself.
	aNoteSetFromKB := SONoteSet new.
	aNoteSet
		notesDo: [ :eachNote | aNoteSetFromKB addANote: eachNote asKeyboardNote ].
	aCollector addNewDraw: aNoteSetFromGen.
	aCollector addNewTry: aNoteSetFromKB.
	aScoreMorph := dr renderScoreFrom: aCollector.
	^ aScoreMorph
]

{ #category : #'tests - helper' }
SODisplayRendererTest class >> morphFortestAdjacentNotes3by3: aRank [
	| aNoteSetFromKB dr aCollector aNoteSet aScoreMorph |
	dr := SODisplayRenderer new.
	aCollector := SODisplayCollector new.
	aNoteSet := SONoteSet new
		addANoteWithRank: aRank;
		addANoteWithRank: aRank - 1;
		addANoteWithRank: aRank - 2;
		yourself.
	"	aNoteSetFromGen := SONoteSet new.
	aNoteSet
		ranksDo: [ :eachNote | aNoteSetFromGen addANote: eachNote asGeneratorNote ].
	aNoteSet := SONoteSet new
		addANoteWithRank: 16;
		addANoteWithRank: 17;
		addANoteWithRank: 24;
		yourself."
	aNoteSetFromKB := SONoteSet new.
	aNoteSet
		notesDo: [ :eachNote | aNoteSetFromKB addANote: eachNote asKeyboardNote ].
	"	aCollector addNewDraw: aNoteSetFromGen."
	aCollector addNewTry: aNoteSetFromKB.
	aScoreMorph := dr renderScoreFrom: aCollector.
	^ aScoreMorph
]

{ #category : #tests }
SODisplayRendererTest class >> sendTestDialog [

	Dialog := Smalltalk ui theme
		newPluggableTestDialogWindowIn: World
		title: TestTitle
		for: InfoMorph.
	Dialog testToPerform: TestToPerform.
	Dialog testClass: self.
	self setButtonsForDialog: Dialog.
	Dialog openModal
]

{ #category : #initialization }
SODisplayRendererTest class >> setButtonsForDialog: uiValidTest [
	uiValidTest buttons
		do: [ :each | 
			each label = 'Cancel'
				ifTrue: [ each
						label: 'Failed';
						setBalloonText: 'mark test as failed' ] ]
]

{ #category : #tests }
SODisplayRendererTest class >> testAdjacentNotes3by3 [
	<script>
	| infoTest aScoreMorph maxRank |
	TestPassed := true.
	TestToPerform := thisContext method selector.
	TestTitle := 'Display all notes, 3 by 3'.
	infoTest := {'press OK to display new group of 3'.
	'press Failed to stop testing' . 'notes are red, from KeyBoard'.
	'second note of the group must be shifted'.
	'mind the display of supp lines, under and above the score !'.
	''} asOrderedCollection.
	maxRank := SONoteData maxRank.
	[ :break | 
	3 to: maxRank do: [ :aRank | 
		TestPassed
			ifFalse: [ break value ].
		aScoreMorph := self morphFortestAdjacentNotes3by3: aRank.
		InfoMorph := self
			createTestDisplayMorph: infoTest
			forScore: aScoreMorph.
		self sendTestDialog ] ] valueWithExit
]

{ #category : #tests }
SODisplayRendererTest class >> testAdjacentNotesShiftWithMatch [
	<script>
	| infoTest aScoreMorph |
	TestToPerform := thisContext method selector.
	TestTitle := 'Test 2 adjacent notes matched by KBoard trigger shift'.
	infoTest := {'3 notes from gen : d3, e3, b3'.
	'3 notes from kb : d3, e3, e4' . 'd3 and e3 match -> color change to green'.
	'd3 and e3 are adjacent -> shift' . 'Score must display 4 notes : '.
	'd3 : green' . 'e3 : green with shift to the right'.
	'b3 : black' . 'e4 : red' . ''} asOrderedCollection.
	aScoreMorph := self morphForAdjacentNotesShiftWithMatch.
	InfoMorph := self
		createTestDisplayMorph: infoTest
		forScore: aScoreMorph.
	self sendTestDialog
]

{ #category : #accessing }
SODisplayRendererTest class >> testPassed [
	^ TestPassed
]

{ #category : #accessing }
SODisplayRendererTest class >> testPassed: anObject [
	TestPassed := anObject
]

{ #category : #test }
SODisplayRendererTest >> addGeneratorNotes: notesFromGenerator to: aNoteSet [
	notesFromGenerator
		do: [ :each | aNoteSet addANote: (SOGeneratorNote fromRank: each) ]
]

{ #category : #test }
SODisplayRendererTest >> addKeyboardNotes: notesFromKeyboard to: aNoteSet [
	notesFromKeyboard
		do: [ :each | aNoteSet addANote: (SOKeyboardNote fromRank: each) ]
]

{ #category : #'tests - helper' }
SODisplayRendererTest >> createTestDisplayMorph: aCollectionOfStrings forScore: aMorph [
	| infoMorph infoTestMorph |
	infoMorph := Morph new extent: 350 @ 400.
	infoTestMorph := AlignmentMorph newColumn.
	infoTestMorph addMorph: aMorph.
	aCollectionOfStrings reversed
		do: [ :info | 
			infoTestMorph
				addMorph: ((StringMorph contents: info) backgroundColor: Color blue) ].
	infoMorph addMorph: infoTestMorph.
	^ infoMorph
]

{ #category : #'as yet unclassified' }
SODisplayRendererTest >> dataPreparationForNotes3By3ForRank: aRank [

	| aNoteSetFromKB dr aCollector  aNoteSet |
		dr := SODisplayRenderer new.
	aCollector := SODisplayCollector new.
	aNoteSet := SONoteSet new
		addANoteWithRank: aRank  ;
		addANoteWithRank: aRank - 1 ;
		addANoteWithRank: aRank  - 2;
		yourself.
"	aNoteSetFromGen := SONoteSet new.
	aNoteSet
		ranksDo: [ :eachNote | aNoteSetFromGen addANote: eachNote asGeneratorNote ].
	aNoteSet := SONoteSet new
		addANoteWithRank: 16;
		addANoteWithRank: 17;
		addANoteWithRank: 24;
		yourself."
	aNoteSetFromKB := SONoteSet new.
	aNoteSet
		notesDo: [ :eachNote | aNoteSetFromKB addANote: eachNote asKeyboardNote ].
"	aCollector addNewDraw: aNoteSetFromGen."
	aCollector addNewTry: aNoteSetFromKB.
	aScoreMorph := dr renderScoreFrom: aCollector
]

{ #category : #'as yet unclassified' }
SODisplayRendererTest >> displayInfoTest: aCollectionOfStrings forScore: aMorph [
	| infoMorph|

"	testTitle := aCollectionOfStrings at: 1."
	infoMorph := self
		createTestDisplayMorph: aCollectionOfStrings
		forScore: aMorph.

]

{ #category : #'tests - helper' }
SODisplayRendererTest >> morphForAdjacentNotesShiftWithMatch [
	| aNoteSetFromKB dr aCollector aNoteSetFromGen aNoteSet |
	dr := SODisplayRenderer new.
	aCollector := SODisplayCollector new.
	aNoteSet := SONoteSet new
		addANoteWithRank: 16;
		addANoteWithRank: 17;
		addANoteWithRank: 21;
		yourself.
	aNoteSetFromGen := SONoteSet new.
	aNoteSet
		notesDo: [ :eachNote | aNoteSetFromGen addANote: eachNote asGeneratorNote ].
	aNoteSet := SONoteSet new
		addANoteWithRank: 16;
		addANoteWithRank: 17;
		addANoteWithRank: 24;
		yourself.
	aNoteSetFromKB := SONoteSet new.
	aNoteSet
		notesDo: [ :eachNote | aNoteSetFromKB addANote: eachNote asKeyboardNote ].
	aCollector addNewDraw: aNoteSetFromGen.
	aCollector addNewTry: aNoteSetFromKB.
	aScoreMorph := dr renderScoreFrom: aCollector
]

{ #category : #'as yet unclassified' }
SODisplayRendererTest >> performDisplayTest [
	| infoMorph uiValidTest |
	infoMorph := self
		createTestDisplayMorph: infoTest
		forScore: aScoreMorph.
	uiValidTest := Smalltalk ui theme
		newPluggableDialogWindowIn: World
		title: testTitle
		for: infoMorph.
	self setButtonsForDialog: uiValidTest.	"testProcess resume"
	[ uiValidTest openModal ] forkAndWait	"	uiValidTest openModal."
]

{ #category : #'tests - helper' }
SODisplayRendererTest >> sendTestWindowforScore: infoMorph [
	"	| testProcess uiValidTest |"

	| uiValidTest |
	"	testProcess := Processor activeProcess."
	uiValidTest := Smalltalk ui theme
		newPluggableDialogWindowIn: World
		title: testTitle
		for: infoMorph.
	self setButtonsForDialog: uiValidTest.
	"testProcess resume"
	[ uiValidTest openModal ] forkAndWait
	"	uiValidTest openModal."
]

{ #category : #'tests - helper' }
SODisplayRendererTest >> setButtonsForDialog: uiValidTest [
	uiValidTest buttons
		do: [ :each | 
			each label = 'Cancel'
				ifTrue: [ each
						label: 'Failed';
						setBalloonText: 'mark test as failed';
						actionBlock: [ testResult := false.
							uiValidTest close.
							testProcess resume ];
						actionSelector: #value ].
			each label = 'OK'
				ifTrue: [ each
						actionBlock: [ uiValidTest
								cancelled: false;
								applyChanges;
								"testProcess resume"
									delete ];
						actionSelector: #value ] ]
]

{ #category : #'as yet unclassified' }
SODisplayRendererTest >> testAdjacentNotes3by3 [
	"to run this test, see same selector, class side (run the script by clicking on method icon)"
	"will open a dialog to validate the morph display"

]

{ #category : #'as yet unclassified' }
SODisplayRendererTest >> testAdjacentNotes3by3WithDialog [
	"this test is testing the same display than the script with the same name on class side"

	| maxRank |
	testTitle := 'Display all notes, 3 by 3'.
	infoTest := {'press OK to display new group of 3'.
	'press Failed to stop testing' . 'notes are red, from KeyBoard'.
	'second note of the group must be shifted'.
	'mind the display of supp lines, under and above the score !'.
	''} asOrderedCollection.
	testResult := true.
	maxRank := SONoteData maxRank.
	testProcess := Processor activeProcess.
	"start on 3 because we start on the higher rank of the 3 notes to show :"
	[ 3 to: maxRank do: [ :aRank | 
		| infoMorph |
		self dataPreparationForNotes3By3ForRank: aRank.
		infoMorph := self
			createTestDisplayMorph: infoTest
			forScore: aScoreMorph.
		self sendTestWindowforScore: infoMorph.	"testProcess resume"
		self ].
	testProcess resume ] fork.
	testProcess suspend.
	self assert: testResult description: testTitle
]

{ #category : #'as yet unclassified' }
SODisplayRendererTest >> testAdjacentNotesShiftWithMatch [
	"to run this test, see same selector, class side (run the script by clicking on method icon)"
	"will open a dialog to validate the morph display"


]

{ #category : #'as yet unclassified' }
SODisplayRendererTest >> testAdjacentNotesShiftWithMatchWithDialog [
	"this test is testing the same display than the script with the same name on class side"

	testTitle := 'Test 2 adjacents notes matched by KBoard trigger shift'.
	infoTest := {'3 notes from gen : d3, e3, b3'.
	'3 notes from kb : d3, e3, e4' . 'd3 and e3 match -> color change to green'.
	'd3 and e3 are adjacent -> shift' . 'Score must display 4 notes : '.
	'd3 : green' . 'e3 : green with shift to the right'.
	'b3 : black' . 'e4 : red' . ''} asOrderedCollection.
	testResult := true.
	self morphForAdjacentNotesShiftWithMatch.
	testProcess := Processor activeProcess.
	[ " testProcess suspend."
	self performDisplayTest.
	testProcess resume ] fork.
	testProcess suspend.
	self assert: testResult description: testTitle
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
		notesDo: [ :each | 
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
		notesDo: [ :each | 
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

{ #category : #accessing }
SODisplayRendererTest >> testPassed [
	^ testResult
]

{ #category : #accessing }
SODisplayRendererTest >> testPassed: anObject [
	testResult := anObject
]

{ #category : #accessing }
SODisplayRendererTest >> testTitle [
	^ testTitle
]

{ #category : #accessing }
SODisplayRendererTest >> testTitle: anObject [
	testTitle := anObject
]
