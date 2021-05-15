!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'robot-moving-forward' stamp: 'crivera 5/14/2021 19:29:33'!
test02ProcessingForwardMustChangeRobotCoordinatesAsExpected
	
	self assertARobotFacing: #North process: 'f' modifiesItsPositionBy: 0@1 endFacing: #North
! !

!MarsRoverTest methodsFor: 'robot-moving-forward' stamp: 'crivera 5/14/2021 19:31:09'!
test03ProcessingForwardWhenFacingEastMustChangeRobotCoordinates
	
	self assertARobotFacing: #East process: 'f' modifiesItsPositionBy: 1@0 endFacing: #East
! !

!MarsRoverTest methodsFor: 'robot-moving-forward' stamp: 'crivera 5/14/2021 19:33:43'!
test04ProcessingForwardWhenFacingSouthMustChangeRobotCoordinates
	
	self assertARobotFacing: #South process: 'f' modifiesItsPositionBy: 0@-1 endFacing: #South
! !

!MarsRoverTest methodsFor: 'robot-moving-forward' stamp: 'crivera 5/14/2021 19:34:41'!
test05ProcessingForwardWhenFacingWestMustChangeRobotCoordinates
	
	self assertARobotFacing: #West process: 'f' modifiesItsPositionBy: -1@0 endFacing: #West
! !


!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 19:26:45'!
assertARobotFacing: initialFacing process: aCommand modifiesItsPositionBy: aCoordinateDelta endFacing: facing
	|coordinate robot|
	coordinate _ 10@10.
	robot _ MarsRover at: coordinate facing: initialFacing.
	
	robot interpretPackage: aCommand .
	
	self assert: (robot isAt: (coordinate + aCoordinateDelta) facing: facing)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 19:28:39'!
test01WhenProcessingEmtpyInstructionsMustRemainInPlace
	
	self assertARobotFacing: #North process: '' modifiesItsPositionBy: 0@0 endFacing: #North
	
	! !


!MarsRoverTest methodsFor: 'robot-rotating-rigth' stamp: 'crivera 5/14/2021 19:27:43'!
test06ProcessingRightRotationWhenFacingWestMustChangeRobotCardinalPoint
	
	self assertARobotFacing: #West process: 'r' modifiesItsPositionBy: 0@0 endFacing: #North! !

!MarsRoverTest methodsFor: 'robot-rotating-rigth' stamp: 'crivera 5/14/2021 19:26:45'!
test07ProcessingRightRotationWhenFacingNorthMustChangeRobotCardinalPoint

	self assertARobotFacing: #North process: 'r' modifiesItsPositionBy: 0@0 endFacing: #East

	
! !

!MarsRoverTest methodsFor: 'robot-rotating-rigth' stamp: 'crivera 5/14/2021 19:36:31'!
test08ProcessingRightRotationWhenFacingEastMustChangeRobotCardinalPoint

	self assertARobotFacing: #East process: 'r' modifiesItsPositionBy: 0@0 endFacing: #South

	
! !

!MarsRoverTest methodsFor: 'robot-rotating-rigth' stamp: 'crivera 5/14/2021 19:38:56'!
test09ProcessingRightRotationWhenFacingSouthMustChangeRobotCardinalPoint

	self assertARobotFacing: #South process: 'r' modifiesItsPositionBy: 0@0 endFacing: #West

	
! !


!MarsRoverTest methodsFor: 'robot-rotating-left' stamp: 'crivera 5/14/2021 19:41:47'!
test10ProcessingLeftRotationWhenFacingSouthMustChangeRobotCardinalPoint

	self assertARobotFacing: #South process: 'l' modifiesItsPositionBy: 0@0 endFacing: #East

	
! !

!MarsRoverTest methodsFor: 'robot-rotating-left' stamp: 'crivera 5/14/2021 19:49:41'!
test11ProcessingLeftRotationWhenFacingEastMustChangeRobotCardinalPoint

	self assertARobotFacing: #East process: 'l' modifiesItsPositionBy: 0@0 endFacing: #North

	
! !

!MarsRoverTest methodsFor: 'robot-rotating-left' stamp: 'crivera 5/14/2021 19:50:41'!
test12ProcessingLeftRotationWhenFacingNorthMustChangeRobotCardinalPoint

	self assertARobotFacing: #North process: 'l' modifiesItsPositionBy: 0@0 endFacing: #West

	
! !

!MarsRoverTest methodsFor: 'robot-rotating-left' stamp: 'crivera 5/14/2021 19:51:37'!
test13ProcessingLeftRotationWhenFacingWestMustChangeRobotCardinalPoint

	self assertARobotFacing: #West process: 'l' modifiesItsPositionBy: 0@0 endFacing: #South

	
! !


!MarsRoverTest methodsFor: 'robot-moving-backward' stamp: 'crivera 5/14/2021 19:56:41'!
test14WhenMovingBackwardsFacingNorthMustChangeItsCordinates
	
	self assertARobotFacing: #North process: 'b' modifiesItsPositionBy: 0@-1 endFacing: #North
	
	! !

!MarsRoverTest methodsFor: 'robot-moving-backward' stamp: 'crivera 5/14/2021 20:03:08'!
test15WhenMovingBackwardsFacingEastMustChangeItsCordinates
	
	self assertARobotFacing: #East process: 'b' modifiesItsPositionBy: -1@0 endFacing: #East
	
	! !

!MarsRoverTest methodsFor: 'robot-moving-backward' stamp: 'crivera 5/14/2021 20:03:44'!
test16WhenMovingBackwardsFacingSouthMustChangeItsCordinates
	
	self assertARobotFacing: #South process: 'b' modifiesItsPositionBy: 0@1 endFacing: #South
	
	
	
	! !

!MarsRoverTest methodsFor: 'robot-moving-backward' stamp: 'crivera 5/14/2021 20:05:42'!
test17WhenMovingBackwardsFacingWestMustChangeItsCordinates
	
	self assertARobotFacing: #West process: 'b' modifiesItsPositionBy: 1@0 endFacing: #West
	
	
	
	! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition cardinalPoint robotCommands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'crivera 5/14/2021 20:37:40'!
initializeAt: aCoordinate facing: aCoordinatePoint 
	currentPosition := aCoordinate.
	cardinalPoint := aCoordinatePoint.
	
	robotCommands := OrderedCollection new.
	
	RobotCommand subclasses do: [:commandClass | robotCommands add: (commandClass new) ]
! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 20:40:24'!
cardinalPoint
	^ cardinalPoint ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 21:15:47'!
cardinalPoint: aCardinalPoint
	 cardinalPoint _ aCardinalPoint ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 20:40:56'!
currentPosition
	^ currentPosition ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 21:07:33'!
interpretPackage: aString 
	aString isEmptyOrNil ifTrue: [^ self].
	
	robotCommands detect: [:robotCommand | robotCommand canHandle: aString ] ifFound: [:robotCommand | robotCommand doOn: self] ifNone: []
	
	
	
	
	
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 19:11:12'!
isAt: aCoordinate facing: aPosition 
	^ currentPosition = aCoordinate and: cardinalPoint = aPosition! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 20:45:05'!
moveBy: aDelta

	currentPosition _ currentPosition + aDelta ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'crivera 5/13/2021 21:44:08'!
at: aCoordinate facing: aCoordinatePoint 
	^self new initializeAt: aCoordinate facing: aCoordinatePoint ! !




!classDefinition: #RobotCommand category: 'MarsRover'!
Object subclass: #RobotCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RobotCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 20:51:59'!
canHandle: aCommandInstruction
	^ self myCommand = aCommandInstruction ! !

!RobotCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 20:38:15'!
doOn: aRobot
	self subclassResponsibility ! !

!RobotCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 20:25:30'!
myCommand
	self subclassResponsibility ! !


!classDefinition: #BackwardCommand category: 'MarsRover'!
RobotCommand subclass: #BackwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!BackwardCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 20:56:27'!
doOn: aRobot

		aRobot cardinalPoint = #North ifTrue: [aRobot moveBy: (0@-1)].
		aRobot cardinalPoint = #East ifTrue: [aRobot moveBy: (-1@0)].
		aRobot cardinalPoint = #South ifTrue: [aRobot moveBy: (0@1)].
		aRobot cardinalPoint = #West ifTrue: [aRobot moveBy: (1@0)]! !

!BackwardCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 20:53:46'!
myCommand
	^ 'b'! !


!classDefinition: #ForwardCommand category: 'MarsRover'!
RobotCommand subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!ForwardCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 20:44:20'!
doOn: aRobot
	
	aRobot cardinalPoint = #North ifTrue: [aRobot moveBy: (0@1)].
	aRobot cardinalPoint = #East ifTrue: [aRobot moveBy: (1@0)].
	aRobot cardinalPoint = #South ifTrue: [aRobot moveBy: (0@-1)].
	aRobot cardinalPoint = #West ifTrue: [aRobot moveBy: (-1@0)]! !

!ForwardCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 20:25:53'!
myCommand
	^ 'f'! !


!classDefinition: #LeftRotationCommand category: 'MarsRover'!
RobotCommand subclass: #LeftRotationCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!LeftRotationCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 21:11:01'!
doOn: aRobot

	aRobot cardinalPoint = #South ifTrue: [^aRobot cardinalPoint: #East].
	aRobot cardinalPoint = #East ifTrue: [^aRobot cardinalPoint: #North].
	aRobot cardinalPoint = #North ifTrue: [^aRobot cardinalPoint: #West].
	aRobot cardinalPoint = #West ifTrue: [^aRobot cardinalPoint: #South]! !

!LeftRotationCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 21:05:14'!
myCommand
	^ 'l'! !


!classDefinition: #RigthRotationCommand category: 'MarsRover'!
RobotCommand subclass: #RigthRotationCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RigthRotationCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 21:09:14'!
doOn: aRobot

	aRobot cardinalPoint = #West ifTrue: [^aRobot cardinalPoint: #North].
	aRobot cardinalPoint = #North ifTrue: [^aRobot cardinalPoint: #East].
	aRobot cardinalPoint = #East ifTrue: [^aRobot cardinalPoint: #South].
	aRobot cardinalPoint = #South ifTrue: [^aRobot cardinalPoint: #West]! !

!RigthRotationCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/14/2021 21:03:32'!
myCommand 

	^ 'r'! !
