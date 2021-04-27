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


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'nil' stamp: 'cr 4/26/2021 21:11:46'!
setUp
	sentenceFinder  _ SentenceFinderByPrefix new! !


!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 21:16:18'!
test01FindingElementsInEmptySentenceFinderReturnsAnEmptyCollection
	|result|
	result _ sentenceFinder find: ''.
	self assert: result isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 21:43:40'!
test02WhenTheExpectedPrefixMatchAllElementsMustReturnAll
	|result element1 element2|
	element1  _ 'an element'.
	element2  _ 'another element'.
	sentenceFinder add: element1 ; add: element2 .
	result _ sentenceFinder find: 'a'.
	self assert: (result includes: element1) .
	self assert: (result includes: element2)! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 21:52:50'!
test03xxxx
	self should: [sentenceFinder find: 'an '] raise: Error withMessageText: SentenceFinderByPrefix PrefixWithSpacesNotAllowedErrorDescription.
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'current size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 21:08:18'!
initialize
	current _ EmptyNode new.
	size _ 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 18:38:59'!
isEmpty

	^ self size = 0
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 21:07:40'!
pop
	|currentValue|
	currentValue _ current value.
	current _ current previous.
	size _ size - 1.
	^ currentValue ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 21:07:21'!
push: anElement
	current _ current add: anElement.
	size _ size + 1.
	^current value! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 21:06:58'!
size
	^size
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 18:37:01'!
top

	^ current value! !

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

!OOStackNode methodsFor: 'nil' stamp: 'cr 4/26/2021 20:53:06'!
value
	^ self subclassResponsibility ! !


!OOStackNode methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 20:55:20'!
add: anElement

	^ NotEmptyNode with: anElement withPrevious: self! !

!OOStackNode methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 20:52:53'!
hasPrevious
	^ self subclassResponsibility ! !

!OOStackNode methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 20:53:00'!
previous
	^ self subclassResponsibility ! !


!classDefinition: #EmptyNode category: 'Stack-Exercise'!
OOStackNode subclass: #EmptyNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyNode methodsFor: 'nil' stamp: 'cr 4/26/2021 20:01:25'!
value
	^ self error: OOStack stackEmptyErrorDescription ! !


!EmptyNode methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 19:17:52'!
hasPrevious

	^ false! !

!EmptyNode methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 19:22:47'!
previous
	self value! !


!classDefinition: #NotEmptyNode category: 'Stack-Exercise'!
OOStackNode subclass: #NotEmptyNode
	instanceVariableNames: 'previous value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!NotEmptyNode methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 19:18:12'!
hasPrevious
	
	^ true! !

!NotEmptyNode methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 18:44:59'!
initializeWith: anElement withPrevious: aPreviousNode
	value _ anElement.
	previous  _ aPreviousNode ! !

!NotEmptyNode methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 19:23:03'!
previous
	^ previous ! !

!NotEmptyNode methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 18:41:48'!
value
	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyNode class' category: 'Stack-Exercise'!
NotEmptyNode class
	instanceVariableNames: ''!

!NotEmptyNode class methodsFor: 'nil' stamp: 'cr 4/26/2021 18:44:17'!
with: anElement withPrevious: aPreviousNode
	^ NotEmptyNode new initializeWith: anElement withPrevious: aPreviousNode ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'nil' stamp: 'cr 4/26/2021 21:17:44'!
initialize
	stack _ OOStack new! !


!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 21:31:03'!
add: anElement 
	stack push: anElement ! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 21:42:32'!
allElements
	|elements|
	elements _ OrderedCollection new.
	[stack isEmpty] whileFalse: [elements add: stack pop].
	^elements ! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 21:41:21'!
find: aPrefix
	|stackElements|
	stackElements _ self allElements.
	^ stackElements select: [:element | element beginsWith: aPrefix ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'cr 4/26/2021 21:52:24'!
PrefixWithSpacesNotAllowedErrorDescription
	^ 'prefix with spaces not allowed'! !
