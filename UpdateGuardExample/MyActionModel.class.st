Class {
	#name : #MyActionModel,
	#superclass : #Object,
	#instVars : [
		'updateEventListeners',
		'preventUpdate'
	],
	#category : #UpdateGuardExample
}

{ #category : #adding }
MyActionModel >> addUpdateListener: aBlock [

	updateEventListeners add: aBlock
]

{ #category : #initialization }
MyActionModel >> initialize [

	updateEventListeners := OrderedCollection new.
	preventUpdate := false
]

{ #category : #'as yet unclassified' }
MyActionModel >> preventUpdatesDuring: aBlock [

	"Sets the prevent update flag during the execution of a block. Restores its value after the block finishes"

	| oldEventFlag |
	oldEventFlag := preventUpdate.
	preventUpdate := true.
	[ aBlock value.
	  self update ] ensure: [ preventUpdate := oldEventFlag ]
]

{ #category : #'as yet unclassified' }
MyActionModel >> raiseUpdateEvents [

	"Notify the listeners of the update event"

	updateEventListeners do: [ :each | each value ]
]

{ #category : #actions }
MyActionModel >> stepInto [

	"
	Do whatever needs to be done here. eg,
	self session step"

	self updateIfAble
]

{ #category : #updating }
MyActionModel >> update [

	"this method updates the topContext among other things. 
	Note that the only method that calls this is updateIfAble."

	self raiseUpdateEvents
]

{ #category : #updating }
MyActionModel >> updateIfAble [

	"If the updates are not suppressed, calls the update method"

	preventUpdate ifFalse: [ self update ]
]
