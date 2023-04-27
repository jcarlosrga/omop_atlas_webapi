/// 
/// 20211005 Denis Bulashev
/// 
Class OMOP.Process.Base Extends Ens.BusinessProcess [ ClassType = persistent ]
{

Method getNewId(tblName As %String) As %String
{
	q:$g(tblName)="" ""
	i '$d(^OMOP(tblName)) s ^OMOP(tblName) = 100000
	i $g(^OMOP(tblName))<100000 s ^OMOP(tblName) = 100000
	q $i(^OMOP(tblName))
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
