!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 20:52:50'!
* unMultiplicador
	^ unMultiplicador! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 4/5/2021 20:46:25'!
+ unSumando

	^unSumando next! !

!I class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 20:51:21'!
- unSustraendo 
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 19:29:05'!
/ unDivisor
	self = unDivisor ifTrue: [^self].
	
	self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 19:43:47'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'Las fracciones no pertenecen al dominio'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 19:17:44'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Numeros negativos fuera del dominio'! !

!I class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 20:53:32'!
minusTo: unMinuendo
	^ unMinuendo previous.! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 4/5/2021 20:31:42'!
next

	^II! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 20:53:56'!
* unMultiplicador
	^ unMultiplicador + (self previous * unMultiplicador ).! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 4/5/2021 20:56:14'!
+ unSumando

	^self previous + unSumando next! !

!II class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 20:20:21'!
- unSustraendo
	
	^ unSustraendo minusTo: self
	
	
	
	 ! !

!II class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 20:31:10'!
/ unDivisor
	(unDivisor isChildOf: self) ifTrue: [^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	self = unDivisor ifTrue: [^I].
	^ I + (self - unDivisor / unDivisor).! !

!II class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 19:37:43'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'Las fracciones no pertenecen al dominio'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 20:54:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 20:54:14'!
minusTo: unMinuendo
	^ self previous minusTo: unMinuendo previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 4/5/2021 21:07:59'!
next

	next ifNil:[
		next _ self createChildNamed: self name, 'I'.
		next previous: self.
		].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 4/5/2021 20:57:01'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'DB 4/5/2021 21:40:31'!
previous: aNumber
	previous := aNumber ! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 20:54:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 20:54:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Numeros Naturales'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numeros Naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'cr 4/7/2021 20:54:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!