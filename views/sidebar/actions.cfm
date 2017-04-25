<cfoutput>
	<div class="panel panel-primary">
		<!--- Info Box --->
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="fa fa-cogs"></i> Actions
			</h3>
		</div>
		<div class="panel-body">
			<!--- Forms --->
			<button class="btn btn-danger" onclick="return to('#cb.buildModuleLink('cbdonation',prc.xehReports)#')">Reports</button>
			<button class="btn" onclick="return to('#cb.buildModuleLink('cbdonation',prc.xehSettings)#')" title="Set global form settings">Settings</button>
		</div>
	</div>
</cfoutput>