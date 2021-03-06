!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:55:00'!
addAFraccion: anFraccionAdder 

	self subclassResponsibility ! !

!Numero methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:55:14'!
addAnEntero: anEnteroAdder 

	self subclassResponsibility ! !

!Numero methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:54:01'!
divideByAFraccion: aFraccionSubtrahend 

	self subclassResponsibility ! !

!Numero methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:53:32'!
divideByAnEntero: anEnteroSubtrahend 

	self subclassResponsibility ! !

!Numero methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:52:20'!
multiplyByAFraction: aFraccionMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:57:10'!
multiplyByAnEntero: aEnteroMultiplier 

	self subclassResponsibility ! !

!Numero methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:52:37'!
subtractByAnEntero: anEnteroSubtrahend 

	self subclassResponsibility ! !

!Numero methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:52:55'!
subtractByAnFraccion: aFraccionSubtrahend 

	self subclassResponsibility ! !


!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'signals' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de n�mero inv�lido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'DB 4/19/2021 23:52:03'!
* aMultiplier 

	^aMultiplier multiplyByAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DB 4/19/2021 23:55:14'!
+ anAdder 

	^anAdder addAnEntero: self ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DB 4/19/2021 23:52:37'!
- aSubtrahend 

	^aSubtrahend subtractByAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DB 4/19/2021 23:53:32'!
/ aDivisor

	^aDivisor divideByAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'cr 4/21/2021 19:55:15'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'cr 4/20/2021 20:57:56'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'cr 4/21/2021 18:46:06'!
isNegative

	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'cr 4/21/2021 18:46:13'!
isOne

	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'cr 4/21/2021 18:45:18'!
isZero
	
	self subclassResponsibility ! !


!Entero methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:57:27'!
addAFraccion: aFraccionAdder 
	
	^(aFraccionAdder denominator * self + aFraccionAdder numerator) / aFraccionAdder denominator.
	
! !

!Entero methodsFor: 'private operations' stamp: 'cr 4/20/2021 20:25:21'!
addAnEntero: anEnteroAdder 

	^Entero with: anEnteroAdder integerValue + value .
! !

!Entero methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:54:01'!
divideByAFraccion: aFraccionDivisor 

	^ aFraccionDivisor numerator / (self*aFraccionDivisor denominator) .
	! !

!Entero methodsFor: 'private operations' stamp: 'cr 4/21/2021 20:27:14'!
divideByAnEntero: anEnteroDividend
	self subclassResponsibility ! !

!Entero methodsFor: 'private operations' stamp: 'cr 4/21/2021 20:29:22'!
divideByAnUnreducibleEntero: aNumerator
	^ Fraccion with: aNumerator over: self ! !

!Entero methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:52:20'!
multiplyByAFraction: aFraccionMultiplier

	^ (self * aFraccionMultiplier numerator) / aFraccionMultiplier denominator.
		! !

!Entero methodsFor: 'private operations' stamp: 'cr 4/20/2021 20:26:16'!
multiplyByAnEntero: anEnteroMultiplier 

	^Entero with: value * anEnteroMultiplier integerValue
	! !

!Entero methodsFor: 'private operations' stamp: 'cr 4/21/2021 20:31:49'!
subtractByAnEntero: anEnteroMinuend 

	^ Entero with: (anEnteroMinuend integerValue - value).! !

!Entero methodsFor: 'private operations' stamp: 'cr 4/21/2021 20:32:50'!
subtractByAnFraccion: aFraccionMinuend 

	^aFraccionMinuend numerator - (self * aFraccionMinuend denominator) / aFraccionMinuend denominator 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no est� definido aqu� para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'cr 4/21/2021 18:40:39'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	(aValue  = 0) ifTrue: [^ ZeroEntero new].
	(aValue = 1) ifTrue: [^UnoEntero new].
	(aValue < 0) ifTrue: [^EnteroNegativo new initalizeWith: aValue].
	^EnteroMayorAUno new initalizeWith: aValue! !


!classDefinition: #EnteroMayorAUno category: 'Numero-Exercise'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorAUno methodsFor: 'testing' stamp: 'cr 4/21/2021 18:44:54'!
isNegative

	^false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 'cr 4/21/2021 18:45:27'!
isOne
	
	^false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 'cr 4/21/2021 18:47:26'!
isZero

	^false! !


!EnteroMayorAUno methodsFor: 'private operations' stamp: 'cr 4/21/2021 20:28:13'!
divideByAnEntero: anEnteroDividend
	| greatestCommonDivisor numerator denominator |	
	
	greatestCommonDivisor := anEnteroDividend greatestCommonDivisorWith: self. 
	numerator := anEnteroDividend // greatestCommonDivisor.
	denominator := self // greatestCommonDivisor.
	
	^ denominator divideByAnUnreducibleEntero: numerator 
! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'cr 4/20/2021 21:00:27'!
fibonacci
	^ self error: Entero negativeFibonacciErrorDescription! !


!EnteroNegativo methodsFor: 'testing' stamp: 'cr 4/20/2021 20:51:30'!
isNegative
	^ true! !

!EnteroNegativo methodsFor: 'testing' stamp: 'cr 4/21/2021 18:48:49'!
isOne
		
	^false! !

!EnteroNegativo methodsFor: 'testing' stamp: 'cr 4/21/2021 18:48:26'!
isZero
		
	^false! !


!EnteroNegativo methodsFor: 'private operations' stamp: 'cr 4/21/2021 20:28:24'!
divideByAnEntero: anEnteroDividend
	^ anEnteroDividend  negated  / self negated 
! !


!classDefinition: #UnoEntero category: 'Numero-Exercise'!
Entero subclass: #UnoEntero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!UnoEntero methodsFor: 'testing' stamp: 'cr 4/21/2021 18:49:44'!
isNegative
	^false! !

!UnoEntero methodsFor: 'testing' stamp: 'cr 4/20/2021 21:08:01'!
isOne
	^true! !

!UnoEntero methodsFor: 'testing' stamp: 'cr 4/21/2021 18:49:19'!
isZero
	^false! !


!UnoEntero methodsFor: 'initialization' stamp: 'cr 4/20/2021 20:20:48'!
initialize
	value := 1! !


!UnoEntero methodsFor: 'arithmetic operations' stamp: 'cr 4/20/2021 20:43:15'!
fibonacci! !


!UnoEntero methodsFor: 'private operations' stamp: 'cr 4/21/2021 20:28:32'!
divideByAnEntero: anEnteroDividend
	^ anEnteroDividend 
! !

!UnoEntero methodsFor: 'private operations' stamp: 'cr 4/21/2021 20:29:55'!
divideByAnUnreducibleEntero: aNumerator
	^ aNumerator 
	! !


!classDefinition: #ZeroEntero category: 'Numero-Exercise'!
Entero subclass: #ZeroEntero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!ZeroEntero methodsFor: 'arithmetic operations' stamp: 'cr 4/20/2021 20:48:01'!
fibonacci
	^ Entero with: 1! !


!ZeroEntero methodsFor: 'testing' stamp: 'cr 4/21/2021 18:52:53'!
isNegative
	^ false! !

!ZeroEntero methodsFor: 'testing' stamp: 'cr 4/21/2021 18:53:13'!
isOne
	^ false! !

!ZeroEntero methodsFor: 'testing' stamp: 'cr 4/20/2021 21:08:21'!
isZero
	^true! !


!ZeroEntero methodsFor: 'initialization' stamp: 'cr 4/20/2021 20:47:19'!
initialize
	value := 0! !


!ZeroEntero methodsFor: 'private operations' stamp: 'cr 4/21/2021 20:28:41'!
divideByAnEntero: anEnteroDividend
	self error: self class canNotDivideByZeroErrorDescription 
! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:57:58'!
addAFraccion: aFraccionAdder 

	| newNumerator newDenominator |
	newNumerator := (numerator * aFraccionAdder denominator) + (denominator * aFraccionAdder numerator).
	newDenominator := denominator * aFraccionAdder denominator.
	^newNumerator / newDenominator 
	
	! !

!Fraccion methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:55:14'!
addAnEntero: anEnteroAdder 

	^anEnteroAdder * denominator + numerator / denominator
	
	
	! !

!Fraccion methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:54:01'!
divideByAFraccion: aFraccionDivisor

	^( aFraccionDivisor numerator *  denominator) / (aFraccionDivisor denominator *  numerator)
	! !

!Fraccion methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:53:32'!
divideByAnEntero: anEnteroDivisor

	^ (anEnteroDivisor*denominator) / numerator .
	
	
	! !

!Fraccion methodsFor: 'private operations' stamp: 'DB 4/19/2021 23:52:20'!
multiplyByAFraction: aFraccionMultiplier

	^(numerator * aFraccionMultiplier numerator) / (denominator * aFraccionMultiplier denominator)
	! !

!Fraccion methodsFor: 'private operations' stamp: 'cr 4/21/2021 20:36:28'!
multiplyByAnEntero: anEnteroMultiplier 

	^anEnteroMultiplier * numerator / denominator 
	
! !

!Fraccion methodsFor: 'private operations' stamp: 'cr 4/21/2021 20:38:30'!
subtractByAnEntero: anEnteroMinuend 

	^(anEnteroMinuend * denominator) - numerator / denominator

	! !

!Fraccion methodsFor: 'private operations' stamp: 'cr 4/21/2021 20:38:07'!
subtractByAnFraccion: aFraccionMinuend 

	| newNumerator newDenominator |
	
	newNumerator := (denominator * aFraccionMinuend numerator) - (numerator * aFraccionMinuend denominator).
	newDenominator := denominator * aFraccionMinuend denominator.
	
	^newNumerator / newDenominator 
! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'DB 4/19/2021 23:52:20'!
* aMultiplier 

	^aMultiplier multiplyByAFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DB 4/19/2021 23:58:56'!
+ anAdder 

	^anAdder addAFraccion: self ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DB 4/19/2021 23:52:55'!
- aSubtrahend 

	^aSubtrahend subtractByAnFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DB 4/19/2021 23:54:01'!
/ aDivisor 

	^aDivisor divideByAFraccion: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'cr 4/21/2021 20:39:04'!
initializeWith: aNumerator over: aDenominator
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'DB 4/19/2021 20:51:29'!
isNegative
	
	^numerator isNegative ! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'cr 4/21/2021 19:51:27'!
with: aDividend over: aDivisor

	^self new initializeWith: aDividend over: aDivisor 
	! !
