# JS Disable - CFWheels Plugin

Adds a `disable` argument to `submitTag()`, `buttonTag()` and `buttonTo()` that disables the button so it can't be double-clicked.

## Usage Examples

```
#startFormTag()#
	#submitTag(value="Purchase", disable=true)#
#endFormTag()#
```

```
#startFormTag()#
	#buttonTag(content="Purchase", disable="Please wait...")#
#endFormTag()#
```

```
#buttonTo(text="Delete", action="deleteIt", disable="Please wait...")#
```