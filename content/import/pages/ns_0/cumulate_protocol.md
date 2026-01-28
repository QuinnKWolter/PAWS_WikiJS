---
title: "CUMULATE protocol"
source_namespace: "ns_0"
source_filename: "CUMULATE_protocol.md"
---

This page describes the protocol of interaction with
[CUMULATE](/ns_0/cumulate) and
provides an exhaustive references with code examples in Java and sample
outputs in XML.

= URLs of web-services =
These are the URLs of the
web-services that implement components of the ADAPT² architecture and
protocol.

**User Activity report receiver** - this service listens to
applications that report user activity


    http://adapt2.sis.pitt.edu/cbum/um



**Report Manager** - service that answers queries about users'
progress with learning objects and mastery of concepts


    http://adapt2.sis.pitt.edu/cbum/ReportManager



<a href="#top" class="wikilink" title="^top">^top</a>

= Parameter
Naming Conventions =
The following parameter names (and their possible
values) should be used in communication between all applications using
ADAPT² protocol.
* **usr** – user, user login
* **sid** – session
id
* **app** – application, activity server
** **1** – Unknown
application
** **2** – QuizPACK
** **3** – WebEx
** **4** –
WADEIn
** **5** – KnowledgeSea
** **6** – AnnotatEd
** **7** –
venn
** **8** – KnowledgeTree
** **9** – NavEx
** **10** –
CourseAgent
** **11** – cWADEIn II
** **12** – VIBE
** **13** –
VirtPresenter
** **14** – Problets
** **15** – VarScope
**
**16** – BooleanTool
** **17** – Jeliot
** **18** – WOTAN
**
**19** – SQL-Tutor
** **20** – QuizQUIDE
** **21** – jWADEIn
II
** **22** – free slot
** **23** – SQL KnoT
** **24** –
ADAPT² PService
** **25** – QuizJET
* **act** – learning action,
learning object – minimally invokable piece of learning object (quiz,
example etc.)
* **sub** – sub-action, step of learning action,
fragment of learning object – minimal trackable piece of learning object
(question of quiz, line of example etc.)
* **grp** – group name;
suggested naming convention for group name is {academic year, semester,
group identified or name within semester}, e.g. 200621 – Spring 2006,
group 1
* **res** – result of the interaction – any decimal value e.g.
-1, 0, 0.4, 0.7, 1
* **svc** – service parameter – any character
string that can be used to store system state, should not contain ?
(question mark), & (ampersand), : (colon), and / (backward slash);
however all those symbols can be encoded using Java URLEncoder class
that maps them to %XX; service parameter
* **lev** – Bloom's level -
comma separated combinations of the ones below without spaces (e.g.
knowledge,comprehension)
** **knowledge** (KnowledgeSea)
**
**comprehension** (WebEx/NavEx, WADEIn in exploration mode)
**
**application** (QuizPACK/QuizGuide, WADEIn in evaluation mode)
**
**synthesis**
* **prc** – precision
* **ums** – user modeling
server URL for reporting user activity to
* **dom** – learning domain
(e.g. C programming), will define the concepts ontology
* **con** -
concept - knowledge component of a learning domain
* **scp** – scope
of activities (used for multiple groupings of activities)
* **ip** –
IP address - e.g. IP of an anonymous user

It is advised to use these
parameters and values even
internally.

<a href="#top" class="wikilink" title="^top">^top</a>

=
Protocol for user authentication and activity invocation =

This
protocol is adopted not only by CUMULATE but by most of the
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
tools. It regulates how user and resource identities is transferred from
application to application via the following HTTP parameters
*
**usr** - user identifier, usually login (mandatory)
* **grp** - group
identifier (mandatory), just like a user identifier, but for a group of
users (class, research team)
* **sid** - session identifier
(optional), usually 5 character string each application makes a choice
whether and how to come up with this parameter (e.g. truncate [\| Apache
Tomcat](http://en.wikipedia.org/wiki/Apache_Tomcat) session id to last 5
characters)
* **act** - id of the resource (mandatory), each
application maintains its own vocabulary of resource ids
* **sub** -
if resource is a collection of multiple resources/steps, then a
sub-resource id is supplied (optional)

= Protocol for reporting user
activity =

This protocol allows external applications to send the
infomation about user actions to the user model. To successfully report
user activity, the external application should describe what learning
object the user has been working with, who the user is, and what was the
result of the interaction.

Request URL Format:



http://<report_servlet>?app=<application_id> &act=<learning_object> &sub=<learning_object_step> &usr=<user> &gpr=<group> &sid=<session_id> &res=<result> &svc=<service_parameters>



,where:
* **app** – **mandatory**, application id, for a list of
valid application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>
*
**act** – **mandatory**, learning object, the user has been working
with
* **sub** – **mandatory**/optional (depending on application),
the step of the learning object (if such exists)
* **usr** –
**mandatory**, user whose activity is reported
* **grp** –
**mandatory**, group, user is member of
* **sid** – **mandatory**, the
id of the session (for tracking purposes), a token of up to 5
characters
* **res** – **mandatory**, the result of interaction, 0 if
unsuccessful, 1 if successful, or any value in between in case of
partial success, -1 is reserved for "no credit" activity
* **svc** –
*optional*, an arbitrary string the application might want to store for
later (e.g. capturing context), not parsed by user modeling server
*
**ip** - *optional*, ip address of the remote user

Example request
URL:


    http://adapt2.sis.pitt.edu/cbum/um?app=3&act=helloworld.c&sub=12&usr=myudelson&grp=200721&sid=FD34A&res=1&svc=adaptive_link



<a href="#top" class="wikilink" title="^top">^top</a>

#### Using Report API to send reports to User Model

A special ReportAPI class
can be used to send HTTP Get requests to User Model. Refer to example
below. To use ReportAPI class, download
[paws-cbum-reportapi.jar](http://www.sis.pitt.edu/~paws/assets/paws-cbum-reportapi.jar)
that contains appropriate classes.



import edu.pitt.sis.paws.cbum.report.*;
...
int app_id = ...;
String act = ...;
String sub = ...;
String sid = ...;
double res = ...;
String grp = ...;
String usr = ...;
String svc = ...;
// initialize ReportAPI object with URL of the User Model
ReportAPI r_api = new ReportAPI("http://adapt2.sis.pitt.edu/cbum/um");
try
{
   //Send report
   r_api.report(app_id, act, sub, sid, res, grp, usr, svc);
}
catch (ServletException se) ...
catch (IOException ioe)...




<a href="#top" class="wikilink" title="^top">^top</a>

#### Sending reports from Applets via relay servlet

When a learning object is
implemented as Java Applet it is sometimes not possible to send reports
to remote servers via HTTP Get requests due to security limitation. To
overcome this obstacle, a local **relay servlet** can be used. Below is
a step-by-step procedure of deploying configuring a relay servlet that
we have created.

# Download

[paws-cbum-reportapi.jar](http://www.sis.pitt.edu/~paws/assets/paws-cbum-reportapi.jar)
that contains appropriate classes and put it to **WEB-INF/lib**' folder
of your project

# Add the following lines to the **web.xml** file in

**WEB-INF** folder of your project (refer to example below)

# Send user

activity report requests to
**<http://localhost:8080/your_application/your_servlet_pattern>**. They
will be forwarded to remote UM server appropriately. Here
**your_application** (e.g. **problets**) is a folder of your project,
and **your_servlet_pattern** is the same as configured in **web.xml**
file (e.g. um_relay).



<?xml version="1.0" encoding="UTF-8"?>
<web-app id="WebApp_ID" version="2.4"
   xmlns="http://java.sun.com/xml/ns/j2ee"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee
   http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd">
   ...
   <context-param>
      <param-name>umrelay</param-name>
      <param-value>http://adapt2.sis.pitt.edu/cbum/um</param-value>
   </context-param>
   ...
   <servlet>
      <servlet-name>UMActivityReportRelay</servlet-name>
      <servlet-class>edu.pitt.sis.paws.cbum.report.UMActivityReportRelay</servlet-class>
   </servlet>
   <servlet-mapping>
      <servlet-name>UMActivityReportRelay</servlet-name>
      <url-pattern>your_servlet_pattern</url-pattern>
   </servlet-mapping>
   ...
</web-app>




<a href="#top" class="wikilink" title="^top">^top</a>

= Protocol
for reporting changes in user knowledge =

This protocol allows
external applications to send the infomation about user actions to the
user model. To successfully report user activity the external aplication
should describe what learning object the user has been working with, who
is the user, and what was the result of the interaction.

Request URL
Format:



http://adapt2.sis.pitt.edu/cbum/umc?app=<application_id> &usr=<user> &grp=<group> &dom=<learning domain> &con=<concept list> &val=<result list> &sid=<session_id> &svc=<service_parameters>



,where:
* **app** – **mandatory**, application id, for a list of
valid application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>
*
**usr** – **mandatory**, user whose activity is reported
* **grp** –
**mandatory**, group, user is member of
* **dom** – **mandatory**
learning domain (e.g. C programming), from which the reported concepts
are coming
* **con** – **mandatory**, comma-separated list of concept
names
* **val** – **mandatory**, comma-separated list (same
cardinality as **con**) of the results of concept application, each from
\[0, 1\]
* **sid** – **mandatory**, the id of the session (for
tracking purposes), a token of up to 5 characters
* **svc** –
*optional*, an arbitrary string the application might want to store for
later (e.g. capturing context), not parsed by user modeling
server

Example request URL:


    http://adapt2.sis.pitt.edu/cbum/umc?app=19&usr=joe&grp=class12&dom=sql_concepts&con=Table,MultipleTableSelection,WhereClause&val=-1,0.5,-1&sid=1&svc=5



There is no api support for this protocol yet.

= Protocol for
requesting user progress =
User progress is measured with respect to
completeness of exploration of learning objects. Progress is described
in terms of: 1) now many steps of the learning objet were explored, 2)
how many attempts user has made while exploring. Information about user
progress can be requested in XML format and in the format of Java
serialized objects.

#### Getting user progress report in an XML format

This protocol allows requesting user progress with a set of learning
objects in an XML format. The set of learning objects are constrained by
specifying application that serves learning objects and possibly a
scope - group of learning objects within that application. In addition
to individual user progress an average user progress can be requested
(for example to implement social navigation).

**Request URL
Format:**


    http://<report_manager>?typ=<information_type>&dir=<upload_request>&frm=<format>&app=<application_id>&usr=<user>&gpr=<group>&scp=<scope>



,where:

* **typ** – **mandatory**, type of report, here should
always be **act** (user action, learning object)
* **dir** –
**mandatory**, direction of communication with report manager, should
always be **out** (report manager only sending information nothing is
taken in) for GET requests
* **frm** – **mandatory**, format, e.g. for
xml report should be **xml**
* **app** – **mandatory**, application
id, for a list of valid application ids refer to section
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>
*
**usr** – **mandatory**, user who's progress report is requested
*
**grp** – **mandatory**, user group, if present an average group report
will be added to individual user report

**Example request URL:**


    http://adapt2.sis.pitt.edu/cbum/ReportManager?typ=act&dir=out&frm=xml&app=2&usr=myudelson&grp=200721



**XML Example:**
Below is an example of the returned XML, where
learning object 2dimensional_array1 with 3 steps: 1, 2, and 3 that have
been performed 25, 12, and 3 times respectively and the user progress
for those steps is .3, .2, and .1 respectively.
In addition CUMULATE
lets you know several other [things:
](things:
)* the number of users
in the group via **member_count** attribute of **group** tag (here
30)
* the date-time of the most recent user transaction registered by
CUMULATE for this user via **user-hash** tag
* the date-time of the
most recent user transaction registered by CUMULATE for this user and
the application specified via **user-app-hash** tag



<?xml version='1.0' encoding='UTF-8'?>
<report>
   <user>myudelson</user>
   <user-app-hash>2007-11-07 16:30:54.497</user-app-hash>
   <user-hash>2007-11-28 12:03:45.250</user-hash>
   <group member_count="30">200721</group>
   <activities>
      <activity>
         <name>2dimensional_array1</name>
         <subactivity>
            <name>0</name>
            <individual>
               <count>25</count>
               <progress>0.3</progress>
            </individual>
         </subactivity>
         <subactivity>
            <name>1</name>
            <individual>
               <count>12</count>
               <progress>0.2</progress>
            </individual>
         </subactivity>
         <subactivity>
            <name>2</name>
            <individual>
               <count>3</count>
               <progress>0.1</progress>
            </individual>
         </subactivity>
      </activity>
      ...
   </activities>
</report>




<a href="#top" class="wikilink" title="^top">^top</a>

#### Getting user progress report in the format of Java serialized objects

This
protocol works in a similar fashion as the one in the previous section
<a href="#Getting_user_progress_report_in_an_XML_format"
class="wikilink" title=" Getting user progress report in an XML format">
Getting user progress report in an XML format</a>. In addition it allows
to submit requests for specific set of learning objects within
application-scope hierarchy. There are two scenarios for requesting the
report:

# Requesting user progress with learning objects of a whole

application or application scope, or

# Requesting user progress with a

***limited subset*** of learning objects of the application or
application scope.

In both scenarios receiving of the report is
identical. In the second case a list of the requested learning objects'
character IDs should be uploaded to the Report Manager
web-service.

In order to be able to parse the response of the Report
Manager you need to include
**edu.pitt.sis.paws.cbum.structures.report.ProgressEstimatorReport**
class from
[paws-cbum-reportapi.jar](http://www.sis.pitt.edu/~paws/assets/paws-cbum-reportapi.jar)
file.

**Request URL Format:**


    http://<report_manager>?typ=<information_type>&dir=<upload_request>&frm=<format>&app=<application_id>&usr=<user>&gpr=<group>&scp=<scope>


,where:
* **typ** – **mandatory**, type of report, here should
always be **act** (user progress with a learning object)
* **dir** –
**mandatory**, upload request flag, should be either **out** (if
scenario 1 is used) or in (if scenario 2 is user)
* **frm** –
**mandatory**, format, for Java serialized objects report should be
**dat**
* **app** – **mandatory**, application id, for a list of valid
application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>
*
**usr** – **mandatory**, user whose progress is requested
* **grp** –
**mandatory**, user group, if present an average group report will be
added to individual user report

**Example request URL:**


    http://adapt2.sis.pitt.edu/cbum/ReportManager?typ=act&dir=out&frm=dat&app=2&usr=myudelson&grp=200721


This request will return result equivalent to the XML returned by the
example request of the previous section.

**Java example 1**: Using
scenario 1 to request user progress with all learning objects of
application with id 12



import java.net.*;
import java.util.*;
import java.edu.pitt.sis.paws.cbum.structures.report.ProgressEstimatorReport;
...
String report_manager_url = "http://adapt2.sis.pitt.edu/cbum/ReportManager";
String user_login = "myudelson";
String group = "200721";
String application_id= "12";
ArrayList um_response = null; // report will be saved in this variable
try
{
   // requesting report - dir=out
   URL url = new URL(report_manager_url + "?typ=act&dir=out&frm=dat&app=" +
      application_id + "&usr=" + user_login + "&grp=" + group);
   URLConnection conn = url.openConnection();
   ObjectInputStream recv_stream = new ObjectInputStream(conn.getInputStream());
   try
   {
      um_response = (ArrayList)recv_stream.readObject();
   }
   catch(Exception e) { e.printStackTrace(System.err); }
   finally { recv_stream.close(); }

   // parsing the report
   double user_progress = 0.0;
   for(int i=0; i<um_response.size(); i++)
   {
      user_progress = ((ProgressEstimatorReport)um_response.get(i)).progress;
      // save user_progress elsewhere
      ...
   }
   ...
}
catch(Exception e) { e.printStackTrace(System.out); }




**Java example 2**: Using scenario 2 to request user progress with 2
learning objects lo_one and lo_two of application with id 12



import java.net.*;
import java.util.*;
import java.edu.pitt.sis.paws.cbum.structures.report.ProgressEstimatorReport;
...
String report_manager_url = "http://adapt2.sis.pitt.edu/cbum/ReportManager";
String user_login = "myudelson";
String group = "200721";
String application_id= "12";
ArrayList um_response = null; // report will be saved in this variable
ArrayList request = null; // request will be formed in this variable
try
{
   // create the request
   request = new ArrayList();
   request.add(new ProgressEstimatorReport("lo_one", 0, 0));;
   request.add(new ProgressEstimatorReport("lo_two", 0, 0));;

   // upload the request - dir=in
   URL url = new URL(report_manager_url + "?typ=act&dir=in&frm=dat&app=" +
      application_id + "&usr=" + user_login + "&grp=" + group);
   URLConnection conn = url.openConnection();
   conn.setUseCaches(false);
   conn.setDefaultUseCaches(false);
   conn.setDoOutput(true);
   conn.setDoInput(true);
   conn.setRequestProperty("Content-Type","java-internal/" + req.getClass().getName());
   ObjectOutputStream send_strean = new ObjectOutputStream(conn.getOutputStream());
   send_strean.writeObject(req);
   send_strean.flush();
   send_strean.close();

   // receiving report
   ObjectInputStream recv_stream = new ObjectInputStream(conn.getInputStream());
   try
   {
      um_response = (ArrayList)recv_stream.readObject();
   }
   catch(Exception e) { e.printStackTrace(System.err); }
   finally { recv_stream.close(); }

   // parsing the report
   double user_progress = 0.0;
   for(int i=0; i<um_response.size(); i++}
   {
      user_progress = ((ProgressEstimatorReport)um_response.get(i)).progress;
      // save user_progress elsewhere
   }
   ...
}
catch(Exception e) { e.printStackTrace(System.out); }




<a href="#top" class="wikilink" title="^top">^top</a>


=
Protocol for requesting user knowledge of concepts =
User knowledge of
concepts is measured as probability of knowing a portion of learning
domain described by certain concepts. Information about user progress
can be requested in XML format and in the format of Java serialized
objects.

#### Getting user knowledge of concepts report in an XML format

This protocol allows various applications to obtain knowledge
with respect to multiple Bloom levels for a set of
concepts.

**Request URL Format:**



http://<report_manager>?typ=<information_type>&dir=<upload_request>&frm=<format>&app=<application_id>&usr=<user>&gpr=<group>&dom=<domain>&lev=<Bloom_level(s)>



,where:
* **typ** – **mandatory**, type of report, here should
always be **con** (concept progress)
* **dir** – **mandatory**, upload
request flag, should always be **out** (no upload) for GET requests
*
**frm** – **mandatory**, format, format, for XML report should be
**xml**
* **app** – **mandatory**, application id, for a list of valid
application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>
*
**usr** – **mandatory**, user whose progress is requested
* **grp** –
**mandatory**, user group
* **lev** – *optional*, Bloom levels to be
reported, allowed values: **knowledge**, **comprehension**,
**application**, **synthesis** or a delimited list of them, if
unspecified – all levels are reported
* **dom** – **mandatory**,
concepts' domain (ontology)

**Example request URL:**



http://adapt2.sis.pitt.edu/cbum/ReportManager?typ=con&dir=out&frm=xml&app=2&usr=myudelson&grp=200721&lev=application&dom=c_programming




Below is a n example of the returned XML.
In addition CUMULATE lets
you know several other [things:
](things:
)* the date-time of the
most recent user transaction registered by CUMULATE for this user via
**user-hash** tag
* the date-time of the most recent user transaction
registered by CUMULATE for this user and the application specified via
**user-app-hash** tag




<?xml version='1.0' encoding='UTF-8' ?>
<report>
   <user>myudelson</user>
   <user-app-hash>2009-06-11 20:20:05.545</user-app-hash>
   <user-hash>2009-06-11 20:20:05.545</user-hash>
   <concepts>
      ...
      <concept>
         <name>add</name>
         <cog_levels>
            <cog_level>
               <name>application</name>
               <value>0.6266574470377776</value>
            </cog_level>
         </cog_levels>
      </concept>
      <concept>
         <name>sub</name>
         <cog_levels>
            <cog_level>
               <name>application</name>
               <value>0.36388277385950873</value>
            </cog_level>
         </cog_levels>
      </concept>
      ...
      </concepts>
</report>




<a href="#top" class="wikilink" title="^top">^top</a>

== Getting
user knowledge of concepts report in the format of Java serialized
objects ==
The protocol is identical to one in the previous section
6.1. In addition it allows to submit requests for specific concepts
rather than the whole realm of concepts or a domain of concepts. The
report is returned in the form of Java serialized objects.

**Request
URL Format:**



http://<report_manager>?typ=<information_type>&dir=<upload_request>&frm=<format>&app=<application_id>&usr=<user>&gpr=<group>&dom=<scope>



,where:
* **typ** – **mandatory**, type of report, here should
always be con (concept)
* **dir** – **mandatory**, upload request
flag, can be in or out, depending on whether you want to upload the ids
of the concepts that you'd like to receive the report about
* **frm**
– **mandatory**, format, for Java serialized objects report should be
dat
* **app** – **mandatory**, application id, for a list of valid
application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>
*
**usr** – **mandatory**, user whose progress is requested
* **grp** –
**mandatory**, user group
* **dom** – **mandatory**, concepts' domain
(ontology), if not specified the whole realm of concepts are
reported

**Example request URL:**



http://adapt2.sis.pitt.edu/cbum/ReportManager?typ=con&dir=in&frm=dat&app=2&usr=myudelson&grp=200721&dom=c_programming




This request will return result equivalent to the XML returned by
the example request of the previous section.



Java example 1: Requesting concepts of a specific domain
import java.net.*;
import java.util.*;
...
String report_manager_url = "http://adapt2.sis.pitt.edu/cbum/ReportManager";
String user_login = "myudelson";
String group = "200721";
String concept_cognitive_levels = "application";
String domain = "c_programming";
String application_id= "3";
ArrayList um_response = null; // user model report withh be saved in this variable
try
{
   URL url = new URL(report_manager_url + "?typ=con&dir=out&frm=dat&lev=" +
      concept_cognitive_levels +"&app=" + application_id +
      "&usr=" + user_login + "&grp=" + group + "&dom=" + domain);
   URLConnection conn = url.openConnection();
   ObjectInputStream recv_stream = new ObjectInputStream(conn.getInputStream());
   try
   {
      um_response = (ArrayList)recv_stream.readObject();
   }
   catch(Exception e) { e.printStackTrace(System.err); }
   finally { recv_stream.close(); }
}
catch(Exception e) { e.printStackTrace(System.out); }




<a href="#top" class="wikilink" title="^top">^top</a>

= Protocol
for Requesting Concept-Activity Indexing =
For each of the activities
(aka learning objects) CUMULATE can store a list of knowledge concepts
from a particular domain. The following protocols expose this
indexing.

#### Getting Concepts for an Activity (List of Activities)

This protocol lists concepts connected to a given activity (list of
activities).

**Request URL Format:**



http://<report_manager>?typ=<information_type>&frm=<format>&app=<application_id>&act=<activity>&dom=<domain>



,where:
* **typ** – **mandatory**, type of report, here should
always be **act2con** (activity-to-concept mapping)
* **dir** –
**mandatory**, upload request flag, should be **in**
* **frm** –
**mandatory**, format, supported formats are XML and RDF - **xml** and
**rdf** values respectively
* **app** – **mandatory**, application id
mapping of activities of which are requested, for a list of valid
application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>
*
**act** – **mandatory**, activity, or a comma-delimited list of
activities
* **dom** – **mandatory**, domain of concepts

**Example
request URL (XML format):**



http://adapt2.sis.pitt.edu/cbum/ReportManager?typ=act2con&dir=in&frm=xml&app=3&act=helloworld.c,printing.c&dom=c_programming




And the returned XML result:



<?xml version='1.0' encoding='UTF-8'?>
<report>
\t<mappings>
\t\t<mapping>
\t\t\t<activity>helloworld.c</activity>
\t\t\t<concept>printf</concept>
\t\t\t<concept>main_function</concept>
\t\t\t<concept>include</concept>
\t\t\t<concept>void</concept>
\t\t</mapping>
\t\t<mapping>
\t\t\t<activity>printing.c</activity>
\t\t\t<concept>printf</concept>
\t\t\t<concept>main_function</concept>
\t\t\t<concept>include</concept>
\t\t\t<concept>void</concept>
\t\t</mapping>
\t</mappings>
</report>




**Example request URL (RDF format):**



http://adapt2.sis.pitt.edu/cbum/ReportManager?typ=act2con&dir=in&frm=rdf&app=3&act=helloworld.c,printing.c&dom=c_programming




And the returned RDF result:



<?xml version='1.0' encoding='UTF-8'?>
<rdf:RDF
\txmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'
\txmlns:dc='http://purl.org/dc/elements/1.1/'>

\t<rdf:Description rdf:about='http://adapt2.sis.pitt.edu/webex/webex.rdf#helloworld.c'>
\t\t<dc:subject>printf</dc:subject>
\t\t<dc:subject>main_function</dc:subject>
\t\t<dc:subject>include</dc:subject>
\t\t<dc:subject>void</dc:subject>
\t</rdf:Description>
\t<rdf:Description rdf:about='http://adapt2.sis.pitt.edu/webex/webex.rdf#printing.c'>
\t\t<dc:subject>printf</dc:subject>
\t\t<dc:subject>main_function</dc:subject>
\t\t<dc:subject>include</dc:subject>
\t\t<dc:subject>void</dc:subject>
\t</rdf:Description>
</rdf:RDF>




<a href="#top" class="wikilink" title="^top">^top</a>

#### Getting Activities for a Concept (List of Concepts)

This protocol lists
activities connected to a given concepts (list of
concepts).

**Request URL Format:**



http://<report_manager>?typ=<information_type>&frm=<format>&app=<application_id>&con=<concept>&dom=<domain>



,where:
* **typ** – **mandatory**, type of report, here should
always be **con2act** (concept-to-activity mapping)
* **dir** –
**mandatory**, upload request flag, should be **in**
* **frm** –
**mandatory**, format, supported formats are XML and RDF - **xml** and
**rdf** values respectively (RDF is not supported yet)
* **app** –
**mandatory**, application id activities of which concepts are mapped
to, for a list of valid application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>
*
**dom** – **mandatory**, domain of concepts
* **con** – **mandatory**,
concept, or a comma-delimited list of concepts

**Example request URL
(XML format)**



http://adapt2.sis.pitt.edu/cbum/ReportManager?typ=con2act&dir=in&frm=xml&app=3&con=printf,if_else&dom=c_programming




And the returned XML result:



<?xml version='1.0' encoding='UTF-8'?>
<report>
\t<mappings>
\t\t<mapping>
\t\t\t<concept>printf</concept>
\t\t\t<activity>abcounting.c</activity>
\t\t\t<activity>abcounting_case.c</activity>
\t\t\t<activity>accumulator.c</activity>
\t\t\t...
\t\t</mapping>
\t\t<mapping>
\t\t\t<concept>if_else</concept>
\t\t\t<activity>abcounting.c</activity>
\t\t\t<activity>babyweighting.c</activity>
\t\t\t<activity>battleship.c</activity>
\t\t\t<activity>betterbattle.c</activity>
\t\t\t...
\t\t</mapping>
\t</mappings>
</report>




<a href="#top" class="wikilink" title="^top">^top</a>
