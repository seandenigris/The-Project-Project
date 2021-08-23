Extension { #name : 'True' }

{ #category : '*ProjectProject' }
True >> ppAsCompletionTimestamp [
	"Pharo's Date offset support is fatally broken. See [Pharo Issue 12147: Date>>#= fooled by daylight savings time](https://pharo.fogbugz.com/default.asp?12147)"
	^ DateAndTime now translateToUTC
]
