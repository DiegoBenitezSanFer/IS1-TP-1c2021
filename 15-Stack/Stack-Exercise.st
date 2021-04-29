!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 4/22/2021 17:25:26'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstObject'.
	secondPushedObject := 'secondObject'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'cr 4/28/2021 21:36:15'!
test11SizeOfStackIsCorrectAfterAddingAndDeletingElements
	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstObject'.
	secondPushedObject := 'secondObject'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	stack pop = secondPushedObject.
	stack push: secondPushedObject.
	 
	self assert: stack size equals: 2! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinder element1 element2 element3'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setUp/tearDown' stamp: 'cr 4/28/2021 21:15:58'!
setUp
	sentenceFinder  _ SentenceFinderByPrefix new.
	
	element1  _ 'an element'.
	element2  _ 'another element'.
	element3 _ 'not present'.! !


!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'cr 4/28/2021 19:58:48'!
test01FindingElementsInEmptySentenceFinderReturnsAnEmptyCollection
	|result|
	result _ sentenceFinder find: 'prefix'.
	self assert: result isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'cr 4/28/2021 20:32:57'!
test02WhenTheExpectedPrefixMatchAllElementsMustReturnAll
	|result|

	sentenceFinder add: element1 ; add: element2 .
	
	result _ sentenceFinder find: 'a'.
	
	self assert: (result includes: element1) .
	self assert: (result includes: element2)! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'cr 4/28/2021 20:33:24'!
test03EmptyPrefixCannotBeValid

	self should: [sentenceFinder find: ''] 
		raise: Error 
		withMessageText: SentenceFinderByPrefix EmptyPrefixIsNotAllowedErrorDescription .
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'cr 4/28/2021 20:42:22'!
test04SpacePrefixCannotBeValid

	self should: [sentenceFinder find: ' '] 
		raise: Error 
		withMessageText: SentenceFinderByPrefix PrefixWithSpacesNotAllowedErrorDescription.
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'cr 4/28/2021 20:42:41'!
test05PrefixWithSpacesCannotBeValid

	self should: [sentenceFinder find: 'Prefix with spaces'] 
		raise: Error 
		withMessageText: SentenceFinderByPrefix PrefixWithSpacesNotAllowedErrorDescription.
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'cr 4/28/2021 20:23:16'!
test06FindingWordsDoesNotModifyInnerStackOrder
	|innerStack|
	
	sentenceFinder add: element1 ; add: element2 .
	
	sentenceFinder find: 'a'.
	innerStack _ sentenceFinder stack.
	
	self assert: innerStack pop equals: element2.
	self assert: innerStack pop equals: element1.	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'cr 4/28/2021 21:16:39'!
test07FindingWordsNotMatchingPrefixMustNotBeReturned
	|result|
	
	sentenceFinder add: element1 ; add: element2 ; add: element3 .
	
	result _ sentenceFinder find: 'a'.
	
	self deny: (result includes: element3)
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'cr 4/28/2021 21:12:19'!
test08FindMethodAlwaysReturnSameOrder
	|firstResult secondResult|
	
	sentenceFinder add: element1 ; add: element2 .
	
	firstResult _ sentenceFinder find: 'a'.
	secondResult _ sentenceFinder find: 'a'.
	
	self assert: firstResult equals: secondResult 
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'current size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'DB 4/27/2021 20:36:39'!
pop
	| top |
	top _ self top.
	current _ current previous.
	size _ size - 1.
	^ top ! !

!OOStack methodsFor: 'operations' stamp: 'DB 4/27/2021 20:36:56'!
push: anElement

	current _ current add: anElement.
	size _ size + 1.
	^current value! !

!OOStack methodsFor: 'operations' stamp: 'cr 4/26/2021 18:37:01'!
top

	^ current value! !


!OOStack methodsFor: 'initialization' stamp: 'cr 4/26/2021 21:08:18'!
initialize
	current _ EmptyNode new.
	size _ 0! !


!OOStack methodsFor: 'testing' stamp: 'cr 4/26/2021 18:38:59'!
isEmpty

	^ self size = 0
! !

!OOStack methodsFor: 'testing' stamp: 'DB 4/27/2021 20:35:39'!
size

	^size
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 4/22/2021 17:22:41'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!!!!!'! !


!classDefinition: #OOStackNode category: 'Stack-Exercise'!
Object subclass: #OOStackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNode methodsFor: 'operations' stamp: 'DB 4/27/2021 20:54:33'!
add: anElement

	^ NotEmptyNode with: anElement andPrevious: self! !

!OOStackNode methodsFor: 'operations' stamp: 'cr 4/28/2021 20:49:04'!
previous
	self subclassResponsibility ! !


!OOStackNode methodsFor: 'accesing' stamp: 'cr 4/26/2021 20:53:06'!
value
	^ self subclassResponsibility ! !


!classDefinition: #EmptyNode category: 'Stack-Exercise'!
OOStackNode subclass: #EmptyNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyNode methodsFor: 'accesing' stamp: 'cr 4/26/2021 20:01:25'!
value
	^ self error: OOStack stackEmptyErrorDescription ! !


!EmptyNode methodsFor: 'operations' stamp: 'cr 4/28/2021 20:49:57'!
previous! !


!classDefinition: #NotEmptyNode category: 'Stack-Exercise'!
OOStackNode subclass: #NotEmptyNode
	instanceVariableNames: 'previous value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyNode methodsFor: 'initialization' stamp: 'DB 4/27/2021 20:54:15'!
initializeWith: anElement andPrevious: aPreviousNode
	value _ anElement.
	previous  _ aPreviousNode ! !


!NotEmptyNode methodsFor: 'accesing' stamp: 'cr 4/26/2021 18:41:48'!
value
	^ value! !


!NotEmptyNode methodsFor: 'operations' stamp: 'cr 4/28/2021 20:50:31'!
previous
	^ previous ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyNode class' category: 'Stack-Exercise'!
NotEmptyNode class
	instanceVariableNames: ''!

!NotEmptyNode class methodsFor: 'instance creation' stamp: 'DB 4/27/2021 20:54:33'!
with: anElement andPrevious: aPreviousNode
	^ NotEmptyNode new initializeWith: anElement andPrevious: aPreviousNode ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'cr 4/26/2021 21:17:44'!
initialize
	stack _ OOStack new! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'DB 4/27/2021 21:23:35'!
add: anElement 

	stack push: anElement ! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'cr 4/28/2021 19:52:51'!
find: aPrefix
	|foundSentences backupStack |
	
	self validatePrefix: aPrefix.
	
	backupStack _ OOStack new.
	foundSentences _ self selectSentensesStartingWith: aPrefix AndBackupStackOn: backupStack.
	
	self restoreStackWith: backupStack.

	^foundSentences 
	
	! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'cr 4/28/2021 21:22:27'!
restoreStackWith: backupStack

	[backupStack isEmpty] whileFalse: [stack push: backupStack pop]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'cr 4/28/2021 19:36:49'!
selectSentensesStartingWith: aPrefix AndBackupStackOn: backupStack
	|foundSentences|
	
	foundSentences _ OrderedCollection new.
	[stack isEmpty] whileFalse: [ | aSentence |
		aSentence := stack pop.
		(aSentence beginsWith: aPrefix) ifTrue: [ foundSentences add: aSentence].
		backupStack push: aSentence
	].

	^foundSentences 

	
	! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'cr 4/28/2021 19:24:44'!
validatePrefix: aPrefix

	"assert not empty"
	aPrefix isEmpty ifTrue: [^self error: self class EmptyPrefixIsNotAllowedErrorDescription].
	"assert has no spaces"
	((aPrefix findString: ' ') = 0) ifFalse: [^self error: self class PrefixWithSpacesNotAllowedErrorDescription].! !


!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'cr 4/28/2021 20:03:38'!
stack
	^ stack! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'DB 4/27/2021 20:30:02'!
EmptyPrefixIsNotAllowedErrorDescription
	^ 'empty prefix is not allowed'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 21:52:24'!
PrefixWithSpacesNotAllowedErrorDescription
	^ 'prefix with spaces not allowed'! !
