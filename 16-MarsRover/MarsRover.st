!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'crivera 5/13/2021 21:42:39'!
test01WhenProcessingEmtpyInstructionsMustRemainInPlace
	|coordinate robot position|
	coordinate _ 10@10.
	position _ #North.
	robot _ MarsRover at: coordinate facing: position.
	
	robot interpretPackage: ''.
	
	self assert: (robot isAt: coordinate facing: position)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'crivera 5/13/2021 21:52:42'!
test02ProcessingOneInstructionTowardsRobotPositionMustChangeRobotCoordinates
	|coordinate robot position|
	coordinate _ 10@10.
	position _ #North.
	robot _ MarsRover at: coordinate facing: position.
	
	robot interpretPackage: 'f'.
	
	self deny: (robot isAt: coordinate facing: position).
	self assert: (robot isAt: 10@11 facing: position)! !


!classDefinition: #Coordinate category: 'MarsRover'!
Object subclass: #Coordinate
	instanceVariableNames: 'x y'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Coordinate methodsFor: 'initialization' stamp: 'crivera 5/13/2021 21:27:51'!
initializeX: anXposition y: anYPosition 
	x := anXposition.
	y := anYPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Coordinate class' category: 'MarsRover'!
Coordinate class
	instanceVariableNames: ''!

!Coordinate class methodsFor: 'creation' stamp: 'crivera 5/13/2021 21:26:42'!
x: anXposition y: anYPosition 
	self new initializeX: anXposition y: anYPosition! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinate coordinatePoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'crivera 5/13/2021 21:30:37'!
initializeAt: aCoordinate facing: aCoordinatePoint 
	coordinate := aCoordinate.
	coordinatePoint := aCoordinatePoint.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'crivera 5/13/2021 22:03:28'!
interpretPackage: aString 
	aString isEmptyOrNil ifTrue: [^ self].
	coordinate := Point x: coordinate x y: coordinate y + 1! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'crivera 5/13/2021 21:57:58'!
isAt: aCoordinate facing: aPosition 
	^ coordinate = aCoordinate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'crivera 5/13/2021 21:44:08'!
at: aCoordinate facing: aCoordinatePoint 
	^self new initializeAt: aCoordinate facing: aCoordinatePoint ! !


