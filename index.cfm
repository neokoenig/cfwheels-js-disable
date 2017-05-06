<cfoutput>

<h1>JS Disable #application.wheels.pluginMeta["jsDisable"]["version"]#</h1>
<p>Adds a <code>disable</code> argument to <code>submitTag()</code> that disables the button so it can't be double-clicked.</p>

<p><strong>Usage Examples</strong></p>
<pre>
	##submitTag(value="Purchase", disable=true)##
	##submitTag(value="Purchase", disable="Please wait...")##
</pre>

</cfoutput>