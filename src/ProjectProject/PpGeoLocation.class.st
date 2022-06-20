Class {
	#name : #PpGeoLocation,
	#superclass : #Object,
	#instVars : [
		'latitude',
		'longitude'
	],
	#category : #'ProjectProject-Core'
}

{ #category : #accessing }
PpGeoLocation class >> fromCoreLocationCLIOutput: aString [

	| latLong |
	latLong := aString splitOn: ' '.
	^ self new
		latitude: latLong first;
		longitude: latLong second;
		yourself.
]

{ #category : #'as yet unclassified' }
PpGeoLocation >> distanceFrom: aPpGeoLocation [ 
	^ PBApplication uniqueInstance 
		sendSource: 'from geopy.distance import geodesic
here = (my_lat, my_long)
there = (r_lat, r_long)
geodesic(here, there).feet' 
		withBindings: {
			#my_lat -> self latitude.
			#my_long -> self longitude.
			#r_lat -> aPpGeoLocation latitude.
			#r_long -> aPpGeoLocation longitude }
]

{ #category : #accessing }
PpGeoLocation >> geoLocation [
	^ self
]

{ #category : #accessing }
PpGeoLocation >> latitude [

	^ latitude
]

{ #category : #accessing }
PpGeoLocation >> latitude: anObject [

	latitude := anObject
]

{ #category : #accessing }
PpGeoLocation >> longitude [

	^ longitude
]

{ #category : #accessing }
PpGeoLocation >> longitude: anObject [

	longitude := anObject
]

{ #category : #accessing }
PpGeoLocation >> showInGoogleMaps [
	| urlTemplate urlString |
	urlString := 'https://www.google.com/maps/search/?api=1'.
	urlString asUrl
		queryAt: 'query' put: self latitude, ',', self longitude;
		open.
		
	"URL format via SO https://stackoverflow.com/a/52943975"
]
