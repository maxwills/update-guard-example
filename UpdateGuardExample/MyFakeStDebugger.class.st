Class {
	#name : #MyFakeStDebugger,
	#superclass : #Object,
	#instVars : [
		'actionModel'
	],
	#category : #UpdateGuardExample
}

{ #category : #'as yet unclassified' }
MyFakeStDebugger class >> usageExample [

	"open the transcript and observe it"

	<script>
	| stDeb |
	stDeb := self new.
	"each of the following two calls will trigger the update event"
	Transcript
		show: 'callling now: stDeb stepInto, twice';
		cr.
	stDeb stepInto.
	stDeb stepInto.
	"The following call will trigger the update event only once (event if it internally uses stepInto)"
	Transcript
		show: 'callling now: stDeb stepIntoRepeatedly:';
		cr.
	stDeb stepIntoRepeatedly: 5
]

{ #category : #accessing }
MyFakeStDebugger >> actionModel [

	^ actionModel
]

{ #category : #accessing }
MyFakeStDebugger >> actionModel: anObject [

	actionModel := anObject
]

{ #category : #'as yet unclassified' }
MyFakeStDebugger >> actionModelUpdated [

	Transcript
		show: 'ActionModel has been updated';
		cr
]

{ #category : #initialization }
MyFakeStDebugger >> initialize [

	actionModel := MyActionModel new.
	actionModel addUpdateListener: [ self actionModelUpdated ]
]

{ #category : #actions }
MyFakeStDebugger >> stepInto [

	actionModel stepInto
]

{ #category : #actions }
MyFakeStDebugger >> stepIntoRepeatedly: nTimes [

	"Here we use the update guard. Normally each stepInto call should raise the update event.
	But in this case, it will perform it just at the end"
	actionModel preventUpdatesDuring: [
		 nTimes timesRepeat: [ actionModel stepInto ] 	]
]
