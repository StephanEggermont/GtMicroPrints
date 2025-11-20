Class {
	#name : 'BaselineOfGtMicroPrints',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGtMicroPrints',
	#package : 'BaselineOfGtMicroPrints'
}

{ #category : 'loading' }
BaselineOfGtMicroPrints class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'GtMicroPrints' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : 'baseline' }
BaselineOfGtMicroPrints >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GtMicroPrints'
		]
]
