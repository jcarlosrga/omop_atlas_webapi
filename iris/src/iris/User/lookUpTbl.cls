/// 
Class User.lookUpTbl Extends (%Persistent, Base) [ ClassType = persistent, DdlAllowed, Final, ProcedureBlock, SqlRowIdPrivate, SqlTableName = lookUpTbl ]
{

/// Property id As %Library.AutoIncrement [ Required, SqlColumnNumber = 2, SqlFieldName = location_id ];
Property tblName As %Library.String(MAXLEN = "") [ SqlColumnNumber = 2, SqlFieldName = Tbl_name ];

Property columnName As %Library.String(MAXLEN = "") [ SqlColumnNumber = 3, SqlFieldName = column_name ];

Property sourceCode As %Library.String(MAXLEN = "") [ SqlColumnNumber = 4, SqlFieldName = source_code ];

Property sourceValue As %Library.String(MAXLEN = "") [ SqlColumnNumber = 5, SqlFieldName = source_value ];

Property conceptId As %Library.String(MAXLEN = "") [ SqlColumnNumber = 6, SqlFieldName = concept_id ];

Property conceptValue As %Library.String(MAXLEN = "") [ SqlColumnNumber = 7, SqlFieldName = concept_value ];

Property domain As %Library.String(MAXLEN = "") [ SqlColumnNumber = 8, SqlFieldName = domain ];

Property Comments As %Library.String(MAXLEN = "") [ SqlColumnNumber = 9, SqlFieldName = Comments ];

Parameter USEEXTENTSET = 1;

/// Bitmap Extent Index auto-generated by DDL CREATE TABLE statement.  Do not edit the SqlName of this index.
/// Index DDLBEIndex [ Extent, SqlName = "%%DDLBEIndex", Type = bitmap ];
Index Tblnameindx On tblName [ SqlName = Tbl_name_indx, Type = index ];

Index columnnameindx On columnName [ SqlName = column_name_indx, Type = index ];

Index conceptidindx On conceptId [ SqlName = concept_id_indx, Type = index ];

Index conceptvalueindx On conceptValue [ SqlName = concept_value_indx, Type = index ];

Index domainindx On domain [ SqlName = domain_indx, Type = index ];

Index sourcecodeindx On sourceCode [ SqlName = source_code_indx, Type = index ];

Index sourcevalueindx On sourceValue [ SqlName = source_value_indx, Type = index ];

ClassMethod InsertLine(fileLine As %String, delimiter As %Char = ";") As %Status [ Language = objectscript ]
{
	set obj = ..%New()
	
	//INSERT INTO lookUpTbl(Tbl_name,column_name,source_code,source_value,concept_id,concept_value,""domain"",Comments)
	;set sc=rs.Execute($p(fileLine,";",2), $p(fileLine,";",3), $p(fileLine,";",4), $p(fileLine,";",5), $p(fileLine,";",6), $p(fileLine,";",7), $p(fileLine,";",8) )
	set obj.tblName = $p(fileLine, delimiter, 2)
	set obj.columnName = $p(fileLine, delimiter, 3)
	set obj.sourceCode = $p(fileLine, delimiter, 4)
	set obj.sourceValue = $p(fileLine, delimiter, 5)
	set obj.conceptId = $p(fileLine, delimiter, 6)
	set obj.conceptValue = $p(fileLine, delimiter, 7)
	set obj.domain = $p(fileLine, delimiter, 8)
	set obj.Comments = $p(fileLine, delimiter, 9)
	
	quit obj.%Save()
}

Storage Default
{
<Data name="lookUpTblDefaultData">
<Value name="1">
<Value>tblName</Value>
</Value>
<Value name="2">
<Value>columnName</Value>
</Value>
<Value name="3">
<Value>sourceCode</Value>
</Value>
<Value name="4">
<Value>sourceValue</Value>
</Value>
<Value name="5">
<Value>conceptId</Value>
</Value>
<Value name="6">
<Value>conceptValue</Value>
</Value>
<Value name="7">
<Value>domain</Value>
</Value>
<Value name="8">
<Value>Comments</Value>
</Value>
</Data>
<DataLocation>^poCN.D6wN.1</DataLocation>
<DefaultData>lookUpTblDefaultData</DefaultData>
<ExtentLocation>^poCN.D6wN</ExtentLocation>
<IdLocation>^poCN.D6wN.1</IdLocation>
<Index name="IDKEY">
<Location>^poCN.D6wN.1</Location>
</Index>
<Index name="Tblnameindx">
<Location>^poCN.D6wN.2</Location>
</Index>
<Index name="columnnameindx">
<Location>^poCN.D6wN.3</Location>
</Index>
<Index name="conceptidindx">
<Location>^poCN.D6wN.4</Location>
</Index>
<Index name="conceptvalueindx">
<Location>^poCN.D6wN.5</Location>
</Index>
<Index name="domainindx">
<Location>^poCN.D6wN.6</Location>
</Index>
<Index name="sourcecodeindx">
<Location>^poCN.D6wN.7</Location>
</Index>
<Index name="sourcevalueindx">
<Location>^poCN.D6wN.8</Location>
</Index>
<IndexLocation>^poCN.D6wN.I</IndexLocation>
<StreamLocation>^poCN.D6wN.S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
