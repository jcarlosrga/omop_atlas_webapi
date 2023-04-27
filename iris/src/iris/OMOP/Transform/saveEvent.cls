/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.saveEvent Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Proxy.eventItem, target As OMOP.Request.saveEventBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveEventBO).%New()
		
		s target.type = "saveEvent"
		
		s target.encounter = source.encounter
		s target.eventConceptId = source.eventConceptId
		s target.eventEndTime = source.eventEndTime
		s target.eventSourceValue = source.eventSourceValue
		s target.eventStartTime = source.eventStartTime
		s target.modifierConceptId = source.modifierConceptId
		s target.modifierSourceValue = source.modifierSourceValue
		s target.providerName = source.providerName
		s target.qualifierConceptId = source.qualifierConceptId
		s target.qualifierSourceValue = source.qualifierSourceValue
		s target.routeConceptId = source.routeConceptId
		s target.routeSourceValue = source.routeSourceValue
		s target.sourceTable = source.sourceTable
		s target.unitConceptId = source.unitConceptId
		s target.unitSourceValue = source.unitSourceValue
		s target.valueAsConceptId = source.valueAsConceptId
		s target.valueSourceValue = source.valueSourceValue
		s target.note = source.note
		s target.quantity = source.quantity
		s target.sourceId = source.sourceId
		s target.valueAsNumber = source.valueAsNumber
		s target.rangeHigh = source.rangeHigh
		s target.rangeLow = source.rangeLow
		
	} catch e {
		s sc = e.AsStatus()
		$$$TRACE(sc)
	}
	q sc
}

}

