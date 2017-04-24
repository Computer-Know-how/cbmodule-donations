<cfoutput>
	#renderView( "viewlets/assets" )#
	<!--============================Main Column============================-->
	<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<i class="fa fa-gears"></i> Settings
			</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-md-9">
			<div class="panel panel-default">
				<div class="panel-body">
					#getInstance("MessageBox@cbmessagebox").renderit()#

					<div class="tab-wrapper tab-primary">
						<ul class="nav nav-tabs">
							<li class="active"><a href="##stripe" data-toggle="tab"><i class="fa fa-credit-card"></i> Stripe</a></li>
						</ul>

						<div class="tab-content">
							<!--- Settings: Calendar Settings --->
							<div class="tab-pane active" id="stripe">

								#html.startForm(action="#cb.buildModuleLink('donation',prc.xehSettingsSave)#",name="settingsForm")#
									
									<div class="form-group">
										#html.label(class="control-label", field="mode", content="Mode:")#

										<div class="controls">
											#html.radioButton(name="mode", checked=(prc.settings.stripe.mode eq 'Live'), value="Live")# LIVE
											#html.radioButton(name="mode", checked=(prc.settings.stripe.mode eq 'Test'), value="Test")# TEST
										</div>
									</div>

									<div class="form-group">
										#html.textField(name="testSecretKey", label="Test Secret Key:", value="#prc.settings.stripe.testSecretKey#", class="form-control")#
									</div>

									<div class="form-group">
										#html.textField(name="testPublishableKey", label="Test Publishable Key:", value="#prc.settings.stripe.testPublishableKey#", class="form-control")#
									</div>

									<div class="form-group">
										#html.textField(name="liveSecretKey", label="Live Secret Key:", value="#prc.settings.stripe.liveSecretKey#", class="form-control")#
									</div>

									<div class="form-group">
										#html.textField(name="livePublishableKey", label="Live Publishable Key:", value="#prc.settings.stripe.livePublishableKey#", class="form-control")#
									</div>

									<small>Setup your account and get your keys <a href="https://stripe.com" target="_blank">here</a>.</small>

									<div class="form-actions">
										#html.submitButton(value="Save Settings", class="btn btn-danger", title="Save Settings")#
									</div>
								#html.endForm()#
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!--============================ Sidebar ============================-->
		<div class="col-md-3">
			<cfinclude template="../sidebar/actions.cfm">
			<cfinclude template="../sidebar/help.cfm">
			<cfinclude template="../sidebar/about.cfm">
		</div>
	</div>
</cfoutput>