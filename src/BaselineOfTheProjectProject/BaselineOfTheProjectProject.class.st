Class {
	#name : #BaselineOfTheProjectProject,
	#superclass : #BaselineOf,
	#category : #BaselineOfTheProjectProject
}

{ #category : #baselines }
BaselineOfTheProjectProject >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'BookmarkMagic' with: [
				spec repository: 'gitlab://seandenigris/Bookmark-Magic' ];
			baseline: 'ExternalWebBrowser' with: [
				spec repository: 'github://seandenigris/Pharo-Web-Browser' ];
			baseline: 'Magritte' with: [
				spec
					loads: #('Magritte-GT');
					repository: 'github://seandenigris/Magritte' ];
			baseline: 'Mocketry' with: [
				spec repository: 'github://dionisiydk/Mocketry' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'QuoteMe' with: [
				spec repository: 'gitlab://seandenigris/Quote-Me' ];
			baseline: 'ResourcesLive' with: [
				spec
					repository: 'github://seandenigris/Resources-Live' ];
			baseline: 'SimplePersistence' with: [
				spec
					repository: 'github://seandenigris/Simple-Persistence' ];
			baseline: 'TrackingNumbers' with: [
				spec repository: 'github://seandenigris/Tracking-ST/src' ].
		spec
			package: #'Spec-PolyWidgets' with: [
				spec
					repository: 'http://smalltalkhub.com/mc/SeanDeNigris/SeansOutbox/main/' ];
			package: #ProjectProject with: [
				spec requires: #('BookmarkMagic' 'ExternalWebBrowser' 'Magritte' 'Mocketry' 'PharoEnhancements' 'QuoteMe' 'ResourcesLive' 'SimplePersistence' 'Spec-PolyWidgets' 'TrackingNumbers'). ]. ].
]
