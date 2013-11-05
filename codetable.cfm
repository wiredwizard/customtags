<!---
NAME: <codetable>
--->
<!--- To Use --->
<!--- 1. add this page to your custom tags as codetable.cfm --->
<!--- 2. to use: create a blank page and save it as the tableNameYouWantToUse.cfm --->
<!--- 3. call the tag <cf_codetable mydsn="datasourcename" mytable="TableName" mykey="PrimaryKey"> --->
<!--- 4. run the page in your browser --->
<!--- 5. copy the code that is produced to your tableNameYouWantToUse.cfm eracing the call for tag --->
<!--- 6. run the page again in browser customize as needed --->


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

&lt;cfparam name="URL.a" default="l"&gt;<br>
<cfloop index="x" list="#the_fields#">
<cfoutput>&lt;cfparam name="#tablename#.#x#" default=""&gt;</cfoutput><br>
</cfloop><br>

&lt;cfswitch expression="#URL.a#"&gt;<br>
&lt;cfcase value="i"&gt;<br>
<cfoutput>&lt;cfquery name="insert_#tablename#" datasource="#datasourcename#" dbtype="ODBC"&gt;<br>
INSERT INTO #tablename# (
<cfset a = number_columns>
<cfloop index="x" list="#the_fields#">
<cfset a = a -1>
#x#<cfif a GT 0>,</cfif></cfloop>)<br>
VALUES (<cfset a = number_columns>
<cfloop index="x" list="#the_fields#">
<cfset a = a -1>'##FORM.#x###'<cfif a GT 0>,</cfif></cfloop>)<br>
&lt;/cfquery&gt;</cfoutput><br><br>

<cfoutput><cfloop index="x" list="#the_fields#">
&lt;cfset #tablename#.#x# = FORM.#x#&gt;<br>
</cfloop></cfoutput>
&lt;/cfcase&gt;<br>

&lt;cfcase value="s"&gt;<br>
<cfoutput>&lt;cfquery name="#tablename#" datasource="#datasourcename#" dbtype="ODBC"&gt;<br>
SELECT * FROM #tablename#<br>
WHERE #pk_field# = ##URL.ID##;<br></cfoutput>
&lt;/cfquery&gt;<br>
&lt;/cfcase&gt;<br>

&lt;cfcase value="u"&gt;<br>
<cfoutput>&lt;cfquery name="update_#tablename#" datasource="#datasourcename#" dbtype="ODBC"&gt;<br>
UPDATE #tablename#<br>
SET 
<cfset a = number_columns>
<cfloop index="x" list="#the_fields#">
<cfset a = a -1>
#x# = '##FORM.#x###'<cfif a GT 0>,</cfif><br></cfloop>
WHERE #pk_field# = ##URL.ID##;<br>
&lt;/cfquery&gt;<br>
</cfoutput>

<cfoutput>&lt;cfquery name="#tablename#" datasource="#datasourcename#" dbtype="ODBC"&gt;<br>
SELECT * FROM #tablename#<br>
WHERE #pk_field# = ##URL.ID##;<br>
&lt;/cfquery&gt;<br>
&lt;/cfcase&gt;<br>
</cfoutput>

<cfoutput>
&lt;cfcase value="d"&gt;<br>
&lt;cfquery name="#tablename#" datasource="#datasourcename#" dbtype="odbc"&gt;<br>
SELECT * FROM #tablename#<br>
WHERE #pk_field# = ##URL.ID##;<br>
&lt;/cfquery&gt;<br>
&lt;cfquery name="remove_#tablename#" datasource="#datasourcename#" dbtype="odbc"&gt;<br>
DELETE FROM #tablename#<br>
WHERE #pk_field# = ##URL.ID##;<br>
&lt;/cfquery&gt;<br>
&lt;/cfcase&gt;<br><br>
</cfoutput>

<cfoutput>
&lt;cfcase value="l"&gt;<br>
&lt;cfquery name="#tablename#" datasource="#datasourcename#" dbtype="ODBC"&gt;<br>
SELECT *<br>
FROM #tablename#;<br>
&lt;/cfquery&gt;<br>
&lt;/cfcase&gt;<br>
&lt;/cfswitch&gt;<br><br>
</cfoutput>

<cfoutput>
&lt;html&gt;<br>
&lt;head&gt;<br>
&lt;title&gt;CodeTableTemplate&lt;/title&gt;<br>
&lt;meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"&gt;<br>
&lt;/head&gt;<br>
&lt;body&gt;<br>
</cfoutput>


&lt;cfswitch expression="#URL.a#"&gt;<br>
&lt;cfcase value="n,s"&gt;<br>
&lt;cfif URL.a IS "N"&gt;<br>
     &lt;cfset button_label = "Add"&gt;<br>
     &lt;cfset a = "i"&gt;<br>
&lt;cfelseif URL.a IS "s"&gt;<br>
     &lt;cfset button_label = "Update"&gt;<br>
     &lt;cfset a = "u&id=#id#"&gt;<br>
&lt;/cfif&gt;<br>

&lt;cfoutput&gt;<br>
&lt;form action="<cfoutput>#tablename#</cfoutput>.cfm?a=#a#" method="post"&gt;&lt;/cfoutput&gt;<br>
  &lt;table border="0" cellpadding="2" cellspacing="0"&gt;<br>
<cfoutput>
<cfloop index="x" list="#the_fields#">
   &lt;tr&gt;<br>
      &lt;td align="right"&gt;#x#&lt;/td&gt;<br>
      &lt;td&gt;&lt;input name="#x#" type="text" id="#x#" value="&lt;cfoutput&gt;###tablename#.#x###&lt;/cfoutput&gt;"&gt;&lt;/td&gt;<br>
    &lt;/tr&gt;<br>
</cfloop>
</cfoutput>

&lt;tr&gt;<br>
      &lt;Td&gt;&lt;/Td&gt;<br>
      &lt;Td&gt;&lt;cfoutput&gt;&lt;input name="" type="submit" value="#button_label#"&gt;&lt;/cfoutput&gt;<br>
        &lt;cfif URL.a IS "s"&gt;<br>
          &lt;cfoutput&gt;<br>
          &lt;/td&gt;&lt;/form&gt;<br>&lt;td&gt;<br>
          &lt;form action="<cfoutput>#tablename#</cfoutput>.cfm?a=d&id=#URL.ID#" method="post"&gt;&lt;input type="submit" value="Delete"&gt;
&lt;/cfoutput&gt;&lt;/cfif&gt;&lt;/Td&gt;&lt;/form&gt;<br>
&lt;/tr&gt;<br>
&lt;/table&gt;<br>

&lt;/cfcase&gt;<br><br>

&lt;cfcase value="i,d,u"&gt;<br>
     &lt;cfif URL.a IS "i"&gt;<br>
          You have just added a record:&lt;br&gt;<br>
     &lt;cfelseif URL.a IS "d"&gt;<br>
          YOu have just removed the record:&lt;br&gt;<br>
     &lt;cfelseif URL.a IS "u"&gt;<br>
          You have just updated the record:&lt;br&gt;<br>
     &lt;/cfif&gt;<br>

&lt;cfoutput&gt;<br>
<cfloop index="x" list="#the_fields#">
<cfoutput>###tablename#.#x###&lt;br&gt;<br></cfoutput>
</cfloop>     
&lt;/cfoutput&gt;<br>
     
<cfoutput>&lt;a href="#tablename#.cfm?a=l"&gt;LIST&lt;/a&gt;<br></cfoutput>
&lt;/cfcase&gt;<br>
&lt;cfcase value="l"&gt;<br>
&lt;cfoutput&gt;<br>
&lt;form action="<cfoutput>#tablename#</cfoutput>.cfm?a=n" method="post"&gt;&lt;input type="submit" value="Add"&gt;&lt;/form&gt;
&lt;/cfoutput&gt;<br>

&lt;table border="1"&gt;<br>
&lt;tr&gt;<br>
<cfoutput>
<cfloop index="x" list="#the_fields#">
&lt;td&gt;#x#&lt;/td&gt;<br>
</cfloop>
</cfoutput>

&lt;/tr&gt;<br>
<cfoutput>&lt;cfoutput query="#tablename#"&gt;</cfoutput><br>

&lt;tr&gt;<br>
<cfloop index="x" list="#the_fields#">
&lt;td&gt;<cfoutput>###x###</cfoutput>&lt;/td&gt;<br></cfloop>
&lt;td&gt;&lt;a href="<cfoutput>#tablename#</cfoutput>.cfm?a=s&id=#<cfoutput>#pk_field#</cfoutput>#"&gt;Edit&lt;/a&gt;&lt;/TD&gt;<br>
&lt;/tr&gt;<br>
&lt;/cfoutput&gt;<br>
&lt;/table&gt;<br>

&lt;/cfcase&gt;<br>
&lt;/cfswitch&gt;<br>
&lt;/body&gt;<br>
&lt;/html&gt;<br>
