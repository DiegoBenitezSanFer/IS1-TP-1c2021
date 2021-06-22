!classDefinition: #CartTest category: 'TusLibros-Tests'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros-Tests'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CashierTest methodsFor: 'tests' stamp: 'lilmonk3y 6/22/2021 19:39:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook
			for: testObjectsFactory validUserName ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'lilmonk3y 6/22/2021 19:40:04'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new
		for: testObjectsFactory validUserName .
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'lilmonk3y 6/22/2021 19:40:13'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook 
				for: testObjectsFactory validUserName ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'lilmonk3y 6/22/2021 19:40:25'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validUserName .
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'lilmonk3y 6/22/2021 19:40:35'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook 
		for: testObjectsFactory validUserName .
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'lilmonk3y 6/22/2021 19:40:50'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validUserName .
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros-Tests'!
TestCase subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'lilmonk3y 6/20/2021 18:27:42'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'lilmonk3y 6/20/2021 18:29:41'!
initializeBehavingLike: aDebitBehaviour
	debitBehavior  := aDebitBehaviour ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros-Tests'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'lilmonk3y 6/20/2021 18:29:09'!
withDebitBehaviour: aDebitBehaviour
	^ self new initializeBehavingLike: aDebitBehaviour ! !


!classDefinition: #StoreTest category: 'TusLibros-Tests'!
TestCase subclass: #StoreTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!StoreTest methodsFor: 'basic-protocol' stamp: 'lilmonk3y 6/21/2021 10:44:49'!
test01UserNotValid

	| store userName userPassword |
	userName _ factory notValidUserName.
	userPassword _ 'a password'.
	store _ factory createStore.
	
 	self should: [store createCartFor: userName with: userPassword] 
		raise: Error - MessageNotUnderstood withMessageText: Store userNotValidErrorDescription.! !

!StoreTest methodsFor: 'basic-protocol' stamp: 'lilmonk3y 6/21/2021 12:56:26'!
test02CreateCartForValidUser

	| store userName userPassword cartId |
	userName _ factory validUserName.
	userPassword _ 'a password'.
	store _ factory createStore.
	
 	cartId _ store createCartFor: userName with: userPassword.
	
	self assert: (store listCart: cartId) isEmpty! !

!StoreTest methodsFor: 'basic-protocol' stamp: 'lilmonk3y 6/22/2021 20:34:40'!
test03AddAnItemToACart

	| store userName userPassword cartId books isbn |
	userName _ factory validUserName.
	userPassword _ 'a password'.
	store _ factory createStore.
	cartId _ store createCartFor: userName with: userPassword.
	isbn _ factory itemSellByTheStore.
	
	store addToCart: cartId bookNumbered: isbn quantity: 2.
	
	books _ store listCart: cartId.
	self assert: books size equals: 2.
	self assert: ( books includes: isbn).
	self assert: (books occurrencesOf: isbn) equals: 2.

	! !

!StoreTest methodsFor: 'basic-protocol' stamp: 'lilmonk3y 6/21/2021 10:28:27'!
test04CheckOutACart

	| store userName userPassword cartId isbn sales cartItems |
	userName _ factory validUserName.
	userPassword _ 'a password'.
	isbn _ factory itemSellByTheStore.
	store _ factory createStore.
	cartId _ store createCartFor: userName with: userPassword.
	store addToCart: cartId bookNumbered: isbn quantity: 2.
	cartItems _ store listCart: cartId. 
	
	store checkOut: cartId on: factory notExpiredCreditCard .
	
	sales _ store listPurcheses: userName authBy: userPassword .
	self assert: 1 equals: sales size.
	self assert: cartItems equals: (sales first items).

	! !


!StoreTest methodsFor: 'validations-on-model' stamp: 'lilmonk3y 6/22/2021 20:36:29'!
test05cannotAddAnItemToaCartAlreadyCheckouted
	
	| store userName userPassword cartId isbn |
	userName _ factory validUserName.
	userPassword _ 'a password'.
	isbn _ factory itemSellByTheStore.
	store _ factory createStore.
	cartId _ store createCartFor: userName with: userPassword.
	store addToCart: cartId bookNumbered: isbn quantity: 2.
	store checkOut: cartId on: factory notExpiredCreditCard.
	
	self should: [store addToCart: cartId bookNumbered: isbn quantity: 1] 
		raise: Error 
		withMessageText: Store thereIsNotAnActiveCartForTheUserErrorDescription
	

	! !

!StoreTest methodsFor: 'validations-on-model' stamp: 'lilmonk3y 6/22/2021 20:37:45'!
test06cannotCheckOutAnAlreadyCheckoutedCart
	
	| store userName userPassword cartId isbn |
	userName _ factory validUserName.
	userPassword _ 'a password'.
	isbn _ factory itemSellByTheStore.
	store _ factory createStore.
	cartId _ store createCartFor: userName with: userPassword.
	store addToCart: cartId bookNumbered: isbn quantity: 2.
	store checkOut: cartId on: factory notExpiredCreditCard.
	
	self should: [store checkOut: cartId on: factory notExpiredCreditCard] 
		raise: Error 
		withMessageText: Store thereIsNotAnActiveCartForTheUserErrorDescription
	

	! !

!StoreTest methodsFor: 'validations-on-model' stamp: 'lilmonk3y 6/22/2021 20:38:49'!
test07cannotListPurchesesOfAUserNotAuthenticated
	
	| store userName userPassword  |
	userName _ factory notValidUserName .
	userPassword _ 'a password'.
	store _ factory createStore.
	
	self should: [store listPurcheses: userName authBy: userPassword] 
		raise: Error 
		withMessageText: Store userNotValidErrorDescription 
	

	! !

!StoreTest methodsFor: 'validations-on-model' stamp: 'lilmonk3y 6/22/2021 20:39:37'!
test08createCartOfAUserWithAnActiveCartReturnsANewCart
	
	| store userName userPassword  actualCartId expectedCartId |
	userName _ factory validUserName .
	userPassword _ 'a password'.
	store _ factory createStore.
	expectedCartId _ store createCartFor: userName with: userPassword.
	
	actualCartId _ store createCartFor: userName with: userPassword.
	
	self deny: expectedCartId = actualCartId
	
	

	! !


!StoreTest methodsFor: 'time-modeling' stamp: 'lilmonk3y 6/22/2021 20:42:09'!
test09cannotAddAnItemToACartThatWasNotUsedInTheLast30Minutes
	
	| store userName userPassword  cartId clock isbn |
	userName _ factory validUserName .
	userPassword _ 'a password'.
	isbn _ factory itemSellByTheStore.
	clock _ ClockDouble timedAt: factory today.
	store _ factory createStoreWith: clock.
	cartId _ store createCartFor: userName with: userPassword.
	
	clock advanceMinutesBy: 35.
	
	self should: [store addToCart: cartId bookNumbered: isbn quantity: 2] 
		raise: Error 
		withMessageText: Store cartInactivatedDueNotUsedForMoreThanThirtyMinutesErrorDescription
	
	

	! !

!StoreTest methodsFor: 'time-modeling' stamp: 'lilmonk3y 6/22/2021 20:42:32'!
test10cannotCheckoutACartThatWasNotUsedInTheLast30Minutes
	
	| store userName userPassword  cartId clock isbn |
	userName _ factory validUserName .
	userPassword _ 'a password'.
	isbn _ factory itemSellByTheStore.
	clock _ ClockDouble timedAt: factory today.
	store _ factory createStoreWith: clock.
	cartId _ store createCartFor: userName with: userPassword.
	store addToCart: cartId bookNumbered: isbn quantity: 2.
	
	clock advanceMinutesBy: 35.
	
	self should: [store checkOut: cartId on: factory notExpiredCreditCard ] 
		raise: Error 
		withMessageText: Store cartInactivatedDueNotUsedForMoreThanThirtyMinutesErrorDescription
	
	

	! !

!StoreTest methodsFor: 'time-modeling' stamp: 'lilmonk3y 6/22/2021 20:43:17'!
test11cannotListTheItemsOfACartThatWasNotUsedInTheLast30Minutes
	
	| store userName userPassword  cartId clock  |
	userName _ factory validUserName .
	userPassword _ 'a password'.
	clock _ ClockDouble timedAt: factory today.
	store _ factory createStoreWith: clock.
	cartId _ store createCartFor: userName with: userPassword.
	
	clock advanceMinutesBy: 35.
	
	self should: [store listCart: cartId] 
		raise: Error 
		withMessageText: Store cartInactivatedDueNotUsedForMoreThanThirtyMinutesErrorDescription
	
	

	! !

!StoreTest methodsFor: 'time-modeling' stamp: 'lilmonk3y 6/22/2021 20:44:01'!
test12multipleAccionsOnACartExtendsItsLifeTime
	
	| store userName userPassword  cartId clock  cartItems sales |
	userName _ factory validUserName .
	userPassword _ 'a password'.
	clock _ ClockDouble timedAt: factory today.
	store _ factory createStoreWith: clock.
	cartId _ store createCartFor: userName with: userPassword.

	clock advanceMinutesBy: 29.
	store listCart: cartId.
	clock advanceMinutesBy: 29.
	store addToCart: cartId bookNumbered: factory itemSellByTheStore quantity: 2.
	cartItems _ store listCart: cartId. 
	clock advanceMinutesBy: 29.
	store checkOut: cartId on: factory notExpiredCreditCard.
	
	sales _ store listPurcheses: userName authBy: userPassword .
	self assert: 1 equals: sales size.
	self assert: cartItems equals: (sales first items).
	
	

	! !


!StoreTest methodsFor: 'checkout-more-than-one' stamp: 'lilmonk3y 6/22/2021 20:44:34'!
test13allowMoreThanOneActiveUserInStore
	
	| store firstUserName firstUserPassword   cartId  anotherCartId firstUserPurcheses secondUserName secondUserPassword secondUserPurcheses |
	store _ factory createStore.
	
	firstUserName _ factory validUserName .
	firstUserPassword _ 'a password'.
	cartId _ store createCartFor: firstUserName with: firstUserPassword.
	store addToCart: cartId bookNumbered: factory itemSellByTheStore quantity: 2.
	store checkOut: cartId on: factory notExpiredCreditCard.
	
	secondUserName _ factory aSecondValidUserName.
	secondUserPassword _ 'another password'.
	anotherCartId _ store createCartFor: secondUserName with: secondUserPassword.
	store addToCart: anotherCartId bookNumbered: factory anotherItemSellByTheStore quantity: 5.
	store checkOut: anotherCartId on: factory notExpiredCreditCard.
	
	firstUserPurcheses _ store listPurcheses: firstUserName authBy: firstUserPassword.
	secondUserPurcheses _ store listPurcheses: secondUserName authBy: secondUserPassword.
	self deny: firstUserPurcheses = secondUserPurcheses.
	
	self assert: 1 equals: firstUserPurcheses size.
	self assert: (firstUserPurcheses first isOf: firstUserName).
	
	self assert: 1 equals: secondUserPurcheses size.
	self assert: (secondUserPurcheses first isOf: secondUserName ).
	
	

	! !


!StoreTest methodsFor: 'setUp/tearDown' stamp: 'lilmonk3y 6/20/2021 17:35:46'!
setUp
	factory _ StoreTestObjectsFactory new.! !


!classDefinition: #ClockDouble category: 'TusLibros-Tests'!
Object subclass: #ClockDouble
	instanceVariableNames: 'dateAndTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!ClockDouble methodsFor: 'initialization' stamp: 'lilmonk3y 6/21/2021 10:57:33'!
initializeTimedAt: aDateAndTime 

	dateAndTime := aDateAndTime.! !


!ClockDouble methodsFor: 'time-model' stamp: 'lilmonk3y 6/21/2021 11:53:54'!
advanceMinutesBy: anAmountOfMinutes 

	dateAndTime _ dateAndTime + (Duration minutes: anAmountOfMinutes)! !

!ClockDouble methodsFor: 'time-model' stamp: 'lilmonk3y 6/21/2021 11:45:55'!
today
	^dateAndTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClockDouble class' category: 'TusLibros-Tests'!
ClockDouble class
	instanceVariableNames: ''!

!ClockDouble class methodsFor: 'instance creation' stamp: 'lilmonk3y 6/21/2021 10:57:19'!
timedAt: aDateAndTime 
	^ self new initializeTimedAt: aDateAndTime.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros-Tests'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today validUsers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'lilmonk3y 6/22/2021 19:23:44'!
anotherItemSellByTheStore
	
	^ 'another validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'lilmonk3y 6/22/2021 19:24:15'!
anotherItemSellByTheStorePrice
	
	^50! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'lilmonk3y 6/22/2021 19:25:10'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice ;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'lilmonk3y 6/22/2021 19:19:33'!
initialize

	today := DateAndTime now.
	
	validUsers := OrderedCollection with: (self validUserName) with: (self aSecondValidUserName).! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'not-clasified' stamp: 'lilmonk3y 6/22/2021 19:19:57'!
aSecondValidUserName
	^  'Nico'! !

!StoreTestObjectsFactory methodsFor: 'not-clasified' stamp: 'lilmonk3y 6/22/2021 19:17:40'!
authenticate: aUserName using: aUserPassword 
	^ validUsers includes: aUserName ! !

!StoreTestObjectsFactory methodsFor: 'not-clasified' stamp: 'lilmonk3y 6/21/2021 10:59:27'!
createStore
	^ self createStoreWith: self defaultClock.! !

!StoreTestObjectsFactory methodsFor: 'not-clasified' stamp: 'lilmonk3y 6/21/2021 10:58:49'!
createStoreWith: aClock
	^ Store authBy: self withCatalogue: self defaultCatalog withMerchantProcessor: self defaultMerchantProcessor salesbook: OrderedCollection new withClock: aClock.! !

!StoreTestObjectsFactory methodsFor: 'not-clasified' stamp: 'lilmonk3y 6/20/2021 19:45:32'!
createStoreWithSalesBook: aSalesBook
	^ Store authBy: self withCatalogue: self defaultCatalog withMerchantProcessor: self defaultMerchantProcessor salesbook: aSalesBook .! !

!StoreTestObjectsFactory methodsFor: 'not-clasified' stamp: 'lilmonk3y 6/21/2021 11:48:17'!
defaultClock
	^ ClockDouble timedAt: self today! !

!StoreTestObjectsFactory methodsFor: 'not-clasified' stamp: 'lilmonk3y 6/20/2021 18:32:58'!
defaultMerchantProcessor
	^ MerchantProcessorSimulator withDebitBehaviour: [:amount :creditCard | ]! !

!StoreTestObjectsFactory methodsFor: 'not-clasified' stamp: 'lilmonk3y 6/21/2021 10:43:50'!
notValidUserName
	^  'Mao'! !

!StoreTestObjectsFactory methodsFor: 'not-clasified' stamp: 'lilmonk3y 6/20/2021 17:42:14'!
validUserName
	^  'Hernan'! !
