!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/30/2021 15:38:04'!
test08AnAccountSendsMoneyToAnotherOne

	| sender receiver |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Transfer register: 100 from: sender to: receiver.
		
	self assert: -100 equals: sender balance.
	self assert: 100 equals: receiver balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/30/2021 16:27:08'!
test09anAccountCantSendMoneyToItself

	| account |
	
	account := ReceptiveAccount new.
	
	self should:  [Transfer register: 100 from: account to: account] raise: Error withMessageText: Transfer anAccountCantSendMoneyToItselfErrorDescription
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/30/2021 16:33:35'!
test10TransactionAmountCannotBeZeroOrNegative

	| sender receiver |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	self should:  [Transfer register: -100 from: sender to: receiver] 
		raise: Error 
		withMessageText: Transfer anInvalidTransactionAmountErrorDescription
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/30/2021 16:42:13'!
test11BalanceOfAnAccountWithoutTransactionsReturnsOnlyBalance

	| account accountSummary |
	
	account := ReceptiveAccount new.
	
	accountSummary := account accountSummary.
	
	self assert: 1 equals: accountSummary size.
	self assert: 'Balance = 0' equals: accountSummary first.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/30/2021 17:03:37'!
test12

	| account accountSummary |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account. 
	
	accountSummary := account accountSummary.
	
	self assert: 2 equals: accountSummary size.
	self assert: 'Depósito por 100' equals: (accountSummary at: 1).
	self assert: 'Balance = 100' equals: (accountSummary at: 2).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/30/2021 17:04:48'!
test13

	| account accountSummary |
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account. 
	
	accountSummary := account accountSummary.
	
	self assert: 2 equals: accountSummary size.
	self assert: 'Extraccion por 100' equals: (accountSummary at: 1).
	self assert: 'Balance = -100' equals: (accountSummary at: 2).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/31/2021 15:59:21'!
test14

	| sender receiver accountSummary |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	Transfer register: 50 from: sender to: receiver. 
	
	accountSummary := sender accountSummary.
	
	self assert: 2 equals: accountSummary size.
	self assert: 'Salida por transferencia de 50' equals: (accountSummary at: 1).
	self assert: 'Balance = -50' equals: (accountSummary at: 2).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/31/2021 16:03:50'!
test15

	| sender receiver accountSummary |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	Transfer register: 30 from: sender to: receiver. 
	
	accountSummary := receiver accountSummary.
	
	self assert: 2 equals: accountSummary size.
	self assert: 'Entrada por transferencia de 30' equals: (accountSummary at: 1).
	self assert: 'Balance = 30' equals: (accountSummary at: 2).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/31/2021 16:10:23'!
test15bis

	| sender receiver accountSummary |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Transfer register: 50 from: sender to: receiver.
	Transfer register: 30 from: receiver to: sender.
	Deposit register: 100 on: sender.
	Withdraw register: 200 on: sender.
	
	accountSummary := sender accountSummary.
	
	self assert: 5 equals: accountSummary size.
	self assert: 'Salida por transferencia de 50' equals: (accountSummary at: 1).
	self assert: 'Entrada por transferencia de 30' equals: (accountSummary at: 2).
	self assert: 'Depósito por 100' equals: (accountSummary at: 3).
	self assert: 'Extraccion por 200' equals: (accountSummary at: 4).
	self assert: 'Balance = -120' equals: (accountSummary at: 5).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/30/2021 17:11:11'!
test16

	| account |
	
	account := ReceptiveAccount new.
	
	self assert: 0 equals: account transferNetReport.
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/30/2021 17:13:54'!
test17

	| sender receiver |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Transfer register: 100 from: sender to: receiver.
	
	self assert: -100 equals: sender transferNetReport.
	self assert: 100 equals: receiver transferNetReport.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/30/2021 17:26:11'!
test18

	| sender |
	
	sender := ReceptiveAccount new.
	Deposit register: 100 on:sender. 
	self assert: 0 equals: sender transferNetReport.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/30/2021 17:28:55'!
test19

	| sender |
	
	sender := ReceptiveAccount new.
	Withdraw register: 100 on:sender. 
	self assert: 0 equals: sender transferNetReport.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'crivera 5/31/2021 15:52:29'!
test20

	| sender receiver |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Transfer register: 100 from: sender to: receiver.
	Transfer register: 200 from: receiver to: sender.
	
	self assert: 100 equals: sender transferNetReport.
	self assert: -100 equals: receiver transferNetReport.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 15:43:56'!
test01
	| sender receiver transfer |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	transfer := Transfer register: 100 from: sender to: receiver.
		
	self assert: (sender hasRegistered: transfer withdraw).
	self assert: (receiver hasRegistered: transfer deposit).! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 17:03:04'!
accountSummary
	| summary |
	summary := OrderedCollection new.
	transactions do: [:transaction | transaction printOnSummary: summary ].
	summary add: ('Balance = ', self balance asString).
	^ summary
	
	! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'crivera 5/31/2021 15:55:06'!
transferNetReport
	| amount |
	amount := 0.
	transactions do: [:transaction | amount := (transaction xxx: amount)].
	^amount! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 17:00:43'!
printOnSummary: aSummary 
	self shouldBeImplemented.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !

!Deposit methodsFor: 'initialization' stamp: 'crivera 5/30/2021 17:02:45'!
printOnSummary: aSummary 
	aSummary add: ('Depósito por ', value asString )! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 17:28:21'!
xxx: aSmallInteger 
	^aSmallInteger ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !

!Withdraw methodsFor: 'initialization' stamp: 'crivera 5/30/2021 17:08:49'!
printOnSummary: aSummary 
	aSummary add: ('Extraccion por ', value asString)! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'crivera 5/31/2021 15:51:01'!
xxx: aSmallInteger 
	^aSmallInteger ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'amount withdraw deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 16:07:33'!
deposit
	^deposit! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 16:05:51'!
initializeAmount: anAmount from: aReceptiveAccountSendingMoney to: aReceptiveAccountReceivingMoney 
	amount := anAmount.
	withdraw := WithdrawTransfer for: self.
	deposit := DepositTransfer for: self.
	aReceptiveAccountSendingMoney register: withdraw.
	aReceptiveAccountReceivingMoney  register: deposit.
	^ self! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 16:06:33'!
value
	^ amount ! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 16:07:47'!
withdraw
	^ withdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 16:24:34'!
anAccountCantSendMoneyToItselfErrorDescription
	^ 'Account cant be the sender and receiver'! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 16:32:09'!
anInvalidTransactionAmountErrorDescription
	^ 'invalid amount'! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 16:32:59'!
register: anAmount from: aReceptiveAccountSendingMoney to: aReceptiveAccountReceivingMoney
	anAmount  <= 0 ifTrue: [self error: self anInvalidTransactionAmountErrorDescription].
	aReceptiveAccountSendingMoney = aReceptiveAccountReceivingMoney ifTrue: [self error: self anAccountCantSendMoneyToItselfErrorDescription].
	^ self new initializeAmount: anAmount from: aReceptiveAccountSendingMoney to: aReceptiveAccountReceivingMoney ! !



!classDefinition: #XX category: 'Portfolio-Solucion'!
Object subclass: #XX
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!XX methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 16:18:16'!
affectBalance: anAmount
	self subclassResponsibility ! !

!XX methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 16:17:02'!
initializeWith: aTransaction 
	transfer := aTransaction.! !

!XX methodsFor: 'as yet unclassified' stamp: 'crivera 5/31/2021 16:12:56'!
printOnSummary: anOrderedCollection 
	self subclassResponsibility ! !

!XX methodsFor: 'as yet unclassified' stamp: 'crivera 5/31/2021 16:11:36'!
xxx: aSmallInteger 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XX class' category: 'Portfolio-Solucion'!
XX class
	instanceVariableNames: ''!

!XX class methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 16:19:45'!
for: aTransference 
	^ self new initializeWith: aTransference ! !


!classDefinition: #DepositTransfer category: 'Portfolio-Solucion'!
XX subclass: #DepositTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositTransfer methodsFor: 'initialization' stamp: 'crivera 5/30/2021 16:15:48'!
affectBalance: aSmallInteger 
	^ aSmallInteger + transfer value ! !

!DepositTransfer methodsFor: 'initialization' stamp: 'crivera 5/30/2021 17:23:39'!
xxx: aSmallInteger 
	^ aSmallInteger + (transfer value)! !


!DepositTransfer methodsFor: 'as yet unclassified' stamp: 'crivera 5/31/2021 16:04:57'!
printOnSummary: anOrderedCollection 
	anOrderedCollection add: ('Entrada por transferencia de ', (transfer value asString ))! !


!classDefinition: #WithdrawTransfer category: 'Portfolio-Solucion'!
XX subclass: #WithdrawTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawTransfer methodsFor: 'initialization' stamp: 'crivera 5/30/2021 16:16:34'!
affectBalance: aSmallInteger 
	^ aSmallInteger - transfer value! !


!WithdrawTransfer methodsFor: 'as yet unclassified' stamp: 'crivera 5/31/2021 16:02:40'!
printOnSummary: anOrderedCollection 
	anOrderedCollection add: 'Salida por transferencia de ', (transfer value asString).! !

!WithdrawTransfer methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 17:20:52'!
xxx: aSmallInteger 
	^ aSmallInteger - (transfer value)! !
