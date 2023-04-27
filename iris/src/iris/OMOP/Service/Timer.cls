/// BS starts every n-seconds (interval) and sends en empty message to BP (target)
Class OMOP.Service.Timer Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

/// Name of target BP
Property target As %String(MAXLEN = 300) [ Required ];

Parameter SETTINGS = "target";

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	s sc = $$$OK
	
	try {
		// check settings
		i ..target="" s sc = $$$ERROR($$$GeneralError,"Target Business Process is empty!") q
		// send request
		s req=##class(Ens.Request).%New()
		s sc = ..SendRequestSync(..target, req, .resp)
		; s sc = ..SendRequestAsync(..target, req, .resp)
	} catch e {
		set sc = e.AsStatus()
	}
	q sc
}

/// This method is called when Portal is drawing the production diagram
/// pArray contains the config names the scanner found.
/// Users can remove or add new names
ClassMethod OnGetConnections(Output pArray As %String, pItem As Ens.Config.Item)
{
	i pItem.GetModifiedSetting("target",.tValue),tValue'="" { Set pArray(tValue)="" }
	q
}

}
