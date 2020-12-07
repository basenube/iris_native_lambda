Class ZDEMO.IRIS.Lambda.Operations Extends %Persistent
{

ClassMethod Version() As %String
{
   Set tSC = 0

   Set tVersion = $ZV
   if ( tVersion '="" ) { set tSC = $$$OK }

   Set jsonret = {}
   Set jsonret.status = tSC
   Set jsonret.payload = tVersion

   Quit jsonret.%ToJSON()
}

Storage Default
{
<Data name="OperationsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<DataLocation>^ZDEMO.IRIS.Lambda.OperationsD</DataLocation>
<DefaultData>OperationsDefaultData</DefaultData>
<IdLocation>^ZDEMO.IRIS.Lambda.OperationsD</IdLocation>
<IndexLocation>^ZDEMO.IRIS.Lambda.OperationsI</IndexLocation>
<StreamLocation>^ZDEMO.IRIS.Lambda.OperationsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
