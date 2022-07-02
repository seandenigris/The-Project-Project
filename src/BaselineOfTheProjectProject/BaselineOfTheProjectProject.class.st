Class {
	#name : #BaselineOfTheProjectProject,
	#superclass : #BaselineOf,
	#category : #BaselineOfTheProjectProject
}

{ #category : #testing }
BaselineOfTheProjectProject class >> isDynabook [
	^ true
]

{ #category : #baselines }
BaselineOfTheProjectProject >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'BookmarkMagic' with: [
				spec repository: 'github://seandenigris/Bookmark-Magic' ];
			baseline: 'ExternalWebBrowser' with: [
				spec repository: 'github://seandenigris/Pharo-Web-Browser' ];
			baseline: 'Magritte' with: [
				spec repository: 'github://seandenigris/Magritte' ];
			baseline: 'Mocketry' with: [
				spec repository: 'github://dionisiydk/Mocketry' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'QuoteMe' with: [
				spec repository: 'github://seandenigris/Quote-Me' ];
			baseline: 'ResourcesLive' with: [
				spec
					repository: 'github://seandenigris/Resources-Live' ];
			baseline: 'SimplePersistence' with: [
				spec
					repository: 'github://seandenigris/Simple-Persistence' ];
			baseline: 'TrackingNumbers' with: [
				spec repository: 'github://seandenigris/Tracking-St' ].
		spec
			"package: #'Spec-PolyWidgets' with: [
				spec
					repository: 'http://smalltalkhub.com/mc/SeanDeNigris/SeansOutbox/main/' ];"
			baseline: 'ObjectiveLepiter' with: [
				spec repository: 'github://seandenigris/Objective-Lepiter' ];
			package: #ProjectProject with: [
				spec requires: #('BookmarkMagic' 'ExternalWebBrowser' 'Magritte' 'Mocketry' 'PharoEnhancements' 'QuoteMe' 'ResourcesLive' 'SimplePersistence' "'Spec-PolyWidgets'" 'TrackingNumbers'). ]. ].
				
	spec for: #GToolkit do: [ 
		spec package: 'ProjectProject-GToolkit' with: [ spec requires: #(ObjectiveLepiter ProjectProject) ] ]
]

{ #category : #accessing }
BaselineOfTheProjectProject >> customProjectAttributes [

	^ self isGTImage
			ifTrue: [ #(GToolkit) ]
			ifFalse: [ #(notGToolkit) ].
			
	"This is just for code generation purposes. To have an effect, it needs to be on the instance-side, but that could hide problems in other baselines because DeNigrisPreferences is not guaranteed to be loaded"
]

{ #category : #testing }
BaselineOfTheProjectProject >> isGTImage [
	
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'Lepiter-' ].
	"Implementation note: used to check for GToolkit prefix, but P7 has a GToolkit-Examples package. Lepiter, OTOH, could only be loaded in a GT image"
]
