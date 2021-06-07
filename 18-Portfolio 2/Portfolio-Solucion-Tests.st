!classDefinition: #PortfolioTest category: 'Portfolio-Solucion-Tests'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion-Tests'!

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


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion-Tests'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion-Tests'!

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


!classDefinition: #SummaryReportTest category: 'Portfolio-Solucion-Tests'!
TestCase subclass: #SummaryReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion-Tests'!

!SummaryReportTest methodsFor: 'portfolio-tests' stamp: 'crivera 6/1/2021 21:51:47'!
test07ReportOfAnEmptyPortfolioOnlyShowsBalance
	| account accountSummary |
	
	account := Portfolio new.
	
	accountSummary := (SummaryReport for: account) report.
	
	self assert: 1 equals: accountSummary size.
	self assert: 'Balance = 0' equals: (accountSummary at: 1).! !

!SummaryReportTest methodsFor: 'portfolio-tests' stamp: 'crivera 6/1/2021 21:52:17'!
test08PortfolioWithAReceptiveAccount
	| portfolio accountSummary account |
	
	account _ ReceptiveAccount new.
	Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	accountSummary := (SummaryReport for: portfolio) report.
	
	self assert: 2 equals: accountSummary size.
	self assert: 'Extracción por 100' equals: (accountSummary at: 1).
	self assert: 'Balance = -100' equals: (accountSummary at: 2).! !

!SummaryReportTest methodsFor: 'portfolio-tests' stamp: 'crivera 6/1/2021 21:53:21'!
test09PorfolioWithAPortfolioHavingAnAccount
	| portfolio accountSummary account sonPortfolio |
	
	account _ ReceptiveAccount new.
	Withdraw register: 100 on: account.
	sonPortfolio _ Portfolio with: account.
	portfolio := Portfolio with: sonPortfolio.
	
	accountSummary := (SummaryReport for: portfolio) report.
	
	self assert: 2 equals: accountSummary size.
	self assert: 'Extracción por 100' equals: (accountSummary at: 1).
	self assert: 'Balance = -100' equals: (accountSummary at: 2).! !


!SummaryReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:08:20'!
test01ReportOfAReceptiveAccountOnlyShowsBalance
	| account accountSummary |
	
	account := ReceptiveAccount new.
	
	accountSummary := (SummaryReport for: account) report.
	
	self assert: 1 equals: accountSummary size.
	self assert: 'Balance = 0' equals: (accountSummary at: 1).! !

!SummaryReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:09:10'!
test02SummaryOfAnAccountWithADeposit
	| account accountSummary |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account. 
	
	accountSummary := (SummaryReport for: account) report.
	
	self assert: 2 equals: accountSummary size.
	self assert: 'Depósito por 100' equals: (accountSummary at: 1).
	self assert: 'Balance = 100' equals: (accountSummary at: 2).! !

!SummaryReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:09:35'!
test03SummaryOfAnAccountWithAWithdraw
	| account accountSummary |
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account. 
	
	accountSummary := (SummaryReport for: account) report.
	
	self assert: 2 equals: accountSummary size.
	self assert: 'Extracción por 100' equals: (accountSummary at: 1).
	self assert: 'Balance = -100' equals: (accountSummary at: 2).! !

!SummaryReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:10:14'!
test04SummaryOfAnAccountWithAWithdrawTransfer
	| sender receiver accountSummary |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	Transfer register: 50 from: sender to: receiver. 
	
	accountSummary := (SummaryReport for: sender) report.
	
	self assert: 2 equals: accountSummary size.
	self assert: 'Salida por transferencia de 50' equals: (accountSummary at: 1).
	self assert: 'Balance = -50' equals: (accountSummary at: 2).! !

!SummaryReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:10:35'!
test05SummaryOfAnAccountWithADepositTransfer

	| sender receiver accountSummary |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	Transfer register: 30 from: sender to: receiver. 
	
	accountSummary := (SummaryReport for: receiver) report.
	
	self assert: 2 equals: accountSummary size.
	self assert: 'Entrada por transferencia de 30' equals: (accountSummary at: 1).
	self assert: 'Balance = 30' equals: (accountSummary at: 2).! !

!SummaryReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:11:05'!
test06TestingACompleteSummaryReport
	| sender receiver accountSummary |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Transfer register: 50 from: sender to: receiver.
	Transfer register: 30 from: receiver to: sender.
	Deposit register: 100 on: sender.
	Withdraw register: 200 on: sender.
	
	accountSummary := (SummaryReport for: sender) report.
	
	self assert: 5 equals: accountSummary size.
	self assert: 'Salida por transferencia de 50' equals: (accountSummary at: 1).
	self assert: 'Entrada por transferencia de 30' equals: (accountSummary at: 2).
	self assert: 'Depósito por 100' equals: (accountSummary at: 3).
	self assert: 'Extracción por 200' equals: (accountSummary at: 4).
	self assert: 'Balance = -120' equals: (accountSummary at: 5).! !


!classDefinition: #TransferNetReportTest category: 'Portfolio-Solucion-Tests'!
TestCase subclass: #TransferNetReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion-Tests'!

!TransferNetReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:12:39'!
test01TransferNetOfAnAccountWithoutTransactions
	| account transferNetReportAmount |
	
	account := ReceptiveAccount new.
	
	transferNetReportAmount _ (TransferNetReport for: account) report.
	
	self assert: 0 equals: transferNetReportAmount.! !

!TransferNetReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:14:12'!
test02TransferNetOfAnAccountThatSendsMoney

	| sender receiver transferNetReportAmount |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	Transfer register: 100 from: sender to: receiver.
	
	transferNetReportAmount _ (TransferNetReport for: sender) report.
	
	self assert: -100 equals: transferNetReportAmount.! !

!TransferNetReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:14:33'!
test03TransferNetOfAnAccountThatReceivesMoney

	| sender receiver transferNetReportAmount |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	Transfer register: 100 from: sender to: receiver.
	
	transferNetReportAmount _ (TransferNetReport for: receiver) report.
	
	self assert: 100 equals: transferNetReportAmount.! !

!TransferNetReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:15:03'!
test04TransferNetOfAnAccountThatHasADeposit
	| sender transferNetReportAmount |
	
	sender := ReceptiveAccount new.
	Deposit register: 100 on:sender. 
	
	transferNetReportAmount _ (TransferNetReport for: sender) report.


	self assert: 0 equals: transferNetReportAmount.! !

!TransferNetReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:15:28'!
test05TransferNetOfAnAccountThatHasAWithdraw
	| sender transferNetReportAmount |
	
	sender := ReceptiveAccount new.
	Withdraw register: 100 on:sender. 
	
	transferNetReportAmount _ (TransferNetReport for: sender) report.


	self assert: 0 equals: transferNetReportAmount.! !

!TransferNetReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:15:55'!
test06TransferNetOfAnAccountThatHasMultipleTransfers
	| sender receiver transferNetReportAmount |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Transfer register: 100 from: sender to: receiver.
	Transfer register: 200 from: receiver to: sender.
	
	transferNetReportAmount _ (TransferNetReport for: sender) report.


	self assert: 100 equals: transferNetReportAmount.! !

!TransferNetReportTest methodsFor: 'receptive-account-tests' stamp: 'crivera 6/1/2021 21:17:04'!
test07TransferNetOfAnAccountThatHasMultipleTransfersWithNegativeBalance
	| sender receiver transferNetReportAmount |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Transfer register: 100 from: sender to: receiver.
	Transfer register: 200 from: receiver to: sender.
	
	transferNetReportAmount _ (TransferNetReport for: receiver ) report.

	self assert: -100 equals: transferNetReportAmount.! !


!TransferNetReportTest methodsFor: 'portfolio-tests' stamp: 'crivera 6/1/2021 22:01:07'!
test08TransferNetOfAnEmptyPortfolio
	| account transferNetReportAmount |
	
	account := Portfolio new.
	
	transferNetReportAmount _ (TransferNetReport for: account) report.
	
	self assert: 0 equals: transferNetReportAmount.! !

!TransferNetReportTest methodsFor: 'portfolio-tests' stamp: 'crivera 6/1/2021 22:02:05'!
test09TransferNetOfAPortfolioWithAPortfolioWithAccounts
	| transferNetReportAmount portfolio receiver sender sonPortfolio |
	
	sender _ ReceptiveAccount new.
	receiver _ ReceptiveAccount new.
	Transfer register: 100 from: sender to: receiver.
	sonPortfolio _ Portfolio with: receiver with: sender.
	portfolio := Portfolio with: sonPortfolio .
	
	transferNetReportAmount _ (TransferNetReport for: portfolio) report.
	
	self assert: 0 equals: transferNetReportAmount.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion-Tests'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion-Tests'!

!TransferTest methodsFor: 'testing' stamp: 'crivera 6/1/2021 21:07:22'!
test01initializeTransfer
	| sender receiver transfer |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	transfer := Transfer register: 100 from: sender to: receiver.
		
	self assert: (sender hasRegistered: transfer withdraw).
	self assert: (receiver hasRegistered: transfer deposit).! !
