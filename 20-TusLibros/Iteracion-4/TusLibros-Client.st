!classDefinition: #CartWindow category: 'TusLibros-Client'!
Panel subclass: #CartWindow
	instanceVariableNames: 'booksQtyTextBoxMorh booksListMorph catalogListMorph listPurchasesButtonMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!CartWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 19:44:44'!
buildCart1stRow
	
	|firstRowLayoutMorph addToCartButtonMorph |
	
	addToCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #addToCartRequest  label: 'Add to cart'.
	
	catalogListMorph := PluggableListMorph model: self model listGetter: #catalog indexGetter: #catalogListIndex indexSetter: #catalogListIndex:.
	
	catalogListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
	
	booksQtyTextBoxMorh := TextModelMorph textProvider: self model textGetter: #bookQtyText textSetter: #bookQtyText:.
	
	booksQtyTextBoxMorh textMorph setProperty: #keyStroke: toValue: [:key | booksQtyTextBoxMorh textMorph acceptContents ].
	
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	addMorph: (LabelMorph contents:'Catalog');
	addMorph: catalogListMorph;
	addMorph: booksQtyTextBoxMorh;
	addMorph: addToCartButtonMorph.
	
	^firstRowLayoutMorph! !

!CartWindow methodsFor: 'GUI building' stamp: 'DB 7/7/2021 19:20:00'!
buildCart2stRow
	
	|secondRowLayoutMorph checkoutButtonMorph  |

	checkoutButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #checkoutInput  label: 'Checkout'.	
	
	listPurchasesButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #listPurchases  label: 'Purchases'.	
		
	booksListMorph := PluggableListMorph model: self model listGetter: #books indexGetter: #booksListIndex indexSetter: #booksListIndex:.
	
	booksListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
	

	secondRowLayoutMorph := LayoutMorph newRow.
	secondRowLayoutMorph separation: 25;
	addMorph: (LabelMorph contents:'List');
	addMorph: booksListMorph;
	addMorph: checkoutButtonMorph;
	addMorph: listPurchasesButtonMorph.
	
	
	^secondRowLayoutMorph! !

!CartWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 00:22:51'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildCart1stRow;
	addMorph: self buildCart2stRow . ! !


!CartWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/6/2021 19:54:31'!
checkoutInput

	CheckoutWindow openWith: model.! !

!CartWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 18:45:52'!
defaultExtent

	^ 1035@485! !

!CartWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/6/2021 10:30:31'!
refreshCatalog

	catalogListMorph updateList.
	catalogListMorph setSelectionIndex: 0.! !

!CartWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 23:30:56'!
refreshListCart

	booksListMorph updateList.
	booksListMorph setSelectionIndex: 0.! !

!CartWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 21:23:12'!
refreshListOfBooks

	model listCartRequest! !


!CartWindow methodsFor: 'initialization' stamp: 'DB 7/7/2021 20:07:34'!
initializeWith: existedModel title: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: existedModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.

	self model when: #successfulCatalogLoad send: #refreshCatalog to: self.
	self model when: #successfulAdded send: #refreshListOfBooks to: self.
	self model when: #successfulList send: #refreshListCart to: self.
	self model when: #checkoutInput send: #checkoutInput to: self.
	self model when: #listPurchases send: #listPurchases to: self.
	self model when: #successfulListPurchases send: #openListPurchases to: self.
	
	! !

!CartWindow methodsFor: 'initialization' stamp: 'DB 7/7/2021 19:25:54'!
listPurchases

	model sendListPurchasesRequest.
	"ListPurchases openWith: model "
	
	! !

!CartWindow methodsFor: 'initialization' stamp: 'DB 7/7/2021 20:18:42'!
openListPurchases

	ListPurchases openWith: model
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartWindow class' category: 'TusLibros-Client'!
CartWindow class
	instanceVariableNames: ''!

!CartWindow class methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 19:21:37'!
openWith: model
	
	^self new initializeWith: model title: 'Cart window'! !


!classDefinition: #CheckoutWindow category: 'TusLibros-Client'!
Panel subclass: #CheckoutWindow
	instanceVariableNames: 'cnnTextBoxMorph ccoTextBoxMorph ccedTextBoxMorph checkoutButtonMorph ticketListBoxMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!CheckoutWindow methodsFor: 'GUI building' stamp: 'DB 7/7/2021 21:00:09'!
buildCCED

	| cced |
	ccedTextBoxMorph := TextModelMorph textProvider: self model textGetter: #ccedText textSetter: #ccedText:.
	ccedTextBoxMorph borderWidth: 3.
	
	cced := LayoutMorph newRow.
	cced separation: 10;
	addMorph: (LabelMorph contents: 'Credit Card Expiration Date');
	addMorph: ccedTextBoxMorph.
	
	^cced! !

!CheckoutWindow methodsFor: 'GUI building' stamp: 'DB 7/7/2021 20:49:54'!
buildCCN

	| ccn |
	cnnTextBoxMorph := TextModelMorph textProvider: self model textGetter: #ccnText textSetter: #ccnText:.
	cnnTextBoxMorph borderWidth: 3.
	
	ccn := LayoutMorph newRow.
	ccn separation: 10;
	addMorph: (LabelMorph contents: 'Credit Card Number');
	addMorph: cnnTextBoxMorph.
	
	^ccn! !

!CheckoutWindow methodsFor: 'GUI building' stamp: 'DB 7/7/2021 20:50:08'!
buildCCO

	| cco  |
	ccoTextBoxMorph := TextModelMorph textProvider: self model textGetter: #ccoText textSetter: #ccoText:.
	ccoTextBoxMorph borderWidth: 3.
	
	ticketListBoxMorph :=  PluggableListMorph model: self model listGetter: #tickets indexGetter: #ticketsListIndex indexSetter: #ticketsListIndex:.
	
	cco := LayoutMorph newRow.
	cco separation: 10;
	addMorph: (LabelMorph contents: 'Credit Card Owner:');
	addMorph: ccoTextBoxMorph;
	addMorph: ticketListBoxMorph.
	
	^cco! !

!CheckoutWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 01:01:44'!
buildCheckoutButton

	| checkoutButtom |
	
	checkoutButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #sendCheckoutRequest  label: 'Checkout'.
	
	checkoutButtom := LayoutMorph newColumn.
	checkoutButtom separation: 5;
	addMorph: checkoutButtonMorph.
	
	^checkoutButtom! !

!CheckoutWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 01:00:28'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildCCO;
	addMorph: self buildCCN;
	addMorph: self buildCCED;
	addMorph: self buildCheckoutButton.! !


!CheckoutWindow methodsFor: 'initialization' stamp: 'DB 7/1/2021 21:16:04'!
defaultExtent

	^ 1035@485
	! !

!CheckoutWindow methodsFor: 'initialization' stamp: 'DB 7/6/2021 21:20:30'!
initializeWith: existedModel title: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: existedModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	self model when: #successfulCheckout send: #refeshTicket to: self.! !


!CheckoutWindow methodsFor: 'events' stamp: 'DB 7/1/2021 21:34:48'!
closeCheckoutWindow

	self closeButtonClicked.! !

!CheckoutWindow methodsFor: 'events' stamp: 'DB 7/6/2021 21:21:13'!
refeshTicket

	ticketListBoxMorph updateList.
	ticketListBoxMorph setSelectionIndex: 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckoutWindow class' category: 'TusLibros-Client'!
CheckoutWindow class
	instanceVariableNames: ''!

!CheckoutWindow class methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 21:18:18'!
openWith: model

	^self new initializeWith: model title: 'Checkout'! !


!classDefinition: #ListPurchases category: 'TusLibros-Client'!
Panel subclass: #ListPurchases
	instanceVariableNames: 'purchasesListBoxMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!ListPurchases methodsFor: 'initialization' stamp: 'DB 7/7/2021 19:21:31'!
initializeWith: existedModel title: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: existedModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.! !


!ListPurchases methodsFor: 'GUI building' stamp: 'DB 7/7/2021 20:22:13'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildPurchases.! !

!ListPurchases methodsFor: 'GUI building' stamp: 'DB 7/7/2021 21:02:24'!
buildPurchases
	| purchases |
	
	purchasesListBoxMorph := PluggableListMorph model: self model listGetter: #purchases indexGetter: #purchasesListIndex indexSetter: #purchasesListIndex:.
	purchasesListBoxMorph morphExtent: 500@200.
	
	purchases := LayoutMorph newRow.
	purchases separation: 10;
	addMorph: (LabelMorph contents: 'Purchases:');
	addMorph: purchasesListBoxMorph.
	^purchases ! !

!ListPurchases methodsFor: 'GUI building' stamp: 'DB 7/7/2021 19:22:03'!
defaultExtent

	^ 1035@485
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ListPurchases class' category: 'TusLibros-Client'!
ListPurchases class
	instanceVariableNames: ''!

!ListPurchases class methodsFor: 'as yet unclassified' stamp: 'DB 7/7/2021 19:24:04'!
openWith: model

	^self new initializeWith: model title: 'Purchases'! !


!classDefinition: #TusLibrosLogin category: 'TusLibros-Client'!
Panel subclass: #TusLibrosLogin
	instanceVariableNames: 'userTextBoxMorh passTextBoxMorh'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosLogin methodsFor: 'GUI building' stamp: 'DB 7/6/2021 01:02:45'!
buildLoginButtom
	
	|buttonRowLayoutMorph sendLoginButtonMorph|
	
	sendLoginButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #sendLoginRequest  label: 'Login'.
	
	buttonRowLayoutMorph := LayoutMorph newRow.
	buttonRowLayoutMorph separation: 5;
	addMorph: sendLoginButtonMorph.
	
	^buttonRowLayoutMorph
	
	! !

!TusLibrosLogin methodsFor: 'GUI building' stamp: 'DB 7/7/2021 20:59:21'!
buildLoginPass
	
	|passRowLayoutMorph |
	
	passTextBoxMorh := TextModelMorph textProvider: self model textGetter: #passText textSetter: #passText:.
	passTextBoxMorh borderWidth: 2.
	passTextBoxMorh morphExtent: 200@30.

	passTextBoxMorh textMorph setProperty: #keyStroke: toValue: [:key |
		passTextBoxMorh textMorph acceptContents ].
	
	passRowLayoutMorph := LayoutMorph newRow.
	passRowLayoutMorph separation: 10;
	addMorph: (LabelMorph contents:'Password');
	addMorph: passTextBoxMorh.
	
	^passRowLayoutMorph
	
	! !

!TusLibrosLogin methodsFor: 'GUI building' stamp: 'DB 7/7/2021 20:59:25'!
buildLoginUser
	
	|userRowLayoutMorph |
	
	userTextBoxMorh := TextModelMorph textProvider: self model textGetter: #userText textSetter: #userText:.
	userTextBoxMorh borderWidth: 2.
	userTextBoxMorh morphExtent: 200@30.
	
	userTextBoxMorh textMorph setProperty: #keyStroke: toValue: [:key |
		userTextBoxMorh textMorph acceptContents ].
	
	userRowLayoutMorph := LayoutMorph newRow.
	userRowLayoutMorph separation: 10;
	addMorph: (LabelMorph contents:'User');
	addMorph: userTextBoxMorh.
	
	^userRowLayoutMorph
	
	! !

!TusLibrosLogin methodsFor: 'GUI building' stamp: 'DB 7/6/2021 00:58:35'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildLoginUser;
	addMorph: self buildLoginPass;
	addMorph: self buildLoginButtom. ! !

!TusLibrosLogin methodsFor: 'GUI building' stamp: 'DB 6/28/2021 21:22:35'!
defaultExtent

	^ 1035@485! !


!TusLibrosLogin methodsFor: 'initialization' stamp: 'DB 7/1/2021 21:02:55'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: WindowModel new.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
				
	self model when: #successfulLogin send: #openCartWindow to: self! !


!TusLibrosLogin methodsFor: 'event' stamp: 'DB 7/6/2021 10:38:48'!
openCartWindow

	self closeButtonClicked .
	model sendListCatalogRequest.
	
	CartWindow openWith: model.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosLogin class' category: 'TusLibros-Client'!
TusLibrosLogin class
	instanceVariableNames: ''!

!TusLibrosLogin class methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 17:56:52'!
open

	^self new initializeWith: 'Login window'! !


!classDefinition: #RestInterfaceClient category: 'TusLibros-Client'!
Object subclass: #RestInterfaceClient
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!RestInterfaceClient methodsFor: 'sending request' stamp: 'DB 6/28/2021 21:32:04'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !

!RestInterfaceClient methodsFor: 'sending request' stamp: 'DB 7/7/2021 20:29:30'!
sendAddToCartRequest: aCartID bookISBN: aISBN bookQuantity: aQty

	| resp  |
	
	"http://localhost:8080/addToCart?cartID=1&bookISBN=validBook&bookQuantity=2"
		
	resp := WebClient htmlSubmit: (self url,'/addToCart') fields:  {
				'cartID' ->  aCartID.
				'bookISBN' -> aISBN.
				'bookQuantity' -> aQty
			}.
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].
	
	
	
	
	! !

!RestInterfaceClient methodsFor: 'sending request' stamp: 'DB 7/6/2021 21:05:48'!
sendCheckoutRequest: aCartID ccn: aCCN cced: aCCED cco: aCCO

	| resp  |
	
	"http://localhost:8080/checkout?cartID=1&ccn=3232&cced=022021&cco=mycard"
		
	resp := WebClient htmlSubmit: (self url,'/checkout') fields:  {
				'cartID' ->  aCartID.
				'ccn' -> aCCN.
				'cced' -> aCCED.
				'cco' -> aCCO.
			}.
			
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].
		
	
	
	
	
	
	! !

!RestInterfaceClient methodsFor: 'sending request' stamp: 'DB 7/1/2021 21:04:37'!
sendListCartRequest: aCartID 

	| resp  |
	
	"http://localhost:8080/listCart?cartID=1"
		
	resp := WebClient htmlSubmit: (self url,'/listCart') fields:  {
				'cartID' ->  aCartID.
			}.
			
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)) asOrderedCollection .] 
		ifFalse:[^self error: resp content].
		
	
	
	
	
	
	! !

!RestInterfaceClient methodsFor: 'sending request' stamp: 'DB 7/6/2021 10:35:37'!
sendListCatalogRequest: aUserName authenticated: aPassword

	| resp  |
	
	"http://localhost:8080/listcatalog?user=lucas&pass=123"
	resp := WebClient htmlSubmit: (self url,'/listcatalog') fields:  {
				'user' ->  aUserName.
				'pass' -> aPassword
			}.
			
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)) asOrderedCollection.] 
		ifFalse:[^self error: resp content].
		
	
	
	
	
	! !

!RestInterfaceClient methodsFor: 'sending request' stamp: 'DB 7/7/2021 19:52:46'!
sendListPurchasesRequest: aUserName pass: aPassword

	| resp  |
	
	"http://localhost:8080/listPurchases?user=lucas&pass=123"
	resp := WebClient htmlSubmit: (self url,'/listPurchases') fields:  {
				'user' ->  aUserName.
				'pass' -> aPassword
			}.
			
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].
		
	
	
	
	
	! !

!RestInterfaceClient methodsFor: 'sending request' stamp: 'DB 7/5/2021 23:25:21'!
sendLoginRequest: aUserName pass: aPassword

	| resp  |
	
	"http://localhost:8080/createCart?user=lucas&pass=123"
	resp := WebClient htmlSubmit: (self url,'/createCart') fields:  {
				'user' ->  aUserName.
				'pass' -> aPassword
			}.
			
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)) asString.] 
		ifFalse:[^self error: resp content].
		
	
	
	
	
	! !


!RestInterfaceClient methodsFor: 'initialization' stamp: 'DB 6/28/2021 21:31:45'!
port
	
	^port ifNil: [port:=8080].! !

!RestInterfaceClient methodsFor: 'initialization' stamp: 'DB 6/28/2021 21:31:52'!
url
	
	^'http://localhost:', self port asString! !


!classDefinition: #WindowModel category: 'TusLibros-Client'!
Object subclass: #WindowModel
	instanceVariableNames: 'restInterface user pass cartID bookQty cartSelectedIndex catalogSelectedIndex ticketsSelectedIndex books catalog ccn cced cco ticket purchases purchasesListIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!WindowModel methodsFor: 'request' stamp: 'DB 7/6/2021 10:43:28'!
addToCartRequest
	
	restInterface sendAddToCartRequest: cartID bookISBN: (catalog at: catalogSelectedIndex) bookQuantity: bookQty.
	
	self triggerEvent: #successfulAdded with: self.
	
	! !

!WindowModel methodsFor: 'request' stamp: 'DB 7/6/2021 19:51:39'!
checkoutInput

	self triggerEvent: #checkoutInput with: self.
	! !

!WindowModel methodsFor: 'request' stamp: 'DB 7/1/2021 20:35:24'!
listCartRequest
	
 	books := restInterface sendListCartRequest: cartID.
		
	self triggerEvent: #successfulList with: self.
	! !

!WindowModel methodsFor: 'request' stamp: 'DB 7/7/2021 19:20:21'!
listPurchases

	self triggerEvent: #listPurchases with: self.
	! !

!WindowModel methodsFor: 'request' stamp: 'DB 7/6/2021 20:49:32'!
sendCheckoutRequest

	ticket := restInterface sendCheckoutRequest: cartID ccn: ccn  cced: cced cco: cco.
	
	self triggerEvent: #successfulCheckout with: self.
	! !

!WindowModel methodsFor: 'request' stamp: 'DB 7/6/2021 10:27:51'!
sendListCatalogRequest
	
	catalog :=  restInterface sendListCatalogRequest: user authenticated: pass.
	
	self triggerEvent: #successfulCatalogLoad with: self.
	
	! !

!WindowModel methodsFor: 'request' stamp: 'DB 7/7/2021 20:05:41'!
sendListPurchasesRequest
	
	purchases :=  restInterface sendListPurchasesRequest: user pass: pass.
	
	self triggerEvent: #successfulListPurchases with: self.
	
	! !

!WindowModel methodsFor: 'request' stamp: 'DB 7/7/2021 18:45:43'!
sendLoginRequest
	
	cartID :=  restInterface sendLoginRequest: user pass: pass.
	
	self triggerEvent: #successfulLogin with: self.
	
	! !


!WindowModel methodsFor: 'initialization' stamp: 'DB 7/7/2021 20:41:18'!
initialize

	restInterface := RestInterfaceClient new.
	user := ''.
	pass := ''.
	bookQty := ''.
	ccn := ''.
	cced := ''.
	cco := ''.
	books := OrderedCollection new.
	cartSelectedIndex := 0.
	
	catalog := OrderedCollection new.
	catalogSelectedIndex := 0.
	
	ticket := Dictionary new.
	ticketsSelectedIndex := 0.
		
	purchases := OrderedCollection new.
	purchasesListIndex := 0! !


!WindowModel methodsFor: 'getter' stamp: 'DB 7/1/2021 18:54:03'!
bookQtyText

	^bookQty! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/1/2021 20:35:27'!
books

	^books! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/7/2021 20:40:44'!
booksListIndex

	^cartSelectedIndex! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/6/2021 10:24:28'!
catalog

	^catalog! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/7/2021 20:40:37'!
catalogListIndex

	^catalogSelectedIndex! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/7/2021 20:40:33'!
ccedText

	^cced! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/6/2021 19:25:26'!
ccnText

	^ccn! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/7/2021 20:40:27'!
ccoText

	^cco! !

!WindowModel methodsFor: 'getter' stamp: 'DB 6/28/2021 21:57:01'!
passText

	^pass! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/7/2021 20:34:34'!
purchases
	
	| purchacesAsOrderCollection |
	purchacesAsOrderCollection := OrderedCollection new.
	(purchases keysAndValuesDo: [:aKey :aValue | purchacesAsOrderCollection add: (aKey, ' price: ', aValue asString)]).
	^purchacesAsOrderCollection asArray.! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/7/2021 20:15:19'!
purchasesListIndex

	^purchasesListIndex! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/7/2021 19:45:29'!
tickets
	
	^(ticket at: 'items' ifAbsent:[OrderedCollection new]) collect: [:item | (item at: 'ISBN'), ' | ',(item at: 'quantity') asString,' | ',(item at: 'total') asString] ! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/7/2021 20:40:02'!
ticketsListIndex

	^ticketsSelectedIndex! !

!WindowModel methodsFor: 'getter' stamp: 'DB 6/28/2021 21:03:13'!
userText

	^user! !


!WindowModel methodsFor: 'setter' stamp: 'DB 7/1/2021 18:53:52'!
bookQtyText: aQty

	bookQty  := aQty.! !

!WindowModel methodsFor: 'setter' stamp: 'DB 7/6/2021 10:46:04'!
booksListIndex: anIndex
	
	cartSelectedIndex := anIndex ! !

!WindowModel methodsFor: 'setter' stamp: 'DB 7/6/2021 10:43:15'!
catalogListIndex: anIndex

	catalogSelectedIndex := anIndex ! !

!WindowModel methodsFor: 'setter' stamp: 'DB 7/6/2021 19:24:20'!
ccedText: aCreditCardExpirationDate

	cced  := aCreditCardExpirationDate.! !

!WindowModel methodsFor: 'setter' stamp: 'DB 7/6/2021 19:25:02'!
ccnText: aCreditCardNumber

	ccn  := aCreditCardNumber.! !

!WindowModel methodsFor: 'setter' stamp: 'DB 6/28/2021 21:57:15'!
passText: aPassword

 	pass := aPassword! !

!WindowModel methodsFor: 'setter' stamp: 'DB 7/7/2021 20:15:24'!
purchasesListIndex: anIndex

	purchasesListIndex := anIndex ! !

!WindowModel methodsFor: 'setter' stamp: 'DB 7/6/2021 21:18:34'!
ticketsListIndex: anIndex

	ticketsSelectedIndex := anIndex ! !

!WindowModel methodsFor: 'setter' stamp: 'DB 6/28/2021 21:09:47'!
userText: aUser

	user := aUser.
! !
