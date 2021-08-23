Class {
	#name : 'PpCsvParsingSpecification',
	#superclass : 'TestCase',
	#category : 'ProjectProject-Specification'
}

{ #category : 'as yet unclassified' }
PpCsvParsingSpecification >> testOutcomeWithoutAction [
	| record fields |
	record := '7/11/16		W/F:Miley 7/12	Get new buyout calculation and explanation of formula			'.
	fields := (NeoCSVReader on: record readStream)
		separator: Character tab;
		next.
]
