<!--- <cf_dumpall> --->
 
<cfparam name="query" default="">
<cfparam name="url" default="">

    Query<BR><cfdump var="#query#" label = "Query Data"><BR>
    Application<BR><cfdump var="#application#" label = "Application Variables"><BR>
    Session<BR><cfdump var="#session#" label = "Session Variables"><BR>
    Client<BR><cfdump var="#client#" label = "Client Variables"><BR>
    Cookie<BR><cfdump var="#cookie#" label = "Cookie Variables"><BR>
    Form<BR><cfdump var="#form#" label = "Form Variables"><BR>
    Url<BR><cfdump var="#url#" label = "URL Variables"><BR>
    Cgi<BR><cfdump var="#cgi#" label = "CGI Variables">