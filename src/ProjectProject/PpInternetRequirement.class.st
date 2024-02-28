"
Powered by <https://github.com/sivel/speedtest-cli> (Python API)
"
Class {
	#name : #PpInternetRequirement,
	#superclass : #PpProjectCondition,
	#category : #'ProjectProject-Core-Projects-Support'
}

{ #category : #'instance creation' }
PpInternetRequirement class >> fromString: aString [
	^ self new
]

{ #category : #accessing }
PpInternetRequirement >> isConnected [

	| pySource |
	pySource := 'import speedtest
s = speedtest.Speedtest()'.

	^ [ 
		PBApplication uniqueInstance newCommandSourceFactory
			source: pySource;
			sendAndWait.
		true ]
 	on: PharoLinkRemoteError
 	do: [ :e | false ].
]

{ #category : #accessing }
PpInternetRequirement >> isHighSpeed [

	| downloadBitsPerSecond oneHundredGb pySource |
	
	pySource := 'import speedtest
s = speedtest.Speedtest()
s.download()'.

	downloadBitsPerSecond := PBApplication uniqueInstance newCommandSourceFactory
		sourceWithResult: pySource;
		sendAndWait.
	
	"Picked at random"
	oneHundredGb := 100 * 1000 * 1000.
	
	^ downloadBitsPerSecond > oneHundredGb
]
