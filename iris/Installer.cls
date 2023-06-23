Include %occInclude

Class App.Installer
{

XData setup
{
<Manifest>
  <Default Name="Namespace" Value="IRISAPP"/>
  <Default Name="database" Value="irisapp"/>
  <Namespace Name="${Namespace}" Code="${Namespace}" Data="${Namespace}" Create="yes" Ensemble="1">

    <Configuration>
      <Database Name="${Namespace}" Dir="/opt/irisbuild/db/${database}" Create="no" Resource="%DB_${Namespace}"/>
    </Configuration>
  </Namespace>
  
    <Namespace Name="${Namespace}" Create="no">
	<CSPApplication Url="/csp/healthshare/${database}" Directory="${CSPDIR}healthshare/${database}" AuthenticationMethods="32" ServeFiles="1" Recurse="1" MatchRoles=":%DB_${Namespace}" />
    </Namespace>

</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  #; Let XGL document generate code for this method. 
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

}