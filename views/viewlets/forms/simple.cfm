<cfset isAdmin = find("contentbox-admin", event.getCurrentEvent()) neq 0 ? true : false>

<cfoutput>
	<cfif !isAdmin>
		<script type="text/javascript" src="https://js.stripe.com/v2/"></script>
		<script type="text/javascript">Stripe.setPublishableKey('#prc.publishableKey#');</script>
	</cfif>

	<form action="#event.buildLink(prc.xehFormSubmit)#" method="POST" id="payment-form">
		#getInstance("messageBox@cbMessageBox").renderit()#

		<div class="payment-errors-container alert alert-danger" style="min-height: 38px; display: none;">
			<i class="fa fa-frown-o fa-lg fa-2x pull-left"></i> <span class="payment-errors"><span>
		</div>

		<input type="hidden" name="_returnTo" value="#cb.linkSelf()#">

		<div class="box-content categories">
			<h4 class="widget-title">Make A Donation</h4>

			<div class="form-group">
				<input class="form-control" min="1" placeholder="Donation Amount" title="Custom Amount" type="number" name="amount">
			</div>

			<div class="form-group">
				<input class="form-control" type="text" placeholder="Card Number" size="20" data-stripe="number">
			</div>

			<div class="form-group">
				<input class="form-control" type="text" placeholder="Expiration Month (MM)" size="2" data-stripe="exp_month">
			</div>

			<div class="form-group">
				<input class="form-control" type="text" placeholder="Expiration Year (YY)" size="2" data-stripe="exp_year">
			</div>

			<div class="form-group">
				<input class="form-control" type="text" placeholder="CVC" size="4" data-stripe="cvc">
			</div>

			<input type="submit" class="btn btn-default submit" value="Donate Now">
		</div>
	</form>

	<cfif !isAdmin>
		<script type="text/javascript">
			$(function() {
				var $form = $("##payment-form");
				$form.submit(function(event) {
					// Disable the submit button to prevent repeated clicks:
					$form.find(".submit").prop("disabled", true);

					// Request a token from Stripe:
					Stripe.card.createToken($form, stripeResponseHandler);

					// Prevent the form from being submitted:
					event.preventDefault();
					return false;
				});
			});

			function stripeResponseHandler(status, response) {
				// Grab the form:
				var $form = $("##payment-form");

				if (response.error) { // Problem!
					// Show the errors on the form:
					$form.find(".payment-errors-container").show();
					$form.find(".payment-errors").text(response.error.message);
					$form.find(".submit").prop("disabled", false); // Re-enable submission
				} else { // Token was created!
					// Get the token ID:
					var token = response.id;

					// Insert the token ID into the form so it gets submitted to the server:
					$form.append($("<input type=hidden name=stripeToken>").val(token));

					// Submit the form:
					$form.get(0).submit();
				}
			};
		</script>
	</cfif>
</cfoutput>