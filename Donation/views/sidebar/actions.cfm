<cfoutput>
<!--- Info Box --->
<div class="small_box">
	<div class="header">
		<i class="icon-cogs"></i> Actions
	</div>
	<div class="body">
		<!--- Forms --->
		<button class="btn btn-danger" onclick="return to('#cb.buildModuleLink('Donation',prc.xehReports)#')">Reports</button>
		<button class="btn" onclick="return to('#cb.buildModuleLink('Donation',prc.xehSettings)#')" title="Set global form settings">Settings</button>
	</div>
</div>
</cfoutput>