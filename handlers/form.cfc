component {

	property name="settingService" 	inject="settingService@cb";

	function preHandler(event,action,eventArguments,rc,prc){
		var oSetting = settingService.findWhere( { name="donation" } );
		var settings = deserializeJSON(oSetting.getValue());

		if(settings.stripe.mode eq "LIVE") {
			prc.publishableKey = settings.stripe.livePublishableKey;
			prc.secretKey = settings.stripe.liveSecretKey;
		} else {
			prc.publishableKey = settings.stripe.testPublishableKey;
			prc.secretKey = settings.stripe.testSecretKey;
		}
	}

	function render(event,rc,prc) {
		prc.xehFormSubmit = "cbdonation.form.submit";

		if( arguments.formType eq "simple" ){
			return renderView(view="viewlets/forms/simple", module="donation");
		} else if(arguments.formType eq "full") {
			return renderView(view="viewlets/forms/full", module="donation");
		} else {
			return "Form type '" & arguments.formType & "' not found.";
		}
	}

	function submit(event,rc,prc) {
		param name="rc.name" default="";
		param name="rc.surname" default="";
		param name="rc.email" default="";
		param name="rc.description" default="";
		param name="rc.donationFrequency" default="onetime";

		var stripe = createObject("component", "#event.getModuleRoot("donation")#.model.stripe.stripe").init(secretKey=prc.secretKey);

		var money = stripe.createMoney(rc.amount*100);

		// add metadata
		var fullName = rc.name & " " & rc.surname;
		var metadata = {};

		if (rc.description neq "") {
			metadata.name = fullName;
		}

		if (rc.description neq "") {
			metadata.description = rc.description;
		}

		if (rc.email neq "") {
			metadata.description = rc.description;
		}

		if(rc.donationFrequency eq "recurring") {
			//set the plan ID and name (ie: silver, gold, platinum)
			var id = numberFormat(amount, 9.00) & "_per_month";
			var name = dollarFormat(amount) & " Per Month";
			var plan = stripe.retrievePlan(id=id);

			if(plan.getStatus() eq "failure") {
				plan = stripe.createPlan(id=id, money=money, interval="month", name=name);
			}

			stripeResponse = stripe.createCustomer(card=rc.stripeToken, email=rc.email, description=name, plan=id, metadata=metadata);
		} else {
			stripeResponse = stripe.createCharge(money=money, card=rc.stripeToken, description=rc.description, receipt_email=rc.email, metadata=metadata);
		}

		//check the response and handle it as needed
		if (stripeResponse.getSuccess()) {
			//handle the success, you may want to update the database and redirect to a confirmation
			id = stripeResponse.getResult().id; //get the id of the transaction out of the response
			getInstance("messageBox@cbMessageBox").setMessage("info","Your donation has been made.  Thank you!");
		} else {
			//handle the failure, you may want to send a notification email or log it
			getInstance("messageBox@cbMessageBox").setMessage("warning","There was a problem submitting your donation! Error: <i>" & stripeResponse.getErrorMessage() & "</i>");
		}

		setNextEvent(url=rc._returnTo);
	}

}