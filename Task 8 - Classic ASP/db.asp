
<%
Dim objConn

Set objConn = Server.CreateObject("ADODB.Connection")

objConn.Open "Provider=MSOLEDBSQL19;" & _
             "Data Source=PRASANNA\SQLEXPRESS;" & _
             "Initial Catalog=InternTraining;" & _
             "Integrated Security=SSPI;" & _
             "Use Encryption for Data=Mandatory;" & _
             "Trust Server Certificate=true;"
%>
