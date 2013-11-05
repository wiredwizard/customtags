<!---  attributes --->
<CFPARAM name="Attributes.mydsn" default="changeme">
<CFPARAM name="Attributes.mytable" default="whichtable">
<CFPARAM name="Attributes.mykey" default="primarykey">

<!--- VARIABLES --->
<cfoutput>
<cfset datasourcename = "#Attributes.mydsn#">
<cfset tablename = "#Attributes.mytable#">
<cfset pk_field = "#Attributes.mykey#">
</cfoutput>

<cfquery name="team" datasource="#datasourcename#" dbtype="ODBC">
SELECT *
FROM #tablename#;
</cfquery>
<cfset pk_field = UCase(pk_field)>
<cfset the_fields = team.ColumnList>
<cfset pk_position = ListFInd(the_fields, pk_field)>
<cfset the_fields = ListDeleteAt(the_fields, pk_position)>
<cfset number_columns = ListLen(the_fields)>

<cfparam name="URL.a" default="l"><br>
<cfloop index="x" list="#the_fields#">
<cfoutput><cfparam name="#tablename#.#x#" default=""></cfoutput><br>
</cfloop><br>

