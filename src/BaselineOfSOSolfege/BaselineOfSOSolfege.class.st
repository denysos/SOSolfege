Class {
	#name : #BaselineOfSOSolfege,
	#superclass : #BaselineOf,
	#category : #BaselineOfSOSolfege
}

{ #category : #baselines }
BaselineOfSOSolfege >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Dependencies"
			self sound: spec.

			"Packages"
			spec
				package: 'SOSolfege';
				package: 'SOSolfege-Tests'
					with: [ spec requires: #('SOSolfege') ] ]
]

{ #category : #accessing }
BaselineOfSOSolfege >> projectClass [
	^ MetacelloCypressBaselineProject
]

{ #category : #accessing }
BaselineOfSOSolfege >> sound: spec [
	spec
		baseline: 'Sound'
		with: [ spec repository: 'github://pharo-contributions/Sound/src' ]
]
