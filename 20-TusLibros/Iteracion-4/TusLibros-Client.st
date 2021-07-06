!classDefinition: #CartWindow category: 'TusLibros-Client'!
Panel subclass: #CartWindow
	instanceVariableNames: 'booksQtyTextBoxMorh message booksListMorph catalogListMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!CartWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 10:35:09'!
buildCart1stRow
	
	|firstRowLayoutMorph addToCartButtonMorph |
	
	addToCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #addToCartRequest  label: 'Add to cart'.

	
	catalogListMorph := PluggableListMorph model: self model listGetter: #catalog indexGetter: #catalogListIndex indexSetter: #catalogListIndex:.
	
	catalogListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
	
	
	booksQtyTextBoxMorh := TextModelMorph textProvider: self model textGetter: #bookQtyText textSetter: #bookQtyText:.
	
	
	booksQtyTextBoxMorh textMorph setProperty: #keyStroke: toValue: [:key |
		booksQtyTextBoxMorh textMorph acceptContents ].
	
	
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	addMorph: (LabelMorph contents:'Catalog');
	addMorph: catalogListMorph;
	addMorph: booksQtyTextBoxMorh;
	addMorph: addToCartButtonMorph.
	
	^firstRowLayoutMorph! !

!CartWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 00:32:13'!
buildCart2stRow
	
	|secondRowLayoutMorph checkoutButtonMorph  |

	checkoutButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #checkoutInput  label: 'Checkout'.	
	
	booksListMorph := PluggableListMorph model: self model listGetter: #books indexGetter: #booksListIndex indexSetter: #booksListIndex:.
	
	booksListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
	

	secondRowLayoutMorph := LayoutMorph newRow.
	secondRowLayoutMorph separation: 25;
	addMorph: (LabelMorph contents:'List');
	addMorph: booksListMorph;
	addMorph: checkoutButtonMorph.
	
	
	^secondRowLayoutMorph! !

!CartWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 00:22:51'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildCart1stRow;
	addMorph: self buildCart2stRow . ! !


!CartWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 21:21:44'!
checkoutInput

	CheckoutWindow openWith: model.! !

!CartWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 18:45:52'!
defaultExtent

	^ 1035@485! !

!CartWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 20:06:04'!
openSuccessfulWindow

	SuccessfulWindow openWith: message.
	! !

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


!CartWindow methodsFor: 'initialization' stamp: 'DB 7/6/2021 10:27:36'!
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
	instanceVariableNames: 'cnnTextBoxMorph ccoTextBoxMorph ccedTextBoxMorph checkoutButtonMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!CheckoutWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 00:54:58'!
buildCCED

	| cced |
	ccedTextBoxMorph := TextModelMorph textProvider: self model textGetter: nil textSetter: nil.
	
	cced := LayoutMorph newRow.
	cced separation: 10;
	addMorph: (LabelMorph contents: 'Credit Card Expiration Date');
	addMorph: ccedTextBoxMorph.
	
	^cced! !

!CheckoutWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 00:53:32'!
buildCCN

	| ccn |
	cnnTextBoxMorph := TextModelMorph textProvider: self model textGetter: nil textSetter: nil.
	
	ccn := LayoutMorph newRow.
	ccn separation: 10;
	addMorph: (LabelMorph contents: 'Credit Card Number');
	addMorph: cnnTextBoxMorph.
	
	^ccn! !

!CheckoutWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 00:53:23'!
buildCCO

	| cco |
	ccoTextBoxMorph := TextModelMorph textProvider: self model textGetter: nil textSetter: nil.
	
	cco := LayoutMorph newRow.
	cco separation: 10;
	addMorph: (LabelMorph contents: 'Credit Card Owner:');
	addMorph: ccoTextBoxMorph.
	
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


!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 21:34:48'!
closeCheckoutWindow

	self closeButtonClicked.! !

!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 21:16:04'!
defaultExtent

	^ 1035@485
	! !

!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 21:34:40'!
initializeWith: existedModel title: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: existedModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	self model when: #successfulCheckout send: #closeCheckoutWindow to: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckoutWindow class' category: 'TusLibros-Client'!
CheckoutWindow class
	instanceVariableNames: ''!

!CheckoutWindow class methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 21:18:18'!
openWith: model

	^self new initializeWith: model title: 'Checkout'! !


!classDefinition: #LoginWindow category: 'TusLibros-Client'!
Panel subclass: #LoginWindow
	instanceVariableNames: 'userTextBoxMorh passTextBoxMorh'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!LoginWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 01:02:45'!
buildLoginButtom
	
	|buttonRowLayoutMorph sendLoginButtonMorph|
	
	sendLoginButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #sendLoginRequest  label: 'Login'.
	
	buttonRowLayoutMorph := LayoutMorph newRow.
	buttonRowLayoutMorph separation: 5;
	addMorph: sendLoginButtonMorph.
	
	^buttonRowLayoutMorph
	
	! !

!LoginWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 01:07:38'!
buildLoginPass
	
	|passRowLayoutMorph |
	
	passTextBoxMorh := TextModelMorph textProvider: self model textGetter: #passText textSetter: #passText:.
	

	
	passTextBoxMorh textMorph setProperty: #keyStroke: toValue: [:key |
		passTextBoxMorh textMorph acceptContents ].
	
	passRowLayoutMorph := LayoutMorph newRow.
	passRowLayoutMorph separation: 15;
	addMorph: (LabelMorph contents:'Password');
	addMorph: passTextBoxMorh.
	
	^passRowLayoutMorph
	
	! !

!LoginWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 01:03:35'!
buildLoginUser
	
	|userRowLayoutMorph |
	
	userTextBoxMorh := TextModelMorph textProvider: self model textGetter: #userText textSetter: #userText:.
	
	userTextBoxMorh textMorph setProperty: #keyStroke: toValue: [:key |
		userTextBoxMorh textMorph acceptContents ].
	
	userRowLayoutMorph := LayoutMorph newRow.
	userRowLayoutMorph separation: 20;
	addMorph: (LabelMorph contents:'User');
	addMorph: userTextBoxMorh.
	
	^userRowLayoutMorph
	
	! !

!LoginWindow methodsFor: 'GUI building' stamp: 'DB 7/6/2021 00:58:35'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildLoginUser;
	addMorph: self buildLoginPass;
	addMorph: self buildLoginButtom. ! !


!LoginWindow methodsFor: 'as yet unclassified' stamp: 'DB 6/28/2021 21:22:35'!
defaultExtent

	^ 1035@485! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 21:02:55'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: WindowModel new.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
				
	self model when: #successfulLogin send: #openCartWindow to: self! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'DB 7/6/2021 10:38:48'!
openCartWindow

	self closeButtonClicked .
	model sendListCatalogRequest.
	
	CartWindow openWith: model.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoginWindow class' category: 'TusLibros-Client'!
LoginWindow class
	instanceVariableNames: ''!

!LoginWindow class methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 17:56:52'!
open

	^self new initializeWith: 'Login window'! !


!classDefinition: #SuccessfulWindow category: 'TusLibros-Client'!
Panel subclass: #SuccessfulWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!SuccessfulWindow methodsFor: 'initialization' stamp: 'DB 7/1/2021 20:03:37'!
initializeWith:  aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self morphExtent: (self defaultExtent).
	self openInWorld.
	self yourself.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SuccessfulWindow class' category: 'TusLibros-Client'!
SuccessfulWindow class
	instanceVariableNames: ''!

!SuccessfulWindow class methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 20:02:05'!
open! !

!SuccessfulWindow class methodsFor: 'as yet unclassified' stamp: 'DB 7/1/2021 20:03:04'!
openWith: title
	
	^self new initializeWith: title! !


!classDefinition: #RestInterfaceClient category: 'TusLibros-Client'!
Object subclass: #RestInterfaceClient
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!RestInterfaceClient methodsFor: 'sending request' stamp: 'DB 7/5/2021 23:30:48'!
sendAddToCartRequest: aCartID bookISBN: aISBN bookQuantity: aQty

	| resp  |
	
	"http://localhost:8080/addToCart?cartID=1&bookISBN=validBook&bookQuantity=2"
		
	resp := WebClient htmlSubmit: (self url,'/addToCart') fields:  {
				'cartID' ->  aCartID.
				'bookISBN' -> aISBN.
				'bookQuantity' -> aQty
			}.
			

	^resp content.
	
	
	
	
	! !

!RestInterfaceClient methodsFor: 'sending request' stamp: 'DB 7/1/2021 21:31:59'!
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


!RestInterfaceClient methodsFor: 'as yet unclassified' stamp: 'DB 6/28/2021 21:32:04'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !


!classDefinition: #WindowModel category: 'TusLibros-Client'!
Object subclass: #WindowModel
	instanceVariableNames: 'restInterface user pass cartID bookISBN bookQty cartSelectedIndex books catalog catalogSelectedIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!WindowModel methodsFor: 'request' stamp: 'DB 7/6/2021 10:43:28'!
addToCartRequest
	
	restInterface sendAddToCartRequest: cartID bookISBN: (catalog at: catalogSelectedIndex) bookQuantity: bookQty.
	
	self triggerEvent: #successfulAdded with: self.
	
	! !

!WindowModel methodsFor: 'request' stamp: 'DB 7/1/2021 21:14:09'!
checkoutInput

	self triggerEvent: #checkoutInput with: self.
	
	! !

!WindowModel methodsFor: 'request' stamp: 'DB 7/1/2021 21:33:20'!
checkoutRequest

	restInterface sendAddToCartRequest: cartID bookISBN: bookISBN bookQuantity: bookQty.
	
	self triggerEvent: #successfulCheckout with: self.
	
	! !

!WindowModel methodsFor: 'request' stamp: 'DB 7/1/2021 20:35:24'!
listCartRequest
	
 	books := restInterface sendListCartRequest: cartID.
		
	self triggerEvent: #successfulList with: self.
	! !

!WindowModel methodsFor: 'request' stamp: 'DB 7/6/2021 10:27:51'!
sendListCatalogRequest
	
	catalog :=  restInterface sendListCatalogRequest: user authenticated: pass.
	
	self triggerEvent: #successfulCatalogLoad with: self.
	
	! !

!WindowModel methodsFor: 'request' stamp: 'DB 7/1/2021 20:10:37'!
sendLoginRequest
	
	cartID :=  restInterface sendLoginRequest: user pass: pass.
	
	self triggerEvent: #successfulLogin with: self.
	
	! !


!WindowModel methodsFor: 'initialization' stamp: 'DB 7/6/2021 10:46:04'!
initialize

	restInterface := RestInterfaceClient new.
	user := ''.
	pass := ''.
	catalog := OrderedCollection new.
	bookQty := ''.
	cartSelectedIndex := 0.
	catalogSelectedIndex := 0.
	books := OrderedCollection new.! !


!WindowModel methodsFor: 'getter' stamp: 'DB 7/1/2021 18:54:03'!
bookQtyText

	^bookQty! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/1/2021 20:35:27'!
books

	^books! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/6/2021 10:46:04'!
booksListIndex
	^cartSelectedIndex! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/6/2021 10:24:28'!
catalog

	^catalog! !

!WindowModel methodsFor: 'getter' stamp: 'DB 7/6/2021 10:40:36'!
catalogListIndex
	^catalogSelectedIndex! !

!WindowModel methodsFor: 'getter' stamp: 'DB 6/28/2021 21:57:01'!
passText

	^pass! !

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

!WindowModel methodsFor: 'setter' stamp: 'DB 6/28/2021 21:57:15'!
passText: aPassword

 	pass := aPassword! !

!WindowModel methodsFor: 'setter' stamp: 'DB 6/28/2021 21:09:47'!
userText: aUser

	user := aUser.
! !
