Class {
	#name : #SOSKEYBDINPUT,
	#superclass : #FFIStructure,
	#classVars : [
		'DWORD',
		'INPUTSize',
		'KeyboardEventValue',
		'OFFSET_DWEXTRAINFO',
		'OFFSET_DWFLAGS',
		'OFFSET_TIME',
		'OFFSET_TYPE',
		'OFFSET_WSCAN',
		'OFFSET_WVK',
		'ULONG_PTR',
		'WORD'
	],
	#category : #'SOSolfege-pianoToText'
}

{ #category : #'field definition' }
SOSKEYBDINPUT class >> fieldsDesc [ 
^ #(
	DWORD     type;  "4 octets"
	WORD      wVk;   "2 octets"
	WORD      wScan; "2 octets"
	DWORD     dwFlags; "4 octets"
	DWORD     time;    "4 octets"  
	ULONG_PTR dwExtraInfo; "8 octets ?"
)
]

{ #category : #'class initialization' }
SOSKEYBDINPUT class >> initialize [
	WORD := #uint16.
	DWORD := #uint32.
	"ULONG_PTR := #uint64."
	"INPUTSize := 24." "bytes"
	ULONG_PTR := #ulong.
	INPUTSize := 16. "bytes"
	KeyboardEventValue := 1 "1 means keyboard is used, ... see another value for mouse ..."
]

{ #category : #'accessing structure variables' }
SOSKEYBDINPUT >> dwExtraInfo [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_DWEXTRAINFO
]

{ #category : #'accessing structure variables' }
SOSKEYBDINPUT >> dwExtraInfo: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_DWEXTRAINFO put: anObject
]

{ #category : #'accessing structure variables' }
SOSKEYBDINPUT >> dwFlags [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWFLAGS
]

{ #category : #'accessing structure variables' }
SOSKEYBDINPUT >> dwFlags: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWFLAGS put: anObject
]

{ #category : #initialization }
SOSKEYBDINPUT >> initialize [
	super initialize.
	self type: KeyboardEventValue
]

{ #category : #'accessing structure variables' }
SOSKEYBDINPUT >> time [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_TIME
]

{ #category : #'accessing structure variables' }
SOSKEYBDINPUT >> time: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_TIME put: anObject
]

{ #category : #'accessing structure variables' }
SOSKEYBDINPUT >> type [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_TYPE
]

{ #category : #'accessing structure variables' }
SOSKEYBDINPUT >> type: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_TYPE put: anObject
]

{ #category : #'accessing structure variables' }
SOSKEYBDINPUT >> wScan [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_WSCAN
]

{ #category : #'accessing structure variables' }
SOSKEYBDINPUT >> wScan: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_WSCAN put: anObject
]

{ #category : #'accessing structure variables' }
SOSKEYBDINPUT >> wVk [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_WVK
]

{ #category : #'accessing structure variables' }
SOSKEYBDINPUT >> wVk: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_WVK put: anObject
]
