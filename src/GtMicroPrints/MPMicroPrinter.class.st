Class {
	#name : 'MPMicroPrinter',
	#superclass : 'Object',
	#instVars : [
		'maxHeight',
		'maxWidth',
		'root',
		'directory',
		'extensions',
		'selectBlock',
		'classes',
		'directories'
	],
	#category : 'GtMicroPrints-Model',
	#package : 'GtMicroPrints',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
MPMicroPrinter class >> root: aString [ 
	^self new
		root: aString asFileReference;
		yourself
]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> allFilesIn: aRelativePathString ofType: anExtension [
	^self allFilesIn: aRelativePathString ofTypes: {anExtension} that:self defaultSelectBlock.

]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> allFilesIn: aRelativePathString ofType: anExtension that: aBlock [
	directory := root / aRelativePathString.
	extension := anExtension.
	selectBlock := aBlock.
	^self mondrianView 
]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> allFilesIn: aRelativePathString ofTypes: anExtensionArray [
	^self allFilesIn: aRelativePathString ofTypes: anExtensionArray that:self defaultSelectBlock.

]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> allFilesIn: aRelativePathString ofTypes: anExtensionArray that: aBlock [
	directory := root / aRelativePathString.
	extensions := anExtensionArray.
	selectBlock := aBlock.
	^self mondrianView 
]

{ #category : 'accessing' }
MPMicroPrinter >> classes [
	^ classes
]

{ #category : 'accessing' }
MPMicroPrinter >> classes: anObject [
	classes := anObject
]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> createForm: source [
	|sourceForm height width|
	height := source lines size.
	height = 0 ifTrue: [width := 0]
	ifFalse: [
		width := source lines max: [:line | line size]].
	height > maxHeight ifTrue: [height := maxHeight].
	width > maxWidth ifTrue: [width := maxWidth].
	sourceForm := Form extent: (width+1)@(height+1) depth: 32.
	source lines withIndexDo: [:line :y |
		line withIndexDo: [:ch :x |
			(x < maxWidth) & (y<maxHeight) ifTrue: [
			(#($( $) $[ $] ${ $}) includes: ch)ifTrue:
				[sourceForm colorAt: x@y put: Color orange].
			ch isLetter ifTrue: [
				sourceForm colorAt: x@y put: Color blue].
			ch isDigit ifTrue: [
				sourceForm colorAt: x@y put: Color green]
			] ifFalse: [ sourceForm colorAt: (x min:maxWidth)@(y min:maxHeight) put: Color red].
			]].
	^sourceForm
]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> defaultMaxHeight [
	^1000
]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> defaultMaxWidth [
	^120
]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> defaultSelectBlock [
	^ [ :aCollection | aCollection ]
]

{ #category : 'accessing' }
MPMicroPrinter >> directories [
	^ directories
]

{ #category : 'accessing' }
MPMicroPrinter >> directories: anObject [
	directories := anObject
]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> findEncodingFor: aFileReference [
	^[aFileReference binaryReadStreamDo: [ :in | 
		(ZnCharacterEncoder detectEncoding: in upToEnd) identifier ]] 
		on: ZnCharacterEncodingError
		do: [ :ex | ex return: 'utf-8' ]
]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> initialize [
	selectBlock := self defaultSelectBlock.
	maxHeight := self defaultMaxHeight.
	maxWidth := self defaultMaxWidth.
]

{ #category : 'accessing' }
MPMicroPrinter >> maxHeight [
	^ maxHeight
]

{ #category : 'accessing' }
MPMicroPrinter >> maxHeight: anObject [
	maxHeight := anObject
]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> mondrianMultiDirView [
	|view |
	view := GtMondrian new.
	view nodes
		shape: [:aDirectory | GtMondrianUMLClassElement withDefaultContainer
		label: (aDirectory pathString)];
		with: directories;
		forEach: [:dir |
			view nodes
				shape: [:aFile | GtMondrianUMLClassElement withDefaultContainer
				label: (aFile basename)];
			with: (selectBlock value: ((dir ) allFiles select: [:each | each extension = extension])) ;
			forEach: [:file |
				view nodes
					shape: [:fi | |enc|
						enc := self findEncodingFor: file.
						(self createForm: (file readStreamEncoded: enc do: [:stream | stream contents])) asElement];
					with: {file}].
			view layout rectanglePack].
			view layout rectanglePack.
		^view
]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> mondrianView [
	|view |
	view := GtMondrian new.
	view nodes
		shape: [:aFile | GtMondrianUMLClassElement withDefaultContainer
		label: (aFile basename)];
	with: (selectBlock value: ((directory ) allFiles select: [:each | extensions includes: each extension])) ;
	forEach: [:file |
		view nodes
			shape: [:fi | |enc|
				enc := self findEncodingFor: file.
				(self createForm: (file readStreamEncoded: enc do: [:stream | stream contents])) asElement];
			with: {file}].
	view layout rectanglePack.
^view
]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> mondrianViewOnClasses [
	|view |
	view := GtMondrian new.
	view nodes
		shape: [:aClass | GtMondrianUMLClassElement withDefaultContainer
		label: (aClass name)];
	with: classes;
	forEach: [:class |
		view nodes
			shape: [:fi | 
				(self createForm: (String streamContents: [:s |
					fi fileOutOn: s])) asElement];
			with: {class}].
	view layout rectanglePack.
^view
]

{ #category : 'as yet unclassified' }
MPMicroPrinter >> mondrianViewOnSmaCCParsers [
	|view |
	view := GtMondrian new.
	view nodes
		shape: [:aClass | GtMondrianUMLClassElement withDefaultContainer
		label: (aClass name)];
	with: classes;
	forEach: [:class |
		view nodes
			shape: [:fi | 
				(self createForm: ((fi respondsTo: #parserDefinitionString) ifTrue: [fi parserDefinitionString,' '] ifFalse: ['Abstract'])) asElement];
			with: {class}].
	view layout rectanglePack.
^view
]

{ #category : 'accessing' }
MPMicroPrinter >> root [
	^ root
]

{ #category : 'accessing' }
MPMicroPrinter >> root: aFileReference [
	root := aFileReference
]

{ #category : 'accessing' }
MPMicroPrinter >> selectBlock [
	^ selectBlock
]

{ #category : 'accessing' }
MPMicroPrinter >> selectBlock: anObject [
	selectBlock := anObject
]
