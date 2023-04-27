/// Step 0
/// db integrity fix
/// For bug fixing / debugging use only !!!
Class OMOP.Process.dbCheck Extends Ens.BusinessProcess [ ClassType = persistent ]
{

Method OnRequest(pRequest As Ens.Request, Output pResponse As Ens.Response) As %Status
{
	s sc = $$$OK
	try {
		set startTime = $zh
		
		s sc = ##class(OMOP.Utils.database).personSourceValueFix()
		
		set stopTime = $zh
		set workingTime = stopTime - startTime
		
		$$$TRACE(" >>> workingTime "_workingTime)
		
	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
