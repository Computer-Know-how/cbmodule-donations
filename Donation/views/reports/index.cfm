<cfoutput>
#renderView( "viewlets/assets" )#
<!--============================Main Column============================-->
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<!--- Body Header --->
			<div class="header">
				<i class="icon-list-alt icon-large"></i>
				Reports
			</div>
			<!--- Body --->
			<div class="body">

				<!--- MessageBox --->
				#getPlugin("MessageBox").renderit()#

				<div class="well">Reports can be views on the <a href="http://dashboard.stripe.com" target="_blank">Stripe Dashboard</a>.</div>

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