Class OMOP.ProductionMain Extends Ens.Production [ Not ProcedureBlock ]
{

XData ProductionDefinition
{
<Production Name="OMOP.ProductionMain" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Item Name="Ens.Activity.Operation.Local" Category="" ClassName="Ens.Activity.Operation.Local" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <Item Name="Service.getPatientsList" Category="" ClassName="OMOP.Service.Timer" PoolSize="1" Enabled="true" Foreground="false" Comment="BS gets list of patients for future processing" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="target">Process.getPatientsList</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="CallInterval">10</Setting>
  </Item>
  <Item Name="Process.getPatientsList" Category="" ClassName="OMOP.Process.getPatientsList" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="FailureTimeout">150</Setting>
  </Item>
  <Item Name="Operation.updatePatientsList" Category="" ClassName="OMOP.Operation.updatePatientsList" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Service.getPatientInfo" Category="" ClassName="OMOP.Service.Timer" PoolSize="1" Enabled="true" Foreground="false" Comment="BS process patients from queue and save data in OMOP format" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="target">Process.getPatientInfo</Setting>
    <Setting Target="Adapter" Name="CallInterval">10</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="Process.getPatientInfo" Category="" ClassName="OMOP.Process.getPatientInfo" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Operation.getPatientInfo" Category="" ClassName="OMOP.Operation.getPatientInfo" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="DSN">UserunixodbcHI</Setting>
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="Process.createPatientLocation" Category="" ClassName="OMOP.Process.createPatientLocation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Process.getPatientLocation" Category="" ClassName="OMOP.Process.getPatientLocation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.getPatientLocation" Category="" ClassName="OMOP.Operation.getPatientLocation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="DSN">UserunixodbcHI</Setting>
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="Operation.saveDataToIRIS" Category="" ClassName="OMOP.Operation.saveDataToIRIS" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="DSN">UserunixodbcHITEST</Setting>
    <Setting Target="Host" Name="FailureTimeout">4</Setting>
  </Item>
  <Item Name="Operation.saveDataToPostgreSQL" Category="" ClassName="OMOP.Operation.saveDataToPostgreSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="JGService">JavaGate</Setting>
    <Setting Target="Adapter" Name="JDBCClasspath"></Setting>
    <Setting Target="Adapter" Name="JDBCDriver"></Setting>
    <Setting Target="Adapter" Name="DSN">postgresJDBC3</Setting>
    <Setting Target="Host" Name="ThrottleDelay">0</Setting>
    <Setting Target="Adapter" Name="StayConnected">-1</Setting>
  </Item>
  <Item Name="JavaGate" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="ClassPath"></Setting>
    <Setting Target="Host" Name="HeartbeatFailureAction">RA</Setting>
    <Setting Target="Host" Name="HeartbeatFailureRetry">20</Setting>
    <Setting Target="Host" Name="HeartbeatFailureTimeout">15</Setting>
    <Setting Target="Host" Name="HeartbeatInterval">10</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="GenerateSuperSessionID">1</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <Item Name="Operation.getCareProvider" Category="" ClassName="OMOP.Operation.getCareProvider" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">UserunixodbcHI</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="Process.checkCreateCareProvider" Category="" ClassName="OMOP.Process.checkCreateCareProvider" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.getCareProviderInfo" Category="" ClassName="OMOP.Operation.getCareProviderInfo" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">UserunixodbcHI</Setting>
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="Process.createPerson" Category="" ClassName="OMOP.Process.createPerson" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.getPerson" Category="" ClassName="OMOP.Operation.getPerson" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">UserunixodbcHI</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="Process.createDeath" Category="" ClassName="OMOP.Process.createDeath" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.getDeath" Category="" ClassName="OMOP.Operation.getDeath" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">UserunixodbcHI</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="Process.createVisitOccurence" Category="" ClassName="OMOP.Process.createVisitOccurence" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Operation.getVisitOccurence" Category="" ClassName="OMOP.Operation.getVisitOccurence" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">UserunixodbcHI</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="Process.createEventTable" Category="" ClassName="OMOP.Process.createEventTable" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Operation.getEventData" Category="" ClassName="OMOP.Operation.getEventData" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">UserunixodbcHI</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="StayConnected">-1</Setting>
  </Item>
  <Item Name="Process.createCondition" Category="" ClassName="OMOP.Process.createCondition" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.getConditionData" Category="" ClassName="OMOP.Operation.getConditionData" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="DSN">UserunixodbcHI</Setting>
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="Process.createObservation" Category="" ClassName="OMOP.Process.createObservation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.getPatientsList" Category="" ClassName="OMOP.Operation.getPatientsList" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">UserunixodbcHI</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Host" Name="FailureTimeout">300</Setting>
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
    <Setting Target="Host" Name="SendLocalRequest">1</Setting>
  </Item>
  <Item Name="Operation.getCareSite" Category="" ClassName="OMOP.Operation.getCareSite" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="DSN">UserunixodbcHI</Setting>
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="Process.checkCreateCareSite" Category="" ClassName="OMOP.Process.checkCreateCareSite" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.getCareSiteInfo" Category="" ClassName="OMOP.Operation.getCareSiteInfo" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="DSN">UserunixodbcHI</Setting>
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="Operation.checkCareSiteLocationInfoInIRIS" Category="" ClassName="OMOP.Operation.checkCareSiteLocationInfoInIRIS" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="DSN">UserunixodbcHITEST</Setting>
  </Item>
  <Item Name="Process.createMeasurement" Category="" ClassName="OMOP.Process.createMeasurement" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Process.createFactRelationshipConceptId" Category="" ClassName="OMOP.Process.createFactRelationshipConceptId" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Process.createProcedureOccurence" Category="" ClassName="OMOP.Process.createProcedureOccurence" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Process.createDrugExposure" Category="" ClassName="OMOP.Process.createDrugExposure" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Process.createDeviceExposure" Category="" ClassName="OMOP.Process.createDeviceExposure" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Process.createSpecimen" Category="" ClassName="OMOP.Process.createSpecimen" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Process.createNote" Category="" ClassName="OMOP.Process.createNote" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Process.doPresteps" Category="" ClassName="OMOP.Process.doPresteps" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Operation.prestepsGetLocationAndSiteData" Category="" ClassName="OMOP.Operation.prestepsGetLocationAndSiteData" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="DSN">UserunixodbcHITEST</Setting>
  </Item>
  <Item Name="Operation.prestepsGetProviderData" Category="" ClassName="OMOP.Operation.prestepsGetProviderData" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">UserunixodbcHITEST</Setting>
  </Item>
  <Item Name="Operation.checkLocationInIris" Category="" ClassName="OMOP.Operation.checkLocationInIris" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.checkCareSiteInIRIS" Category="" ClassName="OMOP.Operation.checkCareSiteInIRIS" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.checkCareProviderInfoInIRIS" Category="" ClassName="OMOP.Operation.checkCareProviderInfoInIRIS" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.checkCareProviderInIris" Category="" ClassName="OMOP.Operation.checkCareProviderInIris" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Process.clearPatientData" Category="" ClassName="OMOP.Process.clearPatientData" PoolSize="1" Enabled="true" Foreground="false" Comment="This process is used to clear stored information about particular person from IRIS and PostgreSQL databases" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Operation.getPersonIdFromPostgreSQL" Category="" ClassName="OMOP.Operation.getPersonIdFromPostgreSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="DSN">postgresJDBC3</Setting>
    <Setting Target="Adapter" Name="JGService">JavaGate</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="Operation.clearPersonDataFromPostgreSQL" Category="" ClassName="OMOP.Operation.clearPersonDataFromPostgreSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="DSN">postgresJDBC3</Setting>
    <Setting Target="Adapter" Name="JGService">JavaGate</Setting>
  </Item>
  <Item Name="Process.Achilles" Category="" ClassName="OMOP.Process.Achilles" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Process.createObservationPeriod" Category="" ClassName="OMOP.Process.createObservationPeriod" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}

