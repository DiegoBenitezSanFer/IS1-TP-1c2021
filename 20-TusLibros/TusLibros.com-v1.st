!classDefinition: #CartTest category: 'TusLibros.com'!
TestCase subclass: #CartTest
	instanceVariableNames: 'catalogue isbnOfTDDByExample'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CartTest methodsFor: 'setUp/tearDown' stamp: 'lilmonk3y 6/8/2021 20:41:21'!
setUp
	catalogue _ OrderedCollection new.
	
	isbnOfTDDByExample _ '9780321146533'.! !


!CartTest methodsFor: 'testing' stamp: 'lilmonk3y 6/8/2021 21:08:01'!
test01OnCartCreationItShouldBeEmpty
	| cart |
	cart _ Cart forCatalogue: catalogue .
	
	self assert: 0 equals: cart items size! !

!CartTest methodsFor: 'testing' stamp: 'lilmonk3y 6/8/2021 21:01:52'!
test02AddingAnItemModifiesCartSize
	| cart cartItems|

	catalogue add: isbnOfTDDByExample .
	cart _ Cart forCatalogue: catalogue.
	
	cart addItem: isbnOfTDDByExample .
	
	cartItems _ cart items.
	self assert: 1 equals: cartItems size.
	self assert: (cartItems includes: isbnOfTDDByExample ).! !

!CartTest methodsFor: 'testing' stamp: 'lilmonk3y 6/8/2021 21:02:34'!
test03CartAllowsMultiAdd
	| cart cartItems|
	
	catalogue add: isbnOfTDDByExample.
	cart _ Cart forCatalogue: catalogue.
	
	cart addItem: isbnOfTDDByExample amount: 2.
		
	cartItems _ cart items.
	self assert: 2 equals: cartItems size.
	self assert: (cartItems includes: isbnOfTDDByExample).! !

!CartTest methodsFor: 'testing' stamp: 'lilmonk3y 6/8/2021 21:03:21'!
test04CannotAddAnItemNotIncludedOnCartCatalogue
	| cart anInvalidISBN |
	cart _ Cart forCatalogue: catalogue.
	anInvalidISBN _ '9780321146537'.

	self should: [cart addItem: anInvalidISBN] 
		raise: Error withMessageText: Cart isbnNotPresentInCatalogueErrorDescription.
		! !

!CartTest methodsFor: 'testing' stamp: 'lilmonk3y 6/8/2021 21:04:05'!
test05CannotAddAnItemNotIncludedOnCatalogueInMultiAdd
	| cart notExistingISBN |
	notExistingISBN _ '1234'.
	cart _ Cart forCatalogue: catalogue.
	
	self should: [cart addItem: notExistingISBN amount: 2] 
		raise: Error withMessageText: Cart isbnNotPresentInCatalogueErrorDescription ! !

!CartTest methodsFor: 'testing' stamp: 'lilmonk3y 6/8/2021 21:04:56'!
test06CannotAddAnItemWithNegativeAmount
	| cart |
	catalogue add: isbnOfTDDByExample.
	cart _ Cart forCatalogue: catalogue.
	
	self should: [cart addItem: isbnOfTDDByExample amount: -1] 
		raise: Error withMessageText: Cart amountCannotBeANegativeNumberErrorDescription ! !


!classDefinition: #Cart category: 'TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'items catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cart methodsFor: 'validations' stamp: 'lilmonk3y 6/8/2021 20:47:18'!
validateAmountIsStrictlyPositive: anAmount

	^ (anAmount < 0) ifTrue: [self error: self class amountCannotBeANegativeNumberErrorDescription ]! !

!Cart methodsFor: 'validations' stamp: 'lilmonk3y 6/8/2021 20:37:16'!
validateItemISBNExistsInCatalogue: anItem

	^ (catalogue includes: anItem) ifFalse: [self error: self class isbnNotPresentInCatalogueErrorDescription ]! !


!Cart methodsFor: 'items' stamp: 'lilmonk3y 6/8/2021 20:36:24'!
addItem: anItem 

	self addItem: anItem amount: 1! !

!Cart methodsFor: 'items' stamp: 'lilmonk3y 6/8/2021 20:47:18'!
addItem: anItem amount: anAmount 
	
	self validateItemISBNExistsInCatalogue: anItem.
	self validateAmountIsStrictlyPositive: anAmount.
	
	items add: anItem withOccurrences: anAmount ! !

!Cart methodsFor: 'items' stamp: 'lilmonk3y 6/8/2021 19:53:21'!
items
	^ items .! !


!Cart methodsFor: 'initialization' stamp: 'lilmonk3y 6/8/2021 21:05:49'!
initializeWith: aCollection 
	catalogue := aCollection.
	items _ Bag new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros.com'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 6/8/2021 20:43:30'!
amountCannotBeANegativeNumberErrorDescription
	^ 'amount Cannot Be A Negative Number'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 6/8/2021 20:15:09'!
forCatalogue: aCollection 
	^ self new initializeWith: aCollection ! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 6/8/2021 20:16:57'!
isbnNotPresentInCatalogueErrorDescription
	^ 'isbn not present in catalogue'! !
