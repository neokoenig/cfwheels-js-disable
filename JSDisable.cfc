component mixin="controller" {

	public any function init() {
		this.version = "2.0";
		return this;
	}

	/**
	 * Override core submitTag(), call it and then act on the result.
	 */
	public string function submitTag() {
		local.disable = $jsDisableArgs(args=arguments);
		local.rv = core.submitTag(argumentCollection=arguments);
		local.image = StructKeyExists(arguments, "image") ? arguments.image : "";
		local.rv = $jsDisableAdd(name="onclick", rv=local.rv, disable=local.disable, image=local.image, jsProperty="value");
		return local.rv;
	}

	/**
	 * Override core buttonTag(), call it and then act on the result.
	 */
	public string function buttonTag() {
		local.disable = $jsDisableArgs(args=arguments);
		local.rv = core.buttonTag(argumentCollection=arguments);
		local.image = StructKeyExists(arguments, "image") ? arguments.image : "";
		local.rv = $jsDisableAdd(name="onclick", rv=local.rv, disable=local.disable, image=local.image, jsProperty="innerHTML");
		return local.rv;
	}

	/**
	 * Override core buttonTo(), call it and then act on the result.
	 */
	public string function buttonTo() {
		local.disable = $jsDisableArgs(args=arguments);
		local.rv = core.buttonTo(argumentCollection=arguments);
		local.image = StructKeyExists(arguments, "image") ? arguments.image : "";
		local.rv = $jsDisableAdd(name="onsubmit", rv=local.rv, disable=local.disable, image=local.image, jsProperty="value");
		return local.rv;
	}

	/**
	 * Delete the "disable" argument from the arguments struct so it doesn't get passed along to submitTag() / buttonTag() / buttonTo().
	 * This works because the arguments struct is passed in by reference.
	 * Also return the "disable" argument as a blank string, or what was passed in to it originally.
	 */
	public string function $jsDisableArgs(required struct args) {
		local.rv = "";
		if (StructKeyExists(args, "disable")) {
			local.rv = args.disable;
			StructDelete(args, "disable");
		}
		return local.rv;
	}

	/**
	 * Add the attribute (e.g., "onsubmit", "onclick") to the string, or append to existing attribute value.
	 */
	public string function $jsDisableAdd(required string name, required string rv, required any disable, required string jsProperty) {
		if (Len(arguments.disable)) {
			local.js = "this";
			if (arguments.name == "onsubmit") {
				local.js &= ".elements[0]";
			}
			local.js &= ".disabled=true;";
			if (!Len(arguments.image) && !IsBoolean(arguments.disable)) {
				// When the user wanted text on the button when clicked (e.g. "Please wait...") we add it here.
				// Does not apply when an image is used in place of the button.
				local.js &= "this";
				if (arguments.name == "onsubmit") {
					local.js &= ".elements[0]";
				}
				local.js &= "." & arguments.jsProperty & "='#JSStringFormat(arguments.disable)#';";
      }
			local.js &= "this";
			if (arguments.name == "onclick") {
				local.js &= ".form";
			}
			local.js &= ".submit();";
			local.check = " " & arguments.name & "=""";
			local.checkPos = Find(local.check, arguments.rv);
			if (local.checkPos) {
				// An attribute value already exists we set the string to be added to just the JavaScript.
				// Also set the positition to insert at to be where the ending double quote is found.
				local.attribute = local.js;
				local.pos = Find("""", arguments.rv, local.checkPos + Len(local.check));
			} else {
				// No existing attribute exists so we can add the entire attribute and not just the JavaScript part.
				// Set the position to insert at to be before the ending tag.
				local.attribute = local.check & local.js & """";
				local.pos = Find(">", arguments.rv);
			}
			local.rv = Insert(local.attribute, arguments.rv, local.pos - 1);
		} else {
			local.rv = arguments.rv;
		}
		return local.rv;
	}

}