Class User.LogDuration Extends %RegisteredObject
{

Property start As %Decimal [ InitialExpression = {$zh}, Private ];

/// This callback method is invoked by the <METHOD>%Close</METHOD> method to 
/// provide notification that the current object is being closed.
/// 
/// <P>The return value of this method is ignored.
Method %OnClose() As %Status [ Private, ServerOnly = 1 ]
{
	s dur = $zh - ..start
	w "Duration is ", dur," sec.", !
	Quit $$$OK
}

}

