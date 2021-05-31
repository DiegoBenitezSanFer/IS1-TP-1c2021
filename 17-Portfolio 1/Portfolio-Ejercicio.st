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

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'DB 5/25/2021 12:37:25'!
test06HasRegistrerOfAPortfoloTree

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

!PortfolioTest methodsFor: 'add restrictions' stamp: 'DB 5/25/2021 12:39:29'!
test12TwoPortfolioWithTheSameAccountCannotBeAdded

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

!PortfolioTest methodsFor: 'add restrictions' stamp: 'DB 5/25/2021 12:41:51'!
test13CannotAddAnAccounInTheRoottIfThereExistAsALeaf

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

!PortfolioTest methodsFor: 'add restrictions' stamp: 'DB 5/25/2021 12:43:17'!
test14CannotDuplicateALeaf

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

!PortfolioTest methodsFor: 'add restrictions' stamp: 'DB 5/25/2021 12:46:34'!
test15CannotDuplicateALeafInADeepTree

	| p1 p2 p3 a b |
		
	p1 := Portfolio new.
	p2 := Portfolio new.
	p3 := Portfolio  new.
	
	a := ReceptiveAccount new.
	b := ReceptiveAccount new.
	
	p2 add: a.
	p2 add: p3.
	p1 add: b.
	p1 add: p2.
	
	"P1
	  |_ P2
	  	|_ P3 
	  	|_A
	  |_ B"
	  
	self 
		should: [p3 add: b ] 
		raise: Error  
		withMessageText: [Portfolio cannotAddAccountErrorDescription.]
		! !

!PortfolioTest methodsFor: 'add restrictions' stamp: 'DB 5/25/2021 12:50:18'!
test16CannotAddAPortfolioWithAnExistingAccount

	| p1 p2 p3 a b p4 |
		
	p1 := Portfolio new.
	p2 := Portfolio new.
	p3 := Portfolio new.
	p4 := Portfolio new.
	
	a := ReceptiveAccount new.
	b := ReceptiveAccount new.
	
	p2 add: a.
	p2 add: p3.
	p1 add: b.
	p1 add: p2.
	
	p4 add: b.
	
	"P1                  P4
	  |_ P2              |_ B
	  	|_ P3 
	  	|_A
	  |_ B
	"
		
	self 
		should: [p3 add: p4 ] 
		raise: Error  
		withMessageText: [Portfolio cannotAddAccountErrorDescription.]
		! !

!PortfolioTest methodsFor: 'add restrictions' stamp: 'DB 5/25/2021 12:52:20'!
test17CannotAddAPortfolioWithAnExistingAccountInTheMiddleOfTheTree

	| p1 p2 p3 a b p4 |
		
	p1 := Portfolio new.
	p2 := Portfolio new.
	p3 := Portfolio new.
	p4 := Portfolio new.
	
	a := ReceptiveAccount new.
	b := ReceptiveAccount new.
	
	p1 add: p3.
	p1 add: p2.
	p2 add: a.
	p3 add: b.
	p4 add: p3.
	
	"P1                P4
	  |_ P2           \_ B
	  	|_ P3 
	  	|_A
	  |_ B
	"
	  
		
	self 
		should: [p2 add: p4 ] 
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

!PortfolioTest methodsFor: 'balance' stamp: 'DB 5/25/2021 12:31:33'!
test03BalanceOfAPortfolioTree

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


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'initialization' stamp: 'DB 5/24/2021 21:38:06'!
initialize

	parents := OrderedCollection new.! !


!Account methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 12:04:28'!
allLeaves

	self subclassResponsibility ! !

!Account methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 12:03:23'!
isLeaf

	self subclassResponsibility ! !

!Account methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 11:51:20'!
isRoot

	^parents isEmpty ! !

!Account methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 12:03:49'!
leaves: leafContainer

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'DB 5/25/2021 12:57:17'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'testing' stamp: 'DB 5/25/2021 12:02:30'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'DB 5/25/2021 12:14:37'!
transactions

	self subclassResponsibility 
	! !

!Account methodsFor: 'transactions' stamp: 'DB 5/25/2021 12:15:03'!
transactions: transactionContainer

	self subclassResponsibility ! !


!Account methodsFor: 'adding' stamp: 'DB 5/24/2021 19:31:56'!
isChildOf: aParent

	parents add: aParent 	! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'DB 5/24/2021 21:38:43'!
initialize

	accounts := OrderedCollection new.
	super initialize 
	! !


!Portfolio methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 12:55:02'!
allLeaves

	| leafContainer |
	
	leafContainer := OrderedCollection new.
	self allRoots  do: [ :aRoot | aRoot leaves: leafContainer].
	
	^leafContainer 
! !

!Portfolio methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 11:13:13'!
allRoots

	| rootContainers |
	rootContainers := OrderedCollection new.
	
	self roots: rootContainers.
	
	^rootContainers 
! !

!Portfolio methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 11:59:55'!
assertNotDuplicatedAssetOrCycles: anAsset

	| anAssetLeaves |
	anAssetLeaves _ anAsset allLeaves.
	
	(self allLeaves anySatisfy: [:leaf | anAssetLeaves includes: leaf]) ifTrue: [self error: self class cannotAddAccountErrorDescription]! !

!Portfolio methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 12:03:04'!
isLeaf

	^accounts isEmpty ! !

!Portfolio methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 11:33:14'!
leaves: leafContainer

	(self isLeaf) ifTrue: [leafContainer add: self] ifFalse: [ accounts do: [:aChild | aChild leaves: leafContainer ]]
	! !

!Portfolio methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 11:50:46'!
roots: rootContainer

	(self isRoot) ifTrue: [rootContainer add: self] ifFalse: [ parents do: [:aParent | aParent roots: rootContainer] ]
	! !


!Portfolio methodsFor: 'adding' stamp: 'DB 5/25/2021 12:01:54'!
add: anAccount

	self assertNotDuplicatedAssetOrCycles: anAccount.	

	self isFatherOf: anAccount.
	anAccount isChildOf: self.! !

!Portfolio methodsFor: 'adding' stamp: 'DB 5/25/2021 11:45:46'!
isFatherOf: anAsset

	^ accounts add: anAsset! !


!Portfolio methodsFor: 'testing' stamp: 'DB 5/25/2021 12:55:27'!
hasRegistered: aTransaction

	^accounts anySatisfy: [:account | account hasRegistered: aTransaction].! !


!Portfolio methodsFor: 'transactions' stamp: 'DB 5/25/2021 12:10:06'!
transactions
	
	| transactions |
	transactions := OrderedCollection new.
	accounts do: [	:asset | asset transactions: transactions].
	^transactions! !

!Portfolio methodsFor: 'transactions' stamp: 'DB 5/25/2021 12:11:57'!
transactions: transactionContainer

	accounts do: [	:asset | asset transactions: transactionContainer].
	! !


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
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'DB 5/25/2021 12:29:55'!
initialize

	transactions := OrderedCollection new.
	super initialize
	! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'DB 5/25/2021 12:12:59'!
transactions: transactionContainer

	^ transactionContainer addAll: self transactions! !


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


!ReceptiveAccount methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 12:56:15'!
allLeaves

	^ OrderedCollection with: self ! !

!ReceptiveAccount methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 11:29:20'!
isLeaf
	^true! !

!ReceptiveAccount methodsFor: 'assertions - private' stamp: 'DB 5/25/2021 11:39:33'!
leaves: leafContainer

	leafContainer add: self
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
