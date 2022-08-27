"
Powered by <https://github.com/sivel/speedtest-cli> (Python API)
"
Class {
	#name : #PpInternetRequirement,
	#superclass : #PpProjectRequirement,
	#category : #'ProjectProject-Core-Projects'
}

{ #category : #accessing }
PpInternetRequirement >> isConnected [

	| pySource |
	pySource := 'import speedtest
s = speedtest.Speedtest()'.

	[ 
		PBApplication uniqueInstance newCommandSourceFactory
			source: pySource;
			sendAndWait.
		^ true ]
 	on: PBPythonError
 	do: [ :e | ^ false ].
]

{ #category : #accessing }
PpInternetRequirement >> isHighSpeed [

	| downloadBitsPerSecond oneHundredGb pySource |
	
	pySource := 'import speedtest
s = speedtest.Speedtest()
s.download()'.

	downloadBitsPerSecond := PBApplication uniqueInstance newCommandSourceFactory
	source: pySource;
	sendAndWait.
	
	"Picked at random"
	oneHundredGb := 100 * 1000 * 1000.
	
	^ downloadBitsPerSecond > oneHundredGb
]
