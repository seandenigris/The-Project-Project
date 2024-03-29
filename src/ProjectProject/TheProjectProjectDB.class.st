Class {
	#name : #TheProjectProjectDB,
	#superclass : #SpFileDatabase,
	#category : 'ProjectProject-Persistence'
}

{ #category : #accessing }
TheProjectProjectDB class >> backupDirectoryParent [
	^ FileLocator dynabookData / 'The Project Project'
]

{ #category : #'loading/saving' }
TheProjectProjectDB class >> schema [

	^ {
			BookmarkMagicDB.
			PpChecklist.
			PpEventLog.
			PpInventory.
			PpLocation.
			PpProjectList.
			PpSystem.
			PpTag.
			QuoteMeDB.
			ResourcesLiveDB.
			TnTrackingNumberDB
		}.
]
