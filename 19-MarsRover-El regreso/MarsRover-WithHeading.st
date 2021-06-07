!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:26'!
test01

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:31'!
test02

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:34'!
test03

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:38'!
test04

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:45'!
test05

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:50'!
test06

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:54'!
test07

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:59'!
test08

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:06'!
test09

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:12'!
test10

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:20'!
test11

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:25'!
test12

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 1@1 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:29'!
test13

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:33'!
test14

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 0@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:37'!
test15

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/2/2018 16:27:43'!
test16

	self 
		should: [MarsRover at: 1@2 heading: #X ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: MarsRover invalidCardinalPointErrorDescription equals: anError messageText ]! !


!classDefinition: #ObserversTest category: 'MarsRover-WithHeading'!
TestCase subclass: #ObserversTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ObserversTest methodsFor: 'heading logger' stamp: 'DB 6/6/2021 21:31:10'!
test04LeftRotateInTheHeadingLoggerShouldLogWestCardinalPoint

	| marsRover log |
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverHeadingLogger new.	
	
	marsRover addHeadingObserver: log.
	marsRover process: 'l'.
		
	self assert: 1 equals: log size.
	self assert: 'West' equals: log first.! !

!ObserversTest methodsFor: 'heading logger' stamp: 'DB 6/6/2021 21:34:14'!
test05LeftRotationShouldLogOnlyOnHeadingChanges

	| marsRover log |
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverHeadingLogger new.	
	
	marsRover addHeadingObserver: log.
	marsRover process: 'lf'.
		
	self assert: 1 equals: log size.
	self assert: 'West' equals: log first.! !

!ObserversTest methodsFor: 'heading logger' stamp: 'DB 6/6/2021 21:40:26'!
test07RightRotationShouldLogOnlyOnHeadingChanges

	| marsRover log |
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverHeadingLogger new.	
	
	marsRover addHeadingObserver: log.
	marsRover process: 'rf'.
		
	self assert: 1 equals: log size.
	self assert: 'East' equals: log first.! !


!ObserversTest methodsFor: 'loggers' stamp: 'DB 6/6/2021 21:40:12'!
test06EachLoggerShouldOnlyLogTheirLoggingrEvents

	| marsRover logHeading logPosition |
	marsRover := MarsRover at: 1@1 heading: #North.
	
	logHeading := MarsRoverHeadingLogger new.	
	logPosition := MarsRoverPositionLogger new.
	
	marsRover addPositionObserver: logPosition.
	marsRover addHeadingObserver: logHeading.
	marsRover process: 'fl'.
		
	self assert: 1 equals: logHeading size.
	self assert: 'West' equals: logHeading first.
	
	self assert: 1 equals: logPosition size.
	self assert: '1@2' equals: logPosition first.
	
	"
	- HeadingObservers
	- PositionObservers.
	"! !

!ObserversTest methodsFor: 'loggers' stamp: 'DB 6/6/2021 21:40:36'!
test08MarsRoverLoggerShouldLogHeadingAndPosition

	| marsRover log |
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverLogger new.	
	
	marsRover addObserver: log.
	marsRover process: 'r'.
		
	self assert: 1 equals: log size.
	self assert: 'heading:East,position:1@1' equals: log first.! !

!ObserversTest methodsFor: 'loggers' stamp: 'DB 6/6/2021 21:40:44'!
test09MarsRoverLoggerShouldLogEveryMovement

	| marsRover log |
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverLogger new.	
	
	marsRover addObserver: log.
	marsRover process: 'lbrf'.
		
	self assert: 4 equals: log size.
	self assert: 'heading:West,position:1@1' equals: log first.
	self assert: 'heading:West,position:2@1' equals: (log at:2).
	self assert: 'heading:North,position:2@1' equals: (log at:3).
	self assert: 'heading:North,position:2@2' equals: (log at:4).! !


!ObserversTest methodsFor: 'window' stamp: 'DB 6/6/2021 21:41:05'!
test10WindowLoggerShouldLogAEvent

	| marsRover log |
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverWindow new.	
	
	marsRover addObserver: log.
	marsRover process: 'l'.
		
	self assert: 1@1 equals: log position.
	self assert: 'West' equals: log heading.! !

!ObserversTest methodsFor: 'window' stamp: 'DB 6/6/2021 21:41:11'!
test11MarsRoverWindowShouldHaveLastPosition

	| marsRover log |
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverWindow new.	
	
	marsRover addObserver: log.
	marsRover process: 'ffl'.
		
	self assert: 1@3 equals: log position.
	self assert: 'West' equals: log heading.! !


!ObserversTest methodsFor: 'position logger' stamp: 'DB 6/6/2021 21:23:30'!
test01ForwardPositionLoggerShouldLogOnlyPositionMovement

	| marsRover log |
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverPositionLogger new.	
	
	marsRover addPositionObserver: log.
	marsRover process: 'f'.
		
	self assert: 1 equals: log size.
	self assert: '1@2' equals: log first.! !

!ObserversTest methodsFor: 'position logger' stamp: 'DB 6/6/2021 21:25:10'!
test02PositionLoggerShouldLogOnlyOnPositionChange

	| marsRover log |
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverPositionLogger new.	
	
	marsRover addPositionObserver: log.
	marsRover process: 'fl'.
		
	self assert: 1 equals: log size.
	self assert: '1@2' equals: log first.! !

!ObserversTest methodsFor: 'position logger' stamp: 'DB 6/6/2021 21:27:52'!
test03MoreThanOneMovementSholdLogAllPositions

	| marsRover log |
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverPositionLogger new.	
	
	marsRover addPositionObserver: log.
	marsRover process: 'flb'.
		
	self assert: 2 equals: log size.
	self assert: '1@2' equals: log first.
	self assert: '2@2' equals: (log at: 2).! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'DB 6/6/2021 21:43:24'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	
	observers := Dictionary new.
	observers at: #position put: OrderedCollection new.
	observers at: #heading put: OrderedCollection new.
	observers at: #all put: OrderedCollection new.
	! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:14:20'!
headEast
	
	head := MarsRoverHeadingEast new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:16:30'!
headNorth
	
	head := MarsRoverHeadingNorth new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:16:05'!
headSouth
	
	head := MarsRoverHeadingSouth new! !

!MarsRover methodsFor: 'heading' stamp: 'DB 6/6/2021 19:14:58'!
headWest
	
	head := MarsRoverHeadingWest new.
	! !

!MarsRover methodsFor: 'heading' stamp: 'DB 6/6/2021 21:43:37'!
printHeading

	^head printHeading .! !

!MarsRover methodsFor: 'heading' stamp: 'DB 6/6/2021 21:43:42'!
rotateLeft
	
	head rotateLeft: self.! !

!MarsRover methodsFor: 'heading' stamp: 'DB 6/6/2021 21:43:45'!
rotateRight
	
	head rotateRight: self.! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 8/22/2019 12:00:30'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ head isHeading: aCardinalPoint ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'DB 6/6/2021 20:54:08'!
changePositionBy: aDelta
	
	position := position + aDelta.
	! !

!MarsRover methodsFor: 'moving' stamp: 'DB 6/6/2021 19:09:21'!
moveBackward
	
	head moveBackward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'DB 6/6/2021 19:10:58'!
moveEast
	
	self changePositionBy: (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'DB 6/6/2021 19:11:34'!
moveForward
	
	head moveForward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'DB 6/6/2021 19:11:12'!
moveNorth
	
	self changePositionBy:  (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'DB 6/6/2021 19:11:21'!
moveSouth
	
	self changePositionBy: (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'DB 6/6/2021 19:11:26'!
moveWest
	
	self changePositionBy: (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'DB 6/6/2021 20:28:04'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | | tags | 
		tags := self processCommand: aCommand.
		self notifyObserversFor: tags.
	].
	
	
! !

!MarsRover methodsFor: 'command processing' stamp: 'DB 6/6/2021 21:22:00'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ self moveForward. ^self positionObserverTags ].
	(self isBackwardCommand: aCommand) ifTrue: [ self moveBackward. ^self positionObserverTags ].
	(self isRotateRightCommand: aCommand) ifTrue: [ self rotateRight. ^self rotationObserverTags ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ self rotateLeft. ^self rotationObserverTags ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observers - private' stamp: 'DB 6/6/2021 21:08:25'!
addObserver: aObserver for: tag

	| taggedObs |
	taggedObs := observers at: tag .
	taggedObs add: aObserver.
	observers at: tag put: taggedObs.! !

!MarsRover methodsFor: 'observers - private' stamp: 'DB 6/6/2021 21:17:16'!
notifyObservers: observersToNotify
	
	observersToNotify do: [ :taggedObserver | taggedObserver update: self]				



! !

!MarsRover methodsFor: 'observers - private' stamp: 'DB 6/6/2021 21:12:42'!
notifyObserversFor: tags
	
	tags do: [:tag | self notifyObservers: (observers at: tag)]



! !

!MarsRover methodsFor: 'observers - private' stamp: 'DB 6/6/2021 21:21:12'!
positionObserverTags

	^OrderedCollection with:#position with:#all! !

!MarsRover methodsFor: 'observers - private' stamp: 'DB 6/6/2021 21:21:07'!
rotationObserverTags

	^OrderedCollection with:#heading with:#all! !


!MarsRover methodsFor: 'observers' stamp: 'DB 6/6/2021 21:09:10'!
addHeadingObserver: aHeadingObserver 

	self addObserver: aHeadingObserver for: #heading
! !

!MarsRover methodsFor: 'observers' stamp: 'DB 6/6/2021 21:08:49'!
addObserver: aMarsRoverObserver

	self addObserver: aMarsRoverObserver for: #all! !

!MarsRover methodsFor: 'observers' stamp: 'DB 6/6/2021 21:09:29'!
addPositionObserver: aPositionObserver 

	self addObserver: aPositionObserver for: #position! !


!MarsRover methodsFor: 'position' stamp: 'DB 6/6/2021 21:44:36'!
position

	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:01:48'!
at: aPosition heading: aCardinalPoint
	
	^self new initializeAt: aPosition heading: (MarsRoverHeading heading: aCardinalPoint)! !

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:06:17'!
rotateLeft: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:08:23'!
rotateRight: aMarsRover

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 7/2/2018 19:07:42'!
isHeading: aCardinalPoint

	^self class isFor: aCardinalPoint! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:54'!
moveForward: aMarsRover

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'as yet unclassified' stamp: 'DB 6/6/2021 19:47:43'!
printHeading
	^self class cardinalPoint asString ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'cardinal point' stamp: 'HAW 7/2/2018 19:07:01'!
cardinalPoint

	self subclassResponsibility ! !


!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:02:00'!
heading: aCardinalPoint

	^self subclasses 
		detect: [ :aMarsRoverPositionClass | aMarsRoverPositionClass isFor: aCardinalPoint ]
		ifFound: [ :aMarsRoverPositionClass | aMarsRoverPositionClass new ]
		ifNone: [ self error: MarsRover invalidCardinalPointErrorDescription ]! !


!MarsRoverHeading class methodsFor: 'testing' stamp: 'HAW 7/2/2018 17:01:33'!
isFor: aCardinalPoint

	^self cardinalPoint = aCardinalPoint ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:19'!
moveBackward: aMarsRover
	
	^aMarsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:28'!
moveForward: aMarsRover
	
	^aMarsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:42'!
rotateLeft: aMarsRover
	
	^aMarsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:54'!
rotateRight: aMarsRover
	
	^aMarsRover headSouth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingEast class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingEast class
	instanceVariableNames: ''!

!MarsRoverHeadingEast class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:01:53'!
cardinalPoint

	^#East! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:12'!
moveBackward: aMarsRover
	
	^aMarsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:23'!
moveForward: aMarsRover
	
	^aMarsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:40'!
rotateLeft: aMarsRover
	
	^aMarsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:51'!
rotateRight: aMarsRover
	
	^aMarsRover headEast! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingNorth class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadingNorth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:11'!
cardinalPoint

	^#North! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:15'!
moveBackward: aMarsRover
	
	^aMarsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:25'!
moveForward: aMarsRover
	
	^aMarsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:55'!
rotateLeft: aMarsRover
	
	^aMarsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:50'!
rotateRight: aMarsRover
	
	^aMarsRover headWest! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingSouth class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadingSouth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:17'!
cardinalPoint

	^#South! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:07'!
moveBackward: aMarsRover

	^aMarsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:15'!
moveForward: aMarsRover
	
	^aMarsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:26'!
rotateLeft: aMarsRover
	
	^aMarsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:41'!
rotateRight: aMarsRover
	
	^aMarsRover headNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'as yet unclassified' stamp: 'DB 6/6/2021 20:57:52'!
update: aMarsRover
	self subclassResponsibility .
! !


!classDefinition: #MarsRoverLoggingObserver category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverLoggingObserver
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggingObserver methodsFor: 'initialization' stamp: 'DB 6/6/2021 21:00:32'!
initialize
	log := OrderedCollection new.! !


!MarsRoverLoggingObserver methodsFor: 'accesing' stamp: 'DB 6/6/2021 21:00:20'!
at: aPosition
	^log at: aPosition.! !

!MarsRoverLoggingObserver methodsFor: 'accesing' stamp: 'DB 6/6/2021 21:00:26'!
first
	^log first.! !

!MarsRoverLoggingObserver methodsFor: 'accesing' stamp: 'DB 6/6/2021 21:00:39'!
size
	^log size.! !


!classDefinition: #MarsRoverHeadingLogger category: 'MarsRover-WithHeading'!
MarsRoverLoggingObserver subclass: #MarsRoverHeadingLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingLogger methodsFor: 'as yet unclassified' stamp: 'DB 6/6/2021 20:10:43'!
update: aMarsRover

	log add: aMarsRover printHeading.
	! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverLoggingObserver subclass: #MarsRoverLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'DB 6/6/2021 20:12:32'!
update: aMarsRover

	log add: ('heading:',aMarsRover printHeading,',position:',aMarsRover position asString)! !


!classDefinition: #MarsRoverPositionLogger category: 'MarsRover-WithHeading'!
MarsRoverLoggingObserver subclass: #MarsRoverPositionLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!


!MarsRoverPositionLogger methodsFor: 'as yet unclassified' stamp: 'DB 6/6/2021 20:07:24'!
update: aMarsRover

	log add: aMarsRover position asString.
! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverWindow
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'DB 6/6/2021 20:15:03'!
update: aMarsRover
	position := aMarsRover position.
	heading := aMarsRover printHeading.! !


!MarsRoverWindow methodsFor: 'position' stamp: 'DB 6/6/2021 19:42:57'!
position
	^position! !


!MarsRoverWindow methodsFor: 'heading' stamp: 'DB 6/6/2021 19:48:47'!
heading
	^heading! !
