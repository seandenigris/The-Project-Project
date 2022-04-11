Class {
	#name : #ProjectProjectDB,
	#superclass : #SpFileDatabase,
	#category : #'ProjectProject-Persistence'
}

{ #category : #accessing }
ProjectProjectDB class >> backupDirectoryParent [
	"Re-write this if you'd like your backups to be saved in a location other than the image folder"
	^ super backupDirectoryParent
]

{ #category : #'loading/saving' }
ProjectProjectDB class >> schema [

	^ {
			PpLocation.
		}.
]
