Extension { #name : #Collection }

{ #category : #'*SOSolfege' }
Collection >> doAdjacentPairs: aBlock [
	"iterating over adjacent pairs in a collection.
	return value of aBloc.
	inspired by 'inject:into:' 
	to emulate : 	inject: nil
   						into: [:eachPrevious :eachNext | eachPrevious notNil ifTrue: [...].
         						                           eachNext]
	at the very begining, prevValue is nil , and each = first element in the collection.
	these values are evaluated in aBloc, so that it can be taken into account in the logic in aBloc"

	"remove duplicates :
cNoDup := OrderedCollection new . #(1 1 2 3 3 5 9 9 9) doAdjacentPairs: [ :p :n | p ~= n ifTrue: [cNoDup add: n ]. cNoDup ] >>>  #(1 2 3 5 9)"

	| prevValue aBlocValue |
	prevValue := nil.
	self
		do: [ :each | 
			aBlocValue := aBlock value: prevValue value: each.
			prevValue := each ].
	^ aBlocValue
]
