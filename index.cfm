<cfoutput>

<h1>JS Disable #application.wheels.pluginMeta["jsDisable"]["version"]#</h1>
<p>Adds a <code>disable</code> argument to <code>submitTag()</code>, <code>buttonTag()</code> and <code>buttonTo()</code> that disables the button so it can't be double-clicked.</p>

<p><strong>Usage Examples</strong></p>
<pre>
  ##startFormTag()##
    ##submitTag(value="Purchase", disable=true)##
  ##endFormTag()##
</pre>
<pre>
  ##startFormTag()##
    ##buttonTag(content="Purchase", disable="Please wait...")##
  ##endFormTag()##
</pre>
<pre>
  ##buttonTo(text="Delete", action="deleteIt", disable="Please wait...")##
</pre>

</cfoutput>