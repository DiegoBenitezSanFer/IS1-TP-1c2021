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

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 20:20:30'!
test18WhenRobotExecutesAnInvalidCommandItDoesNotChangeItsCoorditatesOrFacing
	|coordinate robot|
	coordinate _ 10@10.
	robot _ MarsRover at: coordinate facing: #North.

	self should: [robot interpretPackage: 'z' ] 
		raise: Error withMessageText: [^MarsRover invalidCommandErrorDescription].
		
	
	
	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 20:29:07'!
test19WhenProcessingMoreThanOneCommandMustChangeItsCordinates
	
	self assertARobotFacing: #West process: 'bb' modifiesItsPositionBy: 2@0 endFacing: #West
	
	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 20:36:33'!
test20WhenProcessingMoreThanOneCommandButOneCommandIsInvalidMustChangeItsCordinatesUntilTheInvalidCommand
	
	|coordinate robot|
	coordinate _ 10@10.
	robot _ MarsRover at: coordinate facing: #North.

	self should: [robot interpretPackage: 'bbzb' ] 
		raise: Error withMessageText: [^MarsRover invalidCommandErrorDescription].
		
	self assert:(robot isAt: 2@0 facing: #West)
	
	
	
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


!classDefinition: #FacingRobot category: 'MarsRover'!
Object subclass: #FacingRobot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingRobot methodsFor: 'private' stamp: 'crivera 5/16/2021 21:03:44'!
facing
	^self class facing
! !


!FacingRobot methodsFor: 'rotate' stamp: 'crivera 5/16/2021 19:47:30'!
rotateLeft: aRobot
	self subclassResponsibility 
! !

!FacingRobot methodsFor: 'rotate' stamp: 'crivera 5/16/2021 19:40:41'!
rotateRigth: aRobot
	self subclassResponsibility 
! !


!FacingRobot methodsFor: 'move' stamp: 'crivera 5/16/2021 18:55:28'!
moveBackward: aRobot
	self subclassResponsibility 
! !

!FacingRobot methodsFor: 'move' stamp: 'crivera 5/16/2021 19:38:12'!
moveForward: aRobot
	self subclassResponsibility 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FacingRobot class' category: 'MarsRover'!
FacingRobot class
	instanceVariableNames: ''!

!FacingRobot class methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 19:10:23'!
facing
	self subclassResponsibility ! !

!FacingRobot class methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 19:14:20'!
facingTo: aCoordinatePoint
	^ self facing = aCoordinatePoint
! !

!FacingRobot class methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 19:12:39'!
for: aCoordinatePoint
	self subclasses detect: [:subClass | subClass facingTo: aCoordinatePoint ] ifFound: [:subClass | ^ subClass new ] ifNone: []! !


!classDefinition: #EastFacingRobot category: 'MarsRover'!
FacingRobot subclass: #EastFacingRobot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastFacingRobot methodsFor: 'rotate' stamp: 'crivera 5/16/2021 19:52:59'!
rotateLeft: aRobot 
	aRobot cardinalPoint: NorthFacingRobot new! !

!EastFacingRobot methodsFor: 'rotate' stamp: 'crivera 5/16/2021 19:45:00'!
rotateRigth: aRobot 
	aRobot cardinalPoint: SouthFacingRobot new! !


!EastFacingRobot methodsFor: 'move' stamp: 'crivera 5/16/2021 19:29:53'!
moveBackward: aRobot

	aRobot moveBy: (-1@0)! !

!EastFacingRobot methodsFor: 'move' stamp: 'crivera 5/16/2021 19:36:30'!
moveForward: aRobot

	aRobot moveBy: (1@0)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EastFacingRobot class' category: 'MarsRover'!
EastFacingRobot class
	instanceVariableNames: ''!

!EastFacingRobot class methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 19:30:36'!
facing
	^ #East! !


!classDefinition: #NorthFacingRobot category: 'MarsRover'!
FacingRobot subclass: #NorthFacingRobot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthFacingRobot methodsFor: 'rotate' stamp: 'crivera 5/16/2021 19:51:22'!
rotateLeft: aRobot
	
	aRobot cardinalPoint: WestFacingRobot new! !

!NorthFacingRobot methodsFor: 'rotate' stamp: 'crivera 5/16/2021 19:43:14'!
rotateRigth: aRobot
	
	aRobot cardinalPoint: EastFacingRobot new! !


!NorthFacingRobot methodsFor: 'move' stamp: 'crivera 5/16/2021 18:55:07'!
moveBackward: aRobot
	
	aRobot moveBy: (0@-1)! !

!NorthFacingRobot methodsFor: 'move' stamp: 'crivera 5/16/2021 19:35:43'!
moveForward: aRobot
	
	aRobot moveBy: (0@1)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NorthFacingRobot class' category: 'MarsRover'!
NorthFacingRobot class
	instanceVariableNames: ''!

!NorthFacingRobot class methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 19:10:44'!
facing
	^ #North
! !


!classDefinition: #SouthFacingRobot category: 'MarsRover'!
FacingRobot subclass: #SouthFacingRobot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthFacingRobot methodsFor: 'rotate' stamp: 'crivera 5/16/2021 19:48:29'!
rotateLeft: aRobot 
	aRobot cardinalPoint: EastFacingRobot new! !

!SouthFacingRobot methodsFor: 'rotate' stamp: 'crivera 5/16/2021 19:46:02'!
rotateRigth: aRobot 
	aRobot cardinalPoint: WestFacingRobot new! !


!SouthFacingRobot methodsFor: 'move' stamp: 'crivera 5/16/2021 19:32:16'!
moveBackward: aRobot
	
	aRobot moveBy: (0@1)! !

!SouthFacingRobot methodsFor: 'move' stamp: 'crivera 5/16/2021 19:37:09'!
moveForward: aRobot
	
	aRobot moveBy: (0@-1)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SouthFacingRobot class' category: 'MarsRover'!
SouthFacingRobot class
	instanceVariableNames: ''!

!SouthFacingRobot class methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 19:31:18'!
facing
	^ #South! !


!classDefinition: #WestFacingRobot category: 'MarsRover'!
FacingRobot subclass: #WestFacingRobot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestFacingRobot methodsFor: 'rotate' stamp: 'crivera 5/16/2021 19:54:01'!
rotateLeft: aRobot 
	aRobot cardinalPoint: SouthFacingRobot new! !

!WestFacingRobot methodsFor: 'rotate' stamp: 'crivera 5/16/2021 19:41:13'!
rotateRigth: aRobot
	aRobot cardinalPoint: NorthFacingRobot new! !


!WestFacingRobot methodsFor: 'move' stamp: 'crivera 5/16/2021 19:33:45'!
moveBackward: aRobot
	aRobot moveBy: (1@0)! !

!WestFacingRobot methodsFor: 'move' stamp: 'crivera 5/16/2021 19:39:15'!
moveForward: aRobot
	aRobot moveBy: (-1@0)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WestFacingRobot class' category: 'MarsRover'!
WestFacingRobot class
	instanceVariableNames: ''!

!WestFacingRobot class methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 19:32:57'!
facing
	^ #West! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition robotCommands robotFacing'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'crivera 5/16/2021 20:51:52'!
initializeAt: aCoordinate facing: aCoordinatePoint 
	currentPosition := aCoordinate.
	robotFacing := FacingRobot for: aCoordinatePoint.
	
	robotCommands := OrderedCollection new.
	RobotCommand subclasses do: [:commandClass | robotCommands add: (commandClass new) ]
! !


!MarsRover methodsFor: 'robot-actions' stamp: 'crivera 5/16/2021 20:31:33'!
interpretPackage: commands 
	
	commands do: [:aCommand | self processCommand: aCommand]
	
	
	
	
	
	
	! !

!MarsRover methodsFor: 'robot-actions' stamp: 'crivera 5/16/2021 20:46:23'!
moveBackward
	robotFacing moveBackward: self! !

!MarsRover methodsFor: 'robot-actions' stamp: 'crivera 5/16/2021 20:46:23'!
moveForward
	robotFacing moveForward: self! !

!MarsRover methodsFor: 'robot-actions' stamp: 'crivera 5/16/2021 20:46:23'!
rotateLeft
	robotFacing rotateLeft: self! !

!MarsRover methodsFor: 'robot-actions' stamp: 'crivera 5/16/2021 20:46:23'!
rotateRigth
	robotFacing rotateRigth: self! !


!MarsRover methodsFor: 'private' stamp: 'crivera 5/16/2021 20:46:23'!
cardinalPoint: aCardinalPoint
	 robotFacing _ aCardinalPoint ! !

!MarsRover methodsFor: 'private' stamp: 'crivera 5/14/2021 20:45:05'!
moveBy: aDelta

	currentPosition _ currentPosition + aDelta ! !

!MarsRover methodsFor: 'private' stamp: 'crivera 5/16/2021 20:32:32'!
processCommand: aCommand
	robotCommands detect: [:robotCommand | robotCommand canHandle: aCommand ] 
		ifFound: [:robotCommand | robotCommand doOn: self] 
		ifNone: [^self error: self class invalidCommandErrorDescription ]! !


!MarsRover methodsFor: 'testing' stamp: 'crivera 5/16/2021 21:02:51'!
isAt: aCoordinate facing: aPosition 
	^ currentPosition = aCoordinate and: robotFacing facing = aPosition! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'crivera 5/13/2021 21:44:08'!
at: aCoordinate facing: aCoordinatePoint 
	^self new initializeAt: aCoordinate facing: aCoordinatePoint ! !


!MarsRover class methodsFor: 'error-descriptions' stamp: 'crivera 5/16/2021 20:10:59'!
invalidCommandErrorDescription
	^ 'invalid command'! !


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

!BackwardCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 20:39:26'!
doOn: aRobot

	aRobot moveBackward
		
		! !

!BackwardCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 20:33:05'!
myCommand
	^ $b! !


!classDefinition: #ForwardCommand category: 'MarsRover'!
RobotCommand subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!ForwardCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 19:37:38'!
doOn: aRobot
	
	aRobot moveForward! !

!ForwardCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 20:33:17'!
myCommand
	^ $f! !


!classDefinition: #LeftRotationCommand category: 'MarsRover'!
RobotCommand subclass: #LeftRotationCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!LeftRotationCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 19:54:10'!
doOn: aRobot
	
	aRobot rotateLeft! !

!LeftRotationCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 20:33:27'!
myCommand
	^ $l! !


!classDefinition: #RigthRotationCommand category: 'MarsRover'!
RobotCommand subclass: #RigthRotationCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RigthRotationCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 19:45:32'!
doOn: aRobot
	
	aRobot rotateRigth! !

!RigthRotationCommand methodsFor: 'as yet unclassified' stamp: 'crivera 5/16/2021 20:33:35'!
myCommand 

	^ $r! !
