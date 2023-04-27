/// Calls OHDSI Achilles scripts to populate Achilles reporting tables.
Class OMOP.Process.Achilles Extends Ens.BusinessProcess [ ClassType = persistent ]
{

/// Name of target BP
Property AchillesScript As %String(MAXLEN = 300) [ InitialExpression = "/opt/irisbuild/ddlMySQL/02-achilles.sql", Required ];

Parameter SETTINGS = "AchillesScript:Basic";

Method OnRequest(pRequest As Ens.Request, Output pResponse As Ens.Response) As %Status
{
	
	if ..AchillesScript = "" Q $$$ERROR("Undefined Achilles script")
	if '##class(%File).Exists(..AchillesScript) Q $$$ERROR("Achilles script file not exist")
	s sc = $$$OK
	try {
		do $SYSTEM.SQL.Schema.ImportDDL("/opt/irisbuild/ddlMySQL/02-achilles.sql",,"MySQL")
	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

Storage Default
{
<Data name="AchillesDefaultData">
<Subscript>"Achilles"</Subscript>
<Value name="1">
<Value>AchillesScript</Value>
</Value>
</Data>
<DefaultData>AchillesDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}

