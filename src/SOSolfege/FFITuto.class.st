"
pour pianoToText :

voir utilisation de la lib SDL2 pour la gestion des événements ?

voir communication C/C++ pour utiliser user32.dll ??? : https://www.teddy.ch/c++_library_in_c/
ou utilisation du package Pharo-com : https://github.com/tesonep/pharo-com
ou voir le package  ""parasol"", (test de page web) comment les touches sont simulées ??? ---> envoie le texte à une API Java

à tester :

aTypeArrayOfEvents := FFIArray newArrayTypeOf: #SOSKEYBDINPUT size: 2.
anArrayOfEvents := aTypeArrayOfEvents new.
aKeyPressed := SOSKEYBDINPUT new
		wVk: 71;
		yourself.
		
utiliser : aKeyPressed sizeInMemory  ""pour la longeur de #SOSKEYBDINPUT lors de l'appel""
INPUTSizeForKB := 16. ""ou 20 ou 24 ????   ---> même resultat !!!""

**********************************************************************************************
Questions : 

- comment definir un type de tableau, mais de dimension inconnue au moment de la déclaration
- UFFIArray de struct 
  pas possible de modifier les éléments avec at:put: !
  on est obliger de sélectionner un élément, et ensuite de modifier les données de la structure avec
  les accesseurs :
  #+BEGIN_SRC smalltalk
    anArrayOfEvents := ATypeArrayOfEvents new.	""FFIArray , must be created BEFORE using it !!! no cascade after new !!!""
		""once created, an array with complex types, each element must be filled in the array !""
	(anArrayOfEvents at: 1) wVk: aKeyPressed wVk .
	(anArrayOfEvents at: 2) wVk: aKeyReleased wVk ; dwFlags: aKeyReleased dwFlags .
  #+END_SRC

*********************************************************************************************

tuto of the UFFI booklet

exemple d'utilisation de la biblio  Windows User32 :

User32 class>>getActiveWindow
	^ self ffiCall: #(HWND GetActiveWindow()) module: 'User32.dll'

pour simulation d'un evenement clavier voir :
cf SendInput
https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-sendinput
https://docs.microsoft.com/en-us/windows/win32/api/winuser/ns-winuser-input
https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-keybd_event
https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes

*************************** playground *************************************************************

""****** init *********""
FFITuto initialize .
SOSKEYBDINPUT initialize .
SOSKEYBDINPUT rebuildFieldAccessors.

""****** tests ********""
(Delay forSeconds: 8) wait. 
""1 halt .""
FFITuto sendKey.

""****** inspector ***********""
input := SOSKEYBDINPUT new .

""****** inspector ***********""
aTypeArrayOfEvents := FFIArray newArrayTypeOf: #SOSKEYBDINPUT size: 2.
anArrayOfEvents := aTypeArrayOfEvents new.
aKeyPressed := SOSKEYBDINPUT new
		wVk: 71;
		yourself.

""******* exemples tuto UFFI *******************************************""
tps := FFITuto ticksSinceStart.
absn := FFITuto abs: -15.

""libc dispo pour linux et mac en pharo notif (?), mais pas sur windows ""
""cf classe LibC ""


"
Class {
	#name : #FFITuto,
	#superclass : #Object,
	#classVars : [
		'ATypeArrayOfEvents',
		'INPUTSizeForKB'
	],
	#category : #'SOSolfege-pianoToText'
}

{ #category : #infos }
FFITuto class >> abs: n [
	^ self ffiCall: #(int abs (int n)) library: 'msvcrt.dll'
]

{ #category : #'as yet unclassified' }
FFITuto class >> emptyClipboard [
"BOOL EmptyClipboard();"
"cette fonction est bien trouvée, pas d'erreur !!!"
^ self ffiCall: #(bool EmptyClipboard ()) library: 'user32.dll'
]

{ #category : #'class initialization' }
FFITuto class >> initialize [
	INPUTSizeForKB := 24. "16 20 ou 24 ???"
	"a temporary arrray of event, needed to test sendInput:, but have to find a solution to manage differents sizes on each call !!! "
	ATypeArrayOfEvents := FFIArray newArrayTypeOf: #SOSKEYBDINPUT size: 2.
	
]

{ #category : #'as yet unclassified' }
FFITuto class >> sendInput: arrayOfEvents [
	| numberOfEvents |
	numberOfEvents := arrayOfEvents size.
	self sendInput: arrayOfEvents ofNEvents: numberOfEvents
]

{ #category : #'private utils' }
FFITuto class >> sendInput: arrayOfEvents ofNEvents: anInteger [ 
"fonctionne, mais pas d'effet !"

^ self ffiCall: #( uint SendInput (uint anInteger SOSKEYBDINPUT arrayOfEvents int INPUTSizeForKB) ) library: 'user32.dll'

"^ self ffiCall: #( uint SendInput (uint anInteger ATypeArrayOfEvents arrayOfEvents int INPUTSizeForKB) ) library: 'user32.dll'" 






"^ self ffiCall: #(bool EmptyClipboard ()) library: 'user32.dll'" "appel ok, pas d'erreur !"

]

{ #category : #'tests - examples' }
FFITuto class >> sendKey [
	"test with key 'g' -> 0x47"
	"the letter 'g' must be typed in the active window !"

	self sendKey: 16r47.
"	self sendKey: 16r0D."
]

{ #category : #'keyboard control' }
FFITuto class >> sendKey: aKeyInHexa [
	| anArrayOfEvents aKeyPressed aKeyReleased |
	"aTypeArrayOfEvents := FFIArray newArrayTypeOf: #SOSKEYBDINPUT size: 2.   --> defined as Class var !!"
	aKeyPressed := SOSKEYBDINPUT new
		wVk: aKeyInHexa;
		yourself.
	aKeyReleased := SOSKEYBDINPUT new
		wVk: aKeyInHexa;
		dwFlags: 16r0002;
		"KEYEVENTF_KEYUP"
			yourself.
	anArrayOfEvents := ATypeArrayOfEvents new.	
		"anArrayOfEvents pinInMemory ."
	"anArrayOfEvents := ATypeArrayOfEvents externalNew."
		"FFIArray , must be created BEFORE using it !!! no cascade after new !!!"
		"once created, an array with complex types, each element must be filled in the array !"
	(anArrayOfEvents at: 1) wVk: aKeyPressed wVk .
	(anArrayOfEvents at: 2) wVk: aKeyReleased wVk ; dwFlags: aKeyReleased dwFlags .

	self sendInput: anArrayOfEvents
]

{ #category : #infos }
FFITuto class >> ticksSinceStart [
 ^ self ffiCall: #(uint clock()) library: 'msvcrt.dll' 
]
