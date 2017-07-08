component {

	// pre handler
	function preHandler(event,action,eventArguments){
		var rc 	= event.getCollection();
		var prc = event.getCollection(private=true);

		// get module root
		prc.moduleRoot = event.getModuleRoot("cbdonation");

		prc.xehReports = "report.index";
		prc.xehSettings = "settings.index";
		prc.xehSettings = "settings.index";
		prc.xehSettingsSave = "settings.saveSettings";
	}

}