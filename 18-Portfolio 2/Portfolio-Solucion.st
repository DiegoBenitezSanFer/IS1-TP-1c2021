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


!Account methodsFor: 'report' stamp: 'crivera 6/1/2021 21:49:46'!
report: aReport
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


!Portfolio methodsFor: 'report' stamp: 'crivera 6/1/2021 21:49:06'!
report: aReport 
	accounts do: [:account | account report: aReport ]! !

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


!ReceptiveAccount methodsFor: 'report' stamp: 'crivera 6/1/2021 20:43:06'!
report: aReport
	transactions do: [:transaction | transaction reportTo: aReport ]! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'initialization' stamp: 'crivera 6/1/2021 20:24:28'!
initializeWith: aReceptiveAccount 
	self subclassResponsibility ! !


!Report methodsFor: 'report-private' stamp: 'crivera 6/1/2021 20:25:34'!
reportToWithDeposit: aDeposit 
	self subclassResponsibility ! !

!Report methodsFor: 'report-private' stamp: 'crivera 6/1/2021 20:25:58'!
reportToWithDepositTransfer: aDepositTransfer 
	self subclassResponsibility ! !

!Report methodsFor: 'report-private' stamp: 'crivera 6/1/2021 20:26:22'!
reportToWithWithdraw: aWithdraw 
	self subclassResponsibility ! !

!Report methodsFor: 'report-private' stamp: 'crivera 6/1/2021 20:26:34'!
reportToWithWithdrawTransfer: aWithdrawTransfer 
	self subclassResponsibility ! !


!Report methodsFor: 'report' stamp: 'crivera 6/1/2021 20:25:09'!
report
	self subclassResponsibility ! !


!classDefinition: #SummaryReport category: 'Portfolio-Solucion'!
Report subclass: #SummaryReport
	instanceVariableNames: 'account summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReport methodsFor: 'initialization' stamp: 'crivera 6/1/2021 21:39:56'!
initializeWith: aReceptiveAccount 
	account := aReceptiveAccount.
	summary := OrderedCollection new! !


!SummaryReport methodsFor: 'report-private' stamp: 'crivera 6/1/2021 19:58:38'!
reportToWithDeposit: aDeposit 
	summary add: 'Depósito por ', (aDeposit value asString) ! !

!SummaryReport methodsFor: 'report-private' stamp: 'crivera 6/1/2021 20:00:45'!
reportToWithDepositTransfer: aDepositTransfer 
	^summary add: 'Entrada por transferencia de ', (aDepositTransfer value asString)! !

!SummaryReport methodsFor: 'report-private' stamp: 'crivera 6/1/2021 20:00:59'!
reportToWithWithdraw: aWithdraw 
	^summary add: 'Extracción por ', (aWithdraw value asString)! !

!SummaryReport methodsFor: 'report-private' stamp: 'crivera 6/1/2021 20:01:13'!
reportToWithWithdrawTransfer: aWithdrawTransfer 
	summary add: 'Salida por transferencia de ', (aWithdrawTransfer value asString)! !


!SummaryReport methodsFor: 'report' stamp: 'crivera 6/1/2021 21:39:56'!
report
	
	account report: self.
	summary add: ('Balance = ', account balance asString).
	^ summary! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummaryReport class' category: 'Portfolio-Solucion'!
SummaryReport class
	instanceVariableNames: ''!

!SummaryReport class methodsFor: 'as yet unclassified' stamp: 'crivera 5/31/2021 21:49:48'!
for: aReceptiveAccount 
	^ self new initializeWith: aReceptiveAccount ! !


!classDefinition: #TransferNetReport category: 'Portfolio-Solucion'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'receptiveAccount transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'initialization' stamp: 'crivera 6/1/2021 20:12:42'!
initializeWith: aReceptiveAccount 
	
	receptiveAccount := aReceptiveAccount.
	transferNet  := 0! !


!TransferNetReport methodsFor: 'report-private' stamp: 'crivera 6/1/2021 20:16:50'!
reportToWithDeposit: aDeposit 
	! !

!TransferNetReport methodsFor: 'report-private' stamp: 'crivera 6/1/2021 20:15:15'!
reportToWithDepositTransfer: aDepositTransfer 
	transferNet  := transferNet + aDepositTransfer value! !

!TransferNetReport methodsFor: 'report-private' stamp: 'crivera 6/1/2021 20:18:09'!
reportToWithWithdraw: aWithdraw 
	! !

!TransferNetReport methodsFor: 'report-private' stamp: 'crivera 6/1/2021 20:14:05'!
reportToWithWithdrawTransfer: aWithdrawTransfer 
	transferNet := transferNet - aWithdrawTransfer value! !


!TransferNetReport methodsFor: 'report' stamp: 'crivera 6/1/2021 20:12:26'!
report
	receptiveAccount report: self.
	
	^ transferNet! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReport class' category: 'Portfolio-Solucion'!
TransferNetReport class
	instanceVariableNames: ''!

!TransferNetReport class methodsFor: 'as yet unclassified' stamp: 'crivera 6/1/2021 20:07:29'!
for: aReceptiveAccount 
	^ self new initializeWith: aReceptiveAccount ! !


!classDefinition: #Transaction category: 'Portfolio-Solucion'!
Object subclass: #Transaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transaction methodsFor: 'value' stamp: 'crivera 6/1/2021 21:21:13'!
value
	self subclassResponsibility ! !


!Transaction methodsFor: 'balance' stamp: 'crivera 6/1/2021 21:20:36'!
affectBalance: aBalance

	self subclassResponsibility ! !


!Transaction methodsFor: 'report' stamp: 'crivera 6/1/2021 21:20:53'!
reportTo: aReport 

	self subclassResponsibility ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Transaction subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'crivera 6/1/2021 20:54:29'!
value 

	^value! !


!AccountTransaction methodsFor: 'initialization' stamp: 'crivera 6/1/2021 20:54:14'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'crivera 6/1/2021 20:56:14'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'balance' stamp: 'crivera 6/1/2021 21:04:52'!
affectBalance: aBalance

	^aBalance +  value ! !


!Deposit methodsFor: 'report' stamp: 'crivera 6/1/2021 20:44:10'!
reportTo: aReport 
	aReport reportToWithDeposit: self! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'balance' stamp: 'crivera 6/1/2021 21:05:43'!
affectBalance: aBalance

	^aBalance -  value! !


!Withdraw methodsFor: 'report' stamp: 'crivera 6/1/2021 20:45:09'!
reportTo: aReport 
	aReport reportToWithWithdraw: self! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
Transaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'initialization' stamp: 'crivera 5/30/2021 16:17:02'!
initializeWith: aTransaction 
	transfer := aTransaction.! !


!TransferTransaction methodsFor: 'report' stamp: 'crivera 6/1/2021 19:42:04'!
value
	^ transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'as yet unclassified' stamp: 'crivera 5/30/2021 16:19:45'!
for: aTransference 
	^ self new initializeWith: aTransference ! !


!classDefinition: #DepositTransfer category: 'Portfolio-Solucion'!
TransferTransaction subclass: #DepositTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositTransfer methodsFor: 'initialization' stamp: 'crivera 5/30/2021 16:15:48'!
affectBalance: aSmallInteger 
	^ aSmallInteger + transfer value ! !


!DepositTransfer methodsFor: 'report' stamp: 'crivera 6/1/2021 20:00:45'!
reportTo: aSummaryReport 
	^ aSummaryReport reportToWithDepositTransfer: self! !


!classDefinition: #WithdrawTransfer category: 'Portfolio-Solucion'!
TransferTransaction subclass: #WithdrawTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawTransfer methodsFor: 'initialization' stamp: 'crivera 5/30/2021 16:16:34'!
affectBalance: aSmallInteger 
	^ aSmallInteger - transfer value! !


!WithdrawTransfer methodsFor: 'report' stamp: 'crivera 6/1/2021 20:01:13'!
reportTo: aSummaryReport 
	^aSummaryReport reportToWithWithdrawTransfer: self! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'amount withdraw deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'testing' stamp: 'crivera 5/30/2021 16:07:33'!
deposit
	^deposit! !

!Transfer methodsFor: 'testing' stamp: 'crivera 5/30/2021 16:07:47'!
withdraw
	^ withdraw! !


!Transfer methodsFor: 'value' stamp: 'crivera 5/30/2021 16:06:33'!
value
	^ amount ! !


!Transfer methodsFor: 'initialization' stamp: 'crivera 5/30/2021 16:05:51'!
initializeAmount: anAmount from: aReceptiveAccountSendingMoney to: aReceptiveAccountReceivingMoney 
	amount := anAmount.
	withdraw := WithdrawTransfer for: self.
	deposit := DepositTransfer for: self.
	aReceptiveAccountSendingMoney register: withdraw.
	aReceptiveAccountReceivingMoney  register: deposit.
	^ self! !

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

