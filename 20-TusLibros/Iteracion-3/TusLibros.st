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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'lilmonk3y 6/21/2021 13:05:38'!
items

	^items! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: 'TusLibros'!
Object subclass: #CartSession
	instanceVariableNames: 'cart clock lastUpdate userName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!CartSession methodsFor: 'dispatching' stamp: 'lilmonk3y 6/22/2021 20:09:58'!
doesNotUnderstand: aMessage
	self validateCartSessionLength.
	
	lastUpdate _ clock today.
	
	[^aMessage sendTo: cart] on: MessageNotUnderstood do: [super doesNotUnderstand: aMessage ].
	! !


!CartSession methodsFor: 'validations' stamp: 'lilmonk3y 6/22/2021 20:09:07'!
validateCartSessionLength

	^ lastUpdate + 30 minutes > clock today ifFalse: [self error: Store cartInactivatedDueNotUsedForMoreThanThirtyMinutesErrorDescription]! !


!CartSession methodsFor: 'initialization' stamp: 'lilmonk3y 6/22/2021 19:48:55'!
initializeClock: aClock cart: aCart of: aUserName 
	clock := aClock.
	cart:= aCart.
	userName := aUserName.
	lastUpdate := clock today.! !

!CartSession methodsFor: 'initialization' stamp: 'lilmonk3y 6/22/2021 19:49:50'!
userName
	^ userName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 6/22/2021 20:03:29'!
of: aUserName validatingWith: aClock for: aCart 
	^self new initializeClock: aClock cart: aCart of: aUserName ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total userName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'lilmonk3y 6/22/2021 19:34:30'!
createSale

	^ Sale for: userName of: total items: (cart items)  
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'lilmonk3y 6/22/2021 19:31:42'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook for: aUserName 
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	userName := aUserName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'lilmonk3y 6/22/2021 19:31:21'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook for: aUserName 
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook for: aUserName ! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items userName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'accessing' stamp: 'lilmonk3y 6/21/2021 10:21:18'!
items
	^ items ! !

!Sale methodsFor: 'accessing' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'lilmonk3y 6/22/2021 19:36:05'!
initializeTotal: aTotal items: aListOfItems for: aUserName  
	
	userName := aUserName.
	total := aTotal.
	items := aListOfItems.! !


!Sale methodsFor: 'filtering' stamp: 'lilmonk3y 6/22/2021 19:41:47'!
isOf: aUserName
	^ userName  = aUserName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'lilmonk3y 6/22/2021 19:35:44'!
for: aUserName of: aTotal items: aListOfItems 

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal items: aListOfItems for: aUserName ! !


!classDefinition: #Store category: 'TusLibros'!
Object subclass: #Store
	instanceVariableNames: 'authService catalogue cartSession merchantProcessor salesbook clock nextId carts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'validations' stamp: 'lilmonk3y 6/22/2021 20:18:45'!
validateUserCredentials: aUserName with: aUserPassword

	^ (authService authenticate: aUserName using: aUserPassword) ifFalse: [self error: self class userNotValidErrorDescription]! !


!Store methodsFor: 'initialization' stamp: 'lilmonk3y 6/22/2021 20:21:45'!
initializeWith: aUserAuth catalogue: aCatalogue on: aMerchantProcessorSimulator registerOn: aSalesBook withClock: aClock   
	authService := aUserAuth.
	catalogue := aCatalogue.
	merchantProcessor := aMerchantProcessorSimulator.
	salesbook := aSalesBook.
	clock := aClock.
	
	carts := Dictionary new.
	nextId := 0! !


!Store methodsFor: 'store-protocol' stamp: 'lilmonk3y 6/22/2021 20:20:35'!
addToCart: aCartId bookNumbered: item quantity: amountOfItems
	
	(self getCartForId: aCartId) add: amountOfItems of: item.! !

!Store methodsFor: 'store-protocol' stamp: 'lilmonk3y 6/22/2021 20:22:40'!
checkOut: cartId on: aCreditCard 
	
	| cart |
	cart _ self getCartForId: cartId.
	
	(Cashier toCheckout: cart charging: aCreditCard throught: merchantProcessor on: (clock today) registeringOn: salesbook for: (cart userName)) checkOut.
	
	carts removeKey: cartId
	! !

!Store methodsFor: 'store-protocol' stamp: 'lilmonk3y 6/22/2021 20:19:23'!
createCartFor: aUserName with: aUserPassword 
	| id |
	self validateUserCredentials: aUserName with: aUserPassword.	
	
	id _ self newCartId.
	carts at: id put: (CartSession of: aUserName validatingWith: clock  for: (Cart acceptingItemsOf: catalogue)). 
	^id! !

!Store methodsFor: 'store-protocol' stamp: 'lilmonk3y 6/21/2021 13:54:05'!
listCart: aCartId 

	^ (self getCartForId: aCartId) items.! !

!Store methodsFor: 'store-protocol' stamp: 'lilmonk3y 6/22/2021 20:22:50'!
listPurcheses: aUserName authBy: aUserPassword

	self validateUserCredentials: aUserName with: aUserPassword. 
	^ salesbook select: [:sale | sale isOf: aUserName] ! !


!Store methodsFor: 'operations-private' stamp: 'lilmonk3y 6/22/2021 19:03:56'!
getCartForId: aCartId

	^ carts at: aCartId ifAbsent: [self error: self class thereIsNotAnActiveCartForTheUserErrorDescription]! !

!Store methodsFor: 'operations-private' stamp: 'lilmonk3y 6/21/2021 13:15:02'!
newCartId
	nextId _ nextId + 1.
	^nextId
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: 'TusLibros'!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'error-descriptions' stamp: 'lilmonk3y 6/21/2021 11:46:58'!
cartInactivatedDueNotUsedForMoreThanThirtyMinutesErrorDescription
	^ 'cart Inactivated Due Not Used For More Than Thirty Minutes'! !

!Store class methodsFor: 'error-descriptions' stamp: 'lilmonk3y 6/22/2021 18:50:24'!
thereIsNotAnActiveCartForTheUserErrorDescription
	^ 'cart not found'! !

!Store class methodsFor: 'error-descriptions' stamp: 'lilmonk3y 6/17/2021 20:59:58'!
userNotValidErrorDescription
	^ 'cannot authenticate user'! !


!Store class methodsFor: 'initialization' stamp: 'lilmonk3y 6/22/2021 20:15:07'!
authBy: anAuthService withCatalogue: aCatalogue withMerchantProcessor: aMerchantProcessor salesbook: aSalesBook withClock: aClock   
	^ self new initializeWith: anAuthService catalogue: aCatalogue on: aMerchantProcessor registerOn: aSalesBook withClock: aClock  ! !
