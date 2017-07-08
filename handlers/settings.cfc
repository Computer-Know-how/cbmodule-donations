component extends="base" {

	property name="settingService" 	inject="settingService@cb";
	property name="cb" 				inject="cbHelper@cb";

	function index(event,rc,prc){
		prc.settings = deserializeJSON(settingService.getSetting( "cbdonation" ));

		event.setView("settings/index");
	}

	function saveSettings(event,rc,prc){
		var oSetting = settingService.findWhere( { name="cbdonation" } );

		// Get Stripe settings from user input
		newSettings = {"stripe"={"mode"=rc.mode, "livePublishableKey"=rc.livePublishableKey, "liveSecretKey"=rc.liveSecretKey, "testPublishableKey"=rc.testPublishableKey, "testSecretKey"=rc.testSecretKey}};

		oSetting.setValue( serializeJSON(newSettings) );
		settingService.save( oSetting );

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();

		getInstance("messageBox@cbMessageBox").info("Settings Saved & Updated!");
		cb.setNextModuleEvent("cbdonation","settings.index");
	}

}