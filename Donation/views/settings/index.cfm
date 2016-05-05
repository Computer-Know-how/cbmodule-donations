<cfoutput>
#renderView( "viewlets/assets" )#
<!--============================Main Column============================-->
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<!--- Body Header --->
			<div class="header">
				<i class="icon-magic"></i> Settings
			</div>
			<!--- Body --->
			<div class="body" id="mainBody">
				#getPlugin("MessageBox").renderit()#
				<div class="tabbable tabs-left">
					<ul class="nav nav-tabs">
						<li class="active"><a href="##stripe" data-toggle="tab"><i class="icon-reorder"></i> Stripe</a></li>

						<!--- <li><a href="##containersStyleHooks" data-toggle="tab"><i class="icon-th-large"></i> Containers / Style Hooks</a></li> --->
					</ul>

					<div class="tab-content">
						<!--- Form Details --->
						<div class="tab-pane active" id="stripe">
							#html.startForm(action="#cb.buildModuleLink('Donation',prc.xehSettingsSave)#",name="settingsForm")#
								#html.startFieldset(legend="Stripe")#
									<label for="mode">Mode:</label>
									#html.radioButton(name="mode",checked=(prc.settings.stripe.mode eq 'Live'),value="Live")# LIVE
									#html.radioButton(name="mode",checked=(prc.settings.stripe.mode eq 'Test'),value="Test")# TEST<br><br>

									#html.textField(name="testSecretKey", label="Test Secret Key:", value="#prc.settings.stripe.testSecretKey#", class="textfield large", size=40)#<br/>

									#html.textField(name="testPublishableKey", label="Test Publishable Key:", value="#prc.settings.stripe.testPublishableKey#", class="textfield large", size=40)#

									#html.textField(name="liveSecretKey", label="Live Secret Key:", value="#prc.settings.stripe.liveSecretKey#", class="textfield large", size=40)#<br/>

									#html.textField(name="livePublishableKey", label="Live Publishable Key:", value="#prc.settings.stripe.livePublishableKey#", class="textfield large", size=40)#<br/><br/>

									<small>Setup your account and get your keys <a href="https://stripe.com" target="_blank">here</a></small>

									<div class="form-actions">
										#html.submitButton(value="Save Settings", class="btn btn-danger", title="Save Settings")#
									</div>
								#html.endFieldSet()#
							#html.endForm()#
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--============================ Sidebar ============================-->
	<div class="span3" id="main-sidebar">
		<cfinclude template="../sidebar/actions.cfm" >
		<cfinclude template="../sidebar/help.cfm" >
		<cfinclude template="../sidebar/about.cfm" >
	</div>
</div>
</cfoutput>