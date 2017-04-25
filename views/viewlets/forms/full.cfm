<cfset isAdmin = find("contentbox-admin", event.getCurrentEvent()) neq 0 ? true : false>

<cfoutput>
	<cfif !isAdmin>
		<script type="text/javascript" src="https://js.stripe.com/v2/"></script>
		<script type="text/javascript">Stripe.setPublishableKey('#prc.publishableKey#');</script>
	</cfif>

	<form action="#event.buildLink(prc.xehFormSubmit)#" method="POST" id="payment-form">
		#getInstance("messageBox@cbMessageBox").renderit()#

		<div class="payment-errors-container alert alert-danger" style="min-height: 38px; display: none;">
			<i class="icon-info-sign icon-large icon-2x pull-left"></i> <span class="payment-errors"><span>
		</div>

		<input type="hidden" name="_returnTo" value="#cgi.path_info#">

		<fieldset>
			<legend>Donation Information</legend>

			<div class="form-group">
				<label for="city">Donation Amount: <span>In USD</span></label>
				<input class="form-control" min="1" name="amount" title="Donation Amount" type="number">
			</div>

			<div class="form-group">
				<label for="recurring">Donation Frequency:</label>
				<div class="radio-inline"><input id="donationFrequency" name="donationFrequency" type="radio" value="onetime" checked /> One Time</div>
				<div class="radio-inline"><input id="donationFrequency" name="donationFrequency" type="radio" value="recurring" /> Monthly Recurring</div>
			</div>
		</fieldset>

		<fieldset>
			<legend>Personal Information</legend>

			<div class="form-group">
				<label for="name">First Name: <span>Put your name here</span></label>
				<input class="form-control" id="name" name="name" type="text">
			</div>

			<div class="form-group">
				<label for="surname">Last Name: <span>Put your surname here</span></label>
				<input class="form-control" id="surname" name="surname" type="text">
			</div>

			<div class="form-group">
				<label for="email">Email: <span>Put your email here</span></label>
				<input class="form-control" id="email" name="email" type="email">
			</div>
		</fieldset>
		<!-- /.donate-form -->

		<fieldset>
			<legend>Billing Information</legend>

			<div class="form-group">
				<label for="address">Address: <span>Address name here</span></label>
				<input class="form-control" id="address" name="address" type="text">
			</div>

			<div class="form-group">
				<label for="address2">Address 2: <em>(Optional)</em> <span>Second address name</span></label>
				<input class="form-control" id="address2" name="address2" type="text" />
			</div>

			<div class="form-group">
				<label for="city">City: <span>City name</span></label>
				<input class="form-control" id="city" name="city" type="text">
			</div>

			<div class="form-group">
				<label for="country">Country/State: <span>Where do you live?</span></label>
				<input class="form-control" id="country" name="country" type="text">
			</div>

			<div class="form-group">
				<label for="zipcode">Zip Code: <span>Zip or Postal code</span></label>
				<input class="form-control" id="zipcode" name="zipcode" type="text">
			</div>
		</fieldset>
		<!-- /.donate-form -->

		<fieldset>
			<legend>Credit Card Information</legend>

			<div class="form-group">
				<label for="country">Name on Card: <span>As it appears on the card</span></label>
				<input class="form-control" id="cardHolder" type="text" data-stripe="number">
			</div>

			<div class="form-group">
				<label for="address">Card Number: <span>ex: 0000-0000-0000-0000</span></label>
				<input class="form-control" type="text" placeholder="Card Number" size="20" data-stripe="number">
				<div class="payment-icons">
					<i aria-hidden="true" class="fa fa-cc-visa fa-3x"><!-- icon --></i>
					<i aria-hidden="true" class="fa fa-cc-mastercard fa-3x"><!-- icon --></i>
					<i aria-hidden="true" class="fa fa-cc-discover fa-3x"><!-- icon --></i>
					<i aria-hidden="true" class="fa fa-cc-amex fa-3x"><!-- icon --></i>
				</div>
			</div>

			<div class="form-group">
				<label for="address2">Expiration Month: <span>MM</span></label>
				<input class="form-control" type="text" placeholder="Expiration (MM)" size="2" data-stripe="exp_month">
			</div>

			<div class="form-group">
				<label for="address2">Expiration Year: <span>YY</span></label>
				<input class="form-control" type="text" placeholder="Expiration (YY)" size="2" data-stripe="exp_year">
			</div>

			<div class="form-group">
				<label for="city">Card Verification Value: <span>3-4 digits on the back of the card</span></label>
				<input class="form-control" type="text" placeholder="CVC" size="4" data-stripe="cvc">
			</div>
		</fieldset>
		<!-- /.donate-form -->

		<input type="submit" class="btn btn-default submit" value="Donate Now">
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