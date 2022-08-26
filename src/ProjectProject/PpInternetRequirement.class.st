Class {
	#name : #PpInternetRequirement,
	#superclass : #PpProjectRequirement,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpInternetRequirement >> isHighSpeed [

	| downloadBitsPerSecond oneHundredGb |
	downloadBitsPerSecond := PBApplication uniqueInstance newCommandSourceFactory
	source: 'import speedtest
s = speedtest.Speedtest()
s.download()';
	sendAndWait.
	
	"Picked at random"
	oneHundredGb := 100 * 1000 * 1000.
	
	^ downloadBitsPerSecond > oneHundredGb
]
