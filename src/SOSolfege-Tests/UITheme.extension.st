Extension { #name : #UITheme }

{ #category : #'*SOSolfege-Tests' }
UITheme >> newPluggableTestDialogWindowIn: aThemedMorph title: title for: contentMorph [
	"Answer a new pluggable dialog panel with the given content."

	|answer|
	answer := SOTestValidationDialog  new
		setWindowColor: aThemedMorph paneColor;
		title: title;
		contentMorph: contentMorph.
	contentMorph ifNotNil: [answer model: nil].
	^answer
]
