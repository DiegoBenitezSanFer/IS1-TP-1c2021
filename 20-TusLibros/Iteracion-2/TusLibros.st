!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'DB 6/14/2021 19:36:00'!
setUp
	
	factory := StoreTestObjectsFactory new.! !

!CartTest methodsFor: 'tests' stamp: 'DB 6/14/2021 19:36:09'!
test01NewCartsAreCreatedEmpty

	self assert: factory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'DB 6/14/2021 19:36:30'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := factory createCart.
	
	self 
		should: [ cart add: factory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'DB 6/14/2021 19:36:34'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := factory createCart.
	
	cart add: factory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'DB 6/14/2021 19:36:39'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := factory createCart.
	
	self 
		should: [cart add: 0 of: factory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'DB 6/14/2021 19:36:44'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := factory createCart.
	
	self 
		should: [cart add: 2 of: factory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'DB 6/14/2021 19:36:53'!
test06CartRemembersAddedItems

	| cart |
	
	cart := factory createCart.
	
	cart add: factory itemSellByTheStore.
	self assert: (cart includes: factory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'DB 6/14/2021 19:37:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := factory createCart.
	
	self deny: (cart includes: factory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'DB 6/14/2021 19:37:06'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := factory createCart.
	
	cart add: 2 of: factory itemSellByTheStore.
	self assert: (cart occurrencesOf: factory itemSellByTheStore) = 2! !



!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'salesBook expiredMonth expiredYear factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setUp/tearDown' stamp: 'DB 6/14/2021 19:27:13'!
setUp
	salesBook := OrderedCollection new.
	factory := StoreTestObjectsFactory new.! !


!CashierTest methodsFor: 'test' stamp: 'DB 6/14/2021 19:54:55'!
test01CannotCheckoutAnEmptyCart
	
	| cart cashier |
	cart := factory createCart.
	
	cashier := factory createCashierWith: salesBook .
	
	self should: [ cashier checkout: cart on: factory validCreditCard ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier cannotCheckoutAnEmptyCartErrorDescription! !

!CashierTest methodsFor: 'test' stamp: 'DB 6/14/2021 19:55:05'!
test02CheckoutWithAValidCardShouldBeSuccessful
	
	| cart cashier |
	cart := factory createCart.
	cart add: factory itemSellByTheStore.

	cashier := factory createCashierWith: salesBook .

	cashier checkout: cart on: factory validCreditCard .
	
	self assert: 1 equals: salesBook size.
	self assert: salesBook includes: factory priceOFitemSellByTheStore.
	! !

!CashierTest methodsFor: 'test' stamp: 'DB 6/14/2021 19:55:12'!
test03CannotPayWithAnExpiredCard
	
	| cart cashier |
	cart := factory createCart.
	cart add: factory itemSellByTheStore.

	cashier := factory createCashierWith: salesBook .

	self 
		should: [cashier checkout: cart on: factory expiratedCreditCard .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cannotCheckoutWithAnExpiredCardErrorDescription.
			self assert: salesBook isEmpty ].
	! !

!CashierTest methodsFor: 'test' stamp: 'DB 6/14/2021 20:00:02'!
test04
	
	| cart cashier |
	cart := factory createCart.
	cart add: factory itemSellByTheStore.

	cashier := factory createCashierWith: MerchantProcessorWithoutFunds new and: salesBook .

	self 
		should: [cashier checkout: cart on: factory validCreditCard .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessor withoutFundsErrorDescription.
			self assert: salesBook isEmpty ].
	! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 18:47:02'!
setUp

	factory := StoreTestObjectsFactory new.
	

 

	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 18:49:36'!
test01CannotCreateACreditCardWithAnInvalidCreditCardNumber


	self should: [CreditCard number: factory invalidCreditCardNumber owner: factory validOwner expiration: factory validExpirationDate.] 
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidCreditCardNumberErrorDescription.
	
	
	
	
	

 

	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:39:36'!
test02CannotCreateACreditCardWithAnInvalidCreditCardOwner


	self should: [CreditCard number: factory validCreditCardNumber owner: factory invalidOwner expiration: factory validExpirationDate.] 
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidCreditCardOwnerErrorDescription.
	
	
	
	
	

 

	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:12:08'!
test03

	| cc |
	cc := CreditCard number: factory validCreditCardNumber owner: factory validOwner expiration: factory validExpirationDate.
	
	self deny: (cc isExpiredOn: factory today).
	
	
	
	
	

 

	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:13:43'!
test04

	| cc |
	cc := CreditCard number: factory validCreditCardNumber owner: factory validOwner expiration: factory expiredDate.
	
	self assert: (cc isExpiredOn: factory today).
	
	
	
	
	

 

	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'DB 6/10/2021 20:46:55'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'DB 6/10/2021 19:49:45'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ].! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'total' stamp: 'DB 6/10/2021 20:50:43'!
total
	
	^items sum: [:anItem | catalog at: anItem]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook clock merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'DB 6/14/2021 19:26:22'!
checkout: aCart on: creditCard   
	
	aCart isEmpty ifTrue: [^self error: self class cannotCheckoutAnEmptyCartErrorDescription].
	
	(creditCard isExpiredOn: clock today) ifTrue: [^self error: self class cannotCheckoutWithAnExpiredCardErrorDescription].
	
	merchantProcessor process: aCart total on: creditCard.
	
	salesBook add: aCart total.! !

!Cashier methodsFor: 'checkout' stamp: 'DB 6/13/2021 20:21:51'!
expirationDateFrom: strExpirationDate

	^ Month month: (strExpirationDate copyFrom: 1  to: 2) asNumber year: (strExpirationDate copyFrom: 3 to: 6) asNumber! !


!Cashier methodsFor: 'initialization' stamp: 'DB 6/13/2021 21:30:02'!
initializeWith: aSalesBook clock: aClock processingWith: aMerchantProcessor  

	salesBook := aSalesBook.
	clock := aClock.
	merchantProcessor := aMerchantProcessor! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'DB 6/13/2021 21:28:54'!
with: aSalesBook clock: aClock processingWith: merchantProcessor  
	
	^self new initializeWith: aSalesBook clock: aClock processingWith: merchantProcessor! !


!Cashier class methodsFor: 'errors' stamp: 'DB 6/10/2021 20:22:55'!
cannotCheckoutAnEmptyCartErrorDescription
	^'cannot check out an empty cart'! !

!Cashier class methodsFor: 'errors' stamp: 'DB 6/13/2021 21:03:32'!
cannotCheckoutFromAnInvalidCreditCardNumberErrorDescription
	^'cannot checkout from an invalid credit card number'! !

!Cashier class methodsFor: 'errors' stamp: 'DB 6/13/2021 20:48:25'!
cannotCheckoutFromAnInvalidNameErrorDescription
	^'cannot check out form an invalid name'! !

!Cashier class methodsFor: 'errors' stamp: 'DB 6/13/2021 21:10:25'!
cannotCheckoutWithAnExpiredCardErrorDescription
	^'cannto pay with an expired card'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber creditCardOwner expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'DB 6/14/2021 19:43:37'!
initializeWith: aCreditCardNumber owner: aCreditCardOwner expiration: anExpirationDate 
	
	creditCardNumber := aCreditCardNumber.
	creditCardOwner := aCreditCardOwner.
	expirationDate := anExpirationDate.! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:43:37'!
isExpiredOn: aDate 
	^expirationDate start < aDate start! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 18:50:12'!
invalidCreditCardNumberErrorDescription
	^'invalid credit card number'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 18:57:49'!
invalidCreditCardOwnerErrorDescription
	^'invalid credit card owner'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:07:40'!
number: creditCardNumber owner: creditCardOwner expiration: expirationDate

	creditCardNumber asString size > 16 ifTrue: [self error: self invalidCreditCardNumberErrorDescription].
	creditCardOwner size > 30 ifTrue: [^self error: self invalidCreditCardOwnerErrorDescription].
	
	^CreditCard new initializeWith: creditCardNumber owner: creditCardOwner expiration: expirationDate.	! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:23:41'!
process: anAmoun on: aCreditCard
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'DB 6/13/2021 21:33:14'!
withoutFundsErrorDescription
	^'credit card without funds'! !


!classDefinition: #MerchantProcessorDown category: 'TusLibros'!
MerchantProcessor subclass: #MerchantProcessorDown
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #MerchantProcessorWithoutFunds category: 'TusLibros'!
MerchantProcessor subclass: #MerchantProcessorWithoutFunds
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorWithoutFunds methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:24:15'!
process: anAmoun on: aCreditCard
	
	^self error: MerchantProcessor withoutFundsErrorDescription.! !


!classDefinition: #SuccessfulMerchantProcessor category: 'TusLibros'!
MerchantProcessor subclass: #SuccessfulMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SuccessfulMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:24:20'!
process: anAmoun on: aCreditCard! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'invalid' stamp: 'DB 6/14/2021 18:51:03'!
invalidCreditCardNumber
	^739739177917932792! !

!StoreTestObjectsFactory methodsFor: 'invalid' stamp: 'DB 6/14/2021 19:13:06'!
invalidOwner
	^'jasldfjañldjfaldjfñaljdflñajslñfjñlfs '! !

!StoreTestObjectsFactory methodsFor: 'invalid' stamp: 'DB 6/14/2021 19:35:01'!
priceOFitemSellByTheStore
	^10.! !


!StoreTestObjectsFactory methodsFor: 'valid' stamp: 'DB 6/14/2021 18:58:37'!
validCreditCardNumber
	^7397391779179327.! !

!StoreTestObjectsFactory methodsFor: 'valid' stamp: 'DB 6/14/2021 18:54:49'!
validExpirationDate
	
	^Month month: 6 year: 2030 ! !

!StoreTestObjectsFactory methodsFor: 'valid' stamp: 'DB 6/14/2021 19:07:30'!
validOwner
	^'Cosme Fulanito'! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:34:02'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:59:29'!
createCashierWith: salesBook 
	
	^self createCashierWith: SuccessfulMerchantProcessor new and: salesBook.! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:57:06'!
createCashierWith: aMerchantProcessor and: salesBook
	
	^Cashier with: salesBook clock: (Stubclock of: (Month month: 06 year: 2021)) processingWith: aMerchantProcessor.! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:34:23'!
defaultCatalog
	
	| catalogue |
	catalogue := Dictionary new.
	catalogue at: self itemSellByTheStore put: self priceOFitemSellByTheStore.
	^catalogue.! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:40:52'!
expiratedCreditCard
	^CreditCard number: self validCreditCardNumber owner: self validOwner  expiration: self expiredDate! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:17:45'!
expiredDate
	^Month month: 05 year: 2019! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:34:36'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:34:48'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:10:15'!
today
	^Month month: 06 year: 2021 ! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DB 6/14/2021 19:39:20'!
validCreditCard
	^CreditCard number: self validCreditCardNumber owner: self validOwner expiration: self validExpirationDate .! !


!classDefinition: #Stubclock category: 'TusLibros'!
Object subclass: #Stubclock
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Stubclock methodsFor: 'initialization' stamp: 'DB 6/13/2021 20:26:03'!
initializeOf: aNow 
	
	today := aNow.! !


!Stubclock methodsFor: 'as yet unclassified' stamp: 'DB 6/13/2021 20:26:50'!
today

	^today! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Stubclock class' category: 'TusLibros'!
Stubclock class
	instanceVariableNames: 'now_CHANGE_ME today'!

!Stubclock class methodsFor: 'as yet unclassified' stamp: 'DB 6/13/2021 20:25:45'!
of: now
	^self new initializeOf: now! !

