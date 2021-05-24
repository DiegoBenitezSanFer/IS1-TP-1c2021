!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'DB 5/17/2021 21:55:29'!
test04EmptyPortfolioHaveNotAnyTransaction

	| portfolio account deposit |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.

	self deny: (portfolio hasRegistered: deposit).

! !

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'DB 5/17/2021 21:56:21'!
test05PortfolioWithAnReceptiveAccountHaveAccountTransaction

	| portfolio account deposit |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio add: account.

	self assert: (portfolio hasRegistered: deposit).

! !

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'DB 5/20/2021 20:14:05'!
test06

	| portfolio account deposit child |
	
	portfolio := Portfolio new.
	child := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	child add: account.
	portfolio add: child.
	
	self assert: (portfolio hasRegistered: deposit).

! !


!PortfolioTest methodsFor: 'transactions' stamp: 'DB 5/20/2021 20:55:47'!
test07EmptyPortfolioReturnsEmptyTransactions
	
	self assert: (Portfolio new transactions) isEmpty.

! !

!PortfolioTest methodsFor: 'transactions' stamp: 'DB 5/20/2021 20:38:53'!
test08PortfolioWithAnAccountIncludesDepositTransaction

	| portfolio account deposit |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.

	portfolio add: account.
	
	self assert: (portfolio transactions) includes: deposit.

! !

!PortfolioTest methodsFor: 'transactions' stamp: 'DB 5/20/2021 20:40:21'!
test09PortfolioWithMoreThanOneAccountMustIncludesAllTransactions

	| portfolio account1 account2 deposit1 deposit2 portfolio1 portfolio2 |
	
	portfolio := Portfolio new.
	
	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	deposit1 := Deposit register: 100 on: account1.
	portfolio1 add: account1.
	
	portfolio2 := Portfolio new.
	account2 := ReceptiveAccount new.
	deposit2 := Deposit register: 100 on: account2.
	portfolio2 add: account2.

	portfolio add: portfolio1.
	portfolio add: portfolio2.
	
	self assert: (portfolio transactions) includes: deposit1.
	self assert: (portfolio transactions) includes: deposit2.

! !


!PortfolioTest methodsFor: 'add restrictions' stamp: 'DB 5/23/2021 18:43:36'!
test10CannotAddSameAccountTwice

	| portfolio account |
		
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio add: account.
	
	self 
		should: [portfolio add: account ] 
		raise: Error  
		withMessageText: [Portfolio cannotAddAccountErrorDescription.]
		! !

!PortfolioTest methodsFor: 'add restrictions' stamp: 'DB 5/23/2021 19:30:07'!
test11CyclesCannotBeGenerated

	| portfolio1 portfolio2   |
		
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio1 add: portfolio2 .
		
	self 
		should: [portfolio2 add: portfolio1 ] 
		raise: Error  
		withMessageText: [Portfolio cannotAddAccountErrorDescription.]
		! !

!PortfolioTest methodsFor: 'add restrictions' stamp: 'DB 5/23/2021 20:43:46'!
test12

	| portfolio1 portfolio2 account |
		
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.

	portfolio1 add: account.
	portfolio2 add: account.
	
	"P1  		P2
	 |_ A 		|_ A
	"
		
	self 
		should: [portfolio1 add: portfolio2 ] 
		raise: Error  
		withMessageText: [Portfolio cannotAddAccountErrorDescription.]
		! !

!PortfolioTest methodsFor: 'add restrictions' stamp: 'DB 5/23/2021 20:41:36'!
test13

	| portfolio1 portfolio2 account |
		
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	
	account := ReceptiveAccount new.
	portfolio2 add: account.

	portfolio1 add: portfolio2.
	
	"P1 
	  |_ P2 
		|_A"
	
		
	self 
		should: [portfolio1 add: account ] 
		raise: Error  
		withMessageText: [Portfolio cannotAddAccountErrorDescription.]
		! !

!PortfolioTest methodsFor: 'add restrictions' stamp: 'DB 5/23/2021 20:48:07'!
test14

	| portfolio1 portfolio2 account |
		
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	
	account := ReceptiveAccount new.
	portfolio1 add: account.

	portfolio1 add: portfolio2.
	
	"P1 
	  |_ P2 
	  |_A"
	
		
	self 
		should: [portfolio2 add: account ] 
		raise: Error  
		withMessageText: [Portfolio cannotAddAccountErrorDescription.]
		! !


!PortfolioTest methodsFor: 'balance' stamp: 'DB 5/17/2021 21:24:34'!
test01PortfolioHaveZeroAsBalanceWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'balance' stamp: 'DB 5/17/2021 21:25:11'!
test02APortfolioWithAnAccountHasTheSameBalance

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account. 
	
	portfolio add: account.

	self assert: 100 equals: (portfolio balance).
! !

!PortfolioTest methodsFor: 'balance' stamp: 'DB 5/17/2021 21:39:01'!
test03

	| portfolio child account |
	
	portfolio := Portfolio new.
	child := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account. 

	child add: account.	
	portfolio add: child.

	self assert: 100 equals: (portfolio balance).

! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'DB 5/17/2021 21:23:41'!
addTo: Balance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'DB 5/17/2021 21:23:15'!
addTo: aBalance

	 ^aBalance + value! !

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'DB 5/17/2021 21:28:38'!
addTo: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Asset category: 'Portfolio-Ejercicio'!
Object subclass: #Asset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Asset methodsFor: 'balance' stamp: 'DB 5/17/2021 21:44:20'!
balance
	self subclassResponsibility ! !


!Asset methodsFor: 'testing' stamp: 'DB 5/23/2021 18:46:52'!
hasRegistered: aTransaction
	self subclassResponsibility ! !


!Asset methodsFor: 'transactions' stamp: 'DB 5/23/2021 18:48:13'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Asset subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'DB 5/23/2021 18:50:27'!
initialize

	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'adding' stamp: 'DB 5/23/2021 20:49:47'!
add: anAsset
	
	(accounts anySatisfy: [:asset | asset anySatisfy: anAsset]) ifTrue: [self error: self class cannotAddAccountErrorDescription].

	(accounts anySatisfy: [:asset | anAsset anySatisfy: asset]) ifTrue: [self error: self class cannotAddAccountErrorDescription].	
	
	(anAsset anySatisfy: self) ifTrue: [self error: self class cannotAddAccountErrorDescription ].
	
	accounts add: anAsset! !

!Portfolio methodsFor: 'adding' stamp: 'DB 5/23/2021 20:00:34'!
anySatisfy: anAsset 

	^(self = anAsset) or: (accounts anySatisfy: [:asset | asset anySatisfy: anAsset] )
	! !


!Portfolio methodsFor: 'testing' stamp: 'DB 5/17/2021 22:00:30'!
hasRegistered: aTransaction

	^accounts anySatisfy: [:account | (account hasRegistered: aTransaction)].! !


!Portfolio methodsFor: 'transactions' stamp: 'DB 5/20/2021 20:35:01'!
transactions
	
	| transactions |
	transactions := OrderedCollection new.
	accounts do: [	:asset | transactions addAll: asset transactions].
	^transactions! !


!Portfolio methodsFor: 'balance' stamp: 'DB 5/23/2021 20:32:58'!
balance

	^accounts sum: [:anAsset | anAsset balance] ifEmpty: [0]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'DB 5/20/2021 21:04:13'!
cannotAddAccountErrorDescription
	^'cannot add account'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Asset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'DB 5/23/2021 20:08:33'!
anySatisfy: anAsset

	^self = anAsset! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'DB 5/17/2021 21:23:56'!
balance

	|balance|
	balance := 0.
	transactions do: [:aTransaction |  balance := aTransaction addTo: balance].
	^balance.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
