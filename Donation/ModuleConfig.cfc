/**
* A module that will help you generate donation forms for ContentBox, used in combination with the
* DonationForm Widget it will allow you to create donation forms and display them on your ContentBox
* pages
*/
component {

	// Module Properties
	this.title 				= "Donation";
	this.author 			= "Computer Know How";
	this.webURL 			= "http://www.compknowhow.com";
	this.description 		= "A cool donation form builder for ContentBox";
	this.version			= "1.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "Donation";

	function configure(){
		// module settings - stored in modules.name.settings
		settings = {
			stripe = { mode = "Test", livePublishableKey = "", liveSecretKey = "", testPublishableKey = "", testSecretKey = "" }
		};

		// SES Routes
		routes = [
			{pattern="/", handler="report",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Interceptors
		interceptors = [];

		//Mappings
		binder.map("DonationService@Donation").to("#moduleMapping#.model.DonationService");

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// ContentBox loading
		if( structKeyExists( controller.getSetting("modules"), "contentbox" ) ){
			// Let's add ourselves to the main menu in the Modules section
			var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
			// Add Menu Contribution
			menuService.addSubMenu(topMenu=menuService.MODULES,name="Donation",label="Donation",href="#menuService.buildModuleLink('Donation','report.index')#");
		}
	}

	/**
	* Fired when the module is activated
	*/
	function onActivate(){
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		// store default settings
		var findArgs = {name="Donation"};
		var setting = settingService.findWhere(criteria=findArgs);
		if( isNull(setting) ){
			var args = {name="Donation", value=serializeJSON( settings )};
			var formBuilderSettings = settingService.new(properties=args);
			settingService.save( formBuilderSettings );
		}

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		// ContentBox unloading
		if( structKeyExists( controller.getSetting("modules"), "contentbox" ) ){
			// Let's remove ourselves to the main menu in the Modules section
			var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
			// Remove Menu Contribution
			menuService.removeSubMenu(topMenu=menuService.MODULES,name="Donation");
		}
	}

	/**
	* Fired when the module is deactivated by ContentBox Only
	*/
	function onDeactivate(){
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		var args = {name="Donation"};
		var setting = settingService.findWhere(criteria=args);
		if( !isNull(setting) ){
			settingService.delete( setting );
		}
	}

}