This page describes the protocol of interaction with
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a> and
provides an exhaustive references with code examples in Java and sample
outputs in XML.\n\n= URLs of web-services = \nThese are the URLs of the
web-services that implement components of the ADAPT² architecture and
protocol.\n\n**User Activity report receiver** - this service listens to
applications that report user activity\n

    http://adapt2.sis.pitt.edu/cbum/um

\n\n**Report Manager** - service that answers queries about users'
progress with learning objects and mastery of concepts\n

    http://adapt2.sis.pitt.edu/cbum/ReportManager

\n\n<a href="#top" class="wikilink" title="^top">^top</a>\n\n= Parameter
Naming Conventions =\nThe following parameter names (and their possible
values) should be used in communication between all applications using
ADAPT² protocol.\n\* **usr** – user, user login\n\* **sid** – session
id\n\* **app** – application, activity server\n\*\* **1** – Unknown
application\n\*\* **2** – QuizPACK\n\*\* **3** – WebEx\n\*\* **4** –
WADEIn\n\*\* **5** – KnowledgeSea\n\*\* **6** – AnnotatEd\n\*\* **7** –
venn\n\*\* **8** – KnowledgeTree\n\*\* **9** – NavEx\n\*\* **10** –
CourseAgent\n\*\* **11** – cWADEIn II\n\*\* **12** – VIBE\n\*\* **13** –
VirtPresenter\n\*\* **14** – Problets\n\*\* **15** – VarScope\n\*\*
**16** – BooleanTool\n\*\* **17** – Jeliot\n\*\* **18** – WOTAN\n\*\*
**19** – SQL-Tutor\n\*\* **20** – QuizQUIDE\n\*\* **21** – jWADEIn
II\n\*\* **22** – free slot\n\*\* **23** – SQL KnoT\n\*\* **24** –
ADAPT² PService\n\*\* **25** – QuizJET\n\* **act** – learning action,
learning object – minimally invokable piece of learning object (quiz,
example etc.)\n\* **sub** – sub-action, step of learning action,
fragment of learning object – minimal trackable piece of learning object
(question of quiz, line of example etc.)\n\* **grp** – group name;
suggested naming convention for group name is {academic year, semester,
group identified or name within semester}, e.g. 200621 – Spring 2006,
group 1\n\* **res** – result of the interaction – any decimal value e.g.
-1, 0, 0.4, 0.7, 1\n\* **svc** – service parameter – any character
string that can be used to store system state, should not contain ?
(question mark), & (ampersand), : (colon), and / (backward slash);
however all those symbols can be encoded using Java URLEncoder class
that maps them to %XX; service parameter\n\* **lev** – Bloom's level -
comma separated combinations of the ones below without spaces (e.g.
knowledge,comprehension)\n\*\* **knowledge** (KnowledgeSea)\n\*\*
**comprehension** (WebEx/NavEx, WADEIn in exploration mode)\n\*\*
**application** (QuizPACK/QuizGuide, WADEIn in evaluation mode)\n\*\*
**synthesis** \n\* **prc** – precision\n\* **ums** – user modeling
server URL for reporting user activity to\n\* **dom** – learning domain
(e.g. C programming), will define the concepts ontology\n\* **con** -
concept - knowledge component of a learning domain\n\* **scp** – scope
of activities (used for multiple groupings of activities)\n\* **ip** –
IP address - e.g. IP of an anonymous user\n\nIt is advised to use these
parameters and values even
internally.\n\n<a href="#top" class="wikilink" title="^top">^top</a>\n\n=
Protocol for user authentication and activity invocation =\n\nThis
protocol is adopted not only by CUMULATE but by most of the
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
tools. It regulates how user and resource identities is transferred from
application to application via the following HTTP parameters\n\*
**usr** - user identifier, usually login (mandatory)\n\* **grp** - group
identifier (mandatory), just like a user identifier, but for a group of
users (class, research team)\n\* **sid** - session identifier
(optional), usually 5 character string each application makes a choice
whether and how to come up with this parameter (e.g. truncate [\| Apache
Tomcat](http://en.wikipedia.org/wiki/Apache_Tomcat) session id to last 5
characters)\n\* **act** - id of the resource (mandatory), each
application maintains its own vocabulary of resource ids\n\* **sub** -
if resource is a collection of multiple resources/steps, then a
sub-resource id is supplied (optional)\n\n= Protocol for reporting user
activity =\n\nThis protocol allows external applications to send the
infomation about user actions to the user model. To successfully report
user activity, the external application should describe what learning
object the user has been working with, who the user is, and what was the
result of the interaction. \n\nRequest URL Format:\n

    \nhttp://<report_servlet>?app=<application_id> &act=<learning_object> &sub=<learning_object_step> &usr=<user> &gpr=<group> &sid=<session_id> &res=<result> &svc=<service_parameters>\n

\n,where:\n\* **app** – **mandatory**, application id, for a list of
valid application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>\n\*
**act** – **mandatory**, learning object, the user has been working
with\n\* **sub** – **mandatory**/optional (depending on application),
the step of the learning object (if such exists)\n\* **usr** –
**mandatory**, user whose activity is reported\n\* **grp** –
**mandatory**, group, user is member of\n\* **sid** – **mandatory**, the
id of the session (for tracking purposes), a token of up to 5
characters\n\* **res** – **mandatory**, the result of interaction, 0 if
unsuccessful, 1 if successful, or any value in between in case of
partial success, -1 is reserved for "no credit" activity\n\* **svc** –
*optional*, an arbitrary string the application might want to store for
later (e.g. capturing context), not parsed by user modeling server\n\*
**ip** - *optional*, ip address of the remote user\n\nExample request
URL:\n

    http://adapt2.sis.pitt.edu/cbum/um?app=3&act=helloworld.c&sub=12&usr=myudelson&grp=200721&sid=FD34A&res=1&svc=adaptive_link

\n\n<a href="#top" class="wikilink" title="^top">^top</a>\n\n== Using
Report API to send reports to User Model ==\nA special ReportAPI class
can be used to send HTTP Get requests to User Model. Refer to example
below. To use ReportAPI class, download
[paws-cbum-reportapi.jar](http://www.sis.pitt.edu/~paws/assets/paws-cbum-reportapi.jar)
that contains appropriate classes.\n

    \nimport edu.pitt.sis.paws.cbum.report.*;\n...\nint app_id = ...;\nString act = ...;\nString sub = ...;\nString sid = ...;\ndouble res = ...;\nString grp = ...;\nString usr = ...;\nString svc = ...;\n// initialize ReportAPI object with URL of the User Model\nReportAPI r_api = new ReportAPI("http://adapt2.sis.pitt.edu/cbum/um");\ntry\n{\n   //Send report\n   r_api.report(app_id, act, sub, sid, res, grp, usr, svc);\n}\ncatch (ServletException se) ...\ncatch (IOException ioe)...\n

\n\n<a href="#top" class="wikilink" title="^top">^top</a>\n\n== Sending
reports from Applets via relay servlet ==\nWhen a learning object is
implemented as Java Applet it is sometimes not possible to send reports
to remote servers via HTTP Get requests due to security limitation. To
overcome this obstacle, a local **relay servlet** can be used. Below is
a step-by-step procedure of deploying configuring a relay servlet that
we have created. \n\n# Download
[paws-cbum-reportapi.jar](http://www.sis.pitt.edu/~paws/assets/paws-cbum-reportapi.jar)
that contains appropriate classes and put it to **WEB-INF/lib**' folder
of your project\n# Add the following lines to the **web.xml** file in
**WEB-INF** folder of your project (refer to example below)\n# Send user
activity report requests to
**<http://localhost:8080/your_application/your_servlet_pattern>**. They
will be forwarded to remote UM server appropriately. Here
**your_application** (e.g. **problets**) is a folder of your project,
and **your_servlet_pattern** is the same as configured in **web.xml**
file (e.g. um_relay).\n

    \n<?xml version="1.0" encoding="UTF-8"?>\n<web-app id="WebApp_ID" version="2.4"\n   xmlns="http://java.sun.com/xml/ns/j2ee"\n   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\n   xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee\n   http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd">\n   ...\n   <context-param>\n      <param-name>umrelay</param-name>\n      <param-value>http://adapt2.sis.pitt.edu/cbum/um</param-value>\n   </context-param>\n   ...\n   <servlet>\n      <servlet-name>UMActivityReportRelay</servlet-name>\n      <servlet-class>edu.pitt.sis.paws.cbum.report.UMActivityReportRelay</servlet-class>\n   </servlet>\n   <servlet-mapping>\n      <servlet-name>UMActivityReportRelay</servlet-name>\n      <url-pattern>your_servlet_pattern</url-pattern>\n   </servlet-mapping>\n   ...\n</web-app>\n

\n\n<a href="#top" class="wikilink" title="^top">^top</a>\n\n= Protocol
for reporting changes in user knowledge =\n\nThis protocol allows
external applications to send the infomation about user actions to the
user model. To successfully report user activity the external aplication
should describe what learning object the user has been working with, who
is the user, and what was the result of the interaction. \n\nRequest URL
Format:\n

    \nhttp://adapt2.sis.pitt.edu/cbum/umc?app=<application_id> &usr=<user> &grp=<group> &dom=<learning domain> &con=<concept list> &val=<result list> &sid=<session_id> &svc=<service_parameters>\n

\n,where:\n\* **app** – **mandatory**, application id, for a list of
valid application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>\n\*
**usr** – **mandatory**, user whose activity is reported\n\* **grp** –
**mandatory**, group, user is member of\n\* **dom** – **mandatory**
learning domain (e.g. C programming), from which the reported concepts
are coming\n\* **con** – **mandatory**, comma-separated list of concept
names\n\* **val** – **mandatory**, comma-separated list (same
cardinality as **con**) of the results of concept application, each from
\[0, 1\]\n\* **sid** – **mandatory**, the id of the session (for
tracking purposes), a token of up to 5 characters\n\* **svc** –
*optional*, an arbitrary string the application might want to store for
later (e.g. capturing context), not parsed by user modeling
server\n\nExample request URL:\n

    http://adapt2.sis.pitt.edu/cbum/umc?app=19&usr=joe&grp=class12&dom=sql_concepts&con=Table,MultipleTableSelection,WhereClause&val=-1,0.5,-1&sid=1&svc=5

\n\nThere is no api support for this protocol yet.\n\n= Protocol for
requesting user progress =\nUser progress is measured with respect to
completeness of exploration of learning objects. Progress is described
in terms of: 1) now many steps of the learning objet were explored, 2)
how many attempts user has made while exploring. Information about user
progress can be requested in XML format and in the format of Java
serialized objects.\n\n== Getting user progress report in an XML format
==\nThis protocol allows requesting user progress with a set of learning
objects in an XML format. The set of learning objects are constrained by
specifying application that serves learning objects and possibly a
scope - group of learning objects within that application. In addition
to individual user progress an average user progress can be requested
(for example to implement social navigation).\n\n**Request URL
Format:**\n

    http://<report_manager>?typ=<information_type>&dir=<upload_request>&frm=<format>&app=<application_id>&usr=<user>&gpr=<group>&scp=<scope>

\n\n,where:\n\n\* **typ** – **mandatory**, type of report, here should
always be **act** (user action, learning object)\n\* **dir** –
**mandatory**, direction of communication with report manager, should
always be **out** (report manager only sending information nothing is
taken in) for GET requests\n\* **frm** – **mandatory**, format, e.g. for
xml report should be **xml**\n\* **app** – **mandatory**, application
id, for a list of valid application ids refer to section
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>\n\*
**usr** – **mandatory**, user who's progress report is requested\n\*
**grp** – **mandatory**, user group, if present an average group report
will be added to individual user report\n\n**Example request URL:**\n

    http://adapt2.sis.pitt.edu/cbum/ReportManager?typ=act&dir=out&frm=xml&app=2&usr=myudelson&grp=200721

\n\n**XML Example:**\nBelow is an example of the returned XML, where
learning object 2dimensional_array1 with 3 steps: 1, 2, and 3 that have
been performed 25, 12, and 3 times respectively and the user progress
for those steps is .3, .2, and .1 respectively.\nIn addition CUMULATE
lets you know several other [things:\n](things:\n)\* the number of users
in the group via **member_count** attribute of **group** tag (here
30)\n\* the date-time of the most recent user transaction registered by
CUMULATE for this user via **user-hash** tag\n\* the date-time of the
most recent user transaction registered by CUMULATE for this user and
the application specified via **user-app-hash** tag\n

    \n<?xml version='1.0' encoding='UTF-8'?>\n<report>\n   <user>myudelson</user>\n   <user-app-hash>2007-11-07 16:30:54.497</user-app-hash>\n   <user-hash>2007-11-28 12:03:45.250</user-hash>\n   <group member_count="30">200721</group>\n   <activities>\n      <activity>\n         <name>2dimensional_array1</name>\n         <subactivity>\n            <name>0</name>\n            <individual>\n               <count>25</count>\n               <progress>0.3</progress>\n            </individual>\n         </subactivity>\n         <subactivity>\n            <name>1</name>\n            <individual>\n               <count>12</count>\n               <progress>0.2</progress>\n            </individual>\n         </subactivity>\n         <subactivity>\n            <name>2</name>\n            <individual>\n               <count>3</count>\n               <progress>0.1</progress>\n            </individual>\n         </subactivity>\n      </activity>\n      ...\n   </activities>\n</report>\n

\n\n<a href="#top" class="wikilink" title="^top">^top</a>\n\n== Getting
user progress report in the format of Java serialized objects ==\nThis
protocol works in a similar fashion as the one in the previous section
<a href="#Getting_user_progress_report_in_an_XML_format"
class="wikilink" title=" Getting user progress report in an XML format">
Getting user progress report in an XML format</a>. In addition it allows
to submit requests for specific set of learning objects within
application-scope hierarchy. There are two scenarios for requesting the
report:\n\n# Requesting user progress with learning objects of a whole
application or application scope, or\n# Requesting user progress with a
***limited subset*** of learning objects of the application or
application scope.\n\nIn both scenarios receiving of the report is
identical. In the second case a list of the requested learning objects'
character IDs should be uploaded to the Report Manager
web-service.\n\nIn order to be able to parse the response of the Report
Manager you need to include
**edu.pitt.sis.paws.cbum.structures.report.ProgressEstimatorReport**
class from
[paws-cbum-reportapi.jar](http://www.sis.pitt.edu/~paws/assets/paws-cbum-reportapi.jar)
file.\n\n**Request URL Format:**\n

    http://<report_manager>?typ=<information_type>&dir=<upload_request>&frm=<format>&app=<application_id>&usr=<user>&gpr=<group>&scp=<scope>

\n,where:\n\* **typ** – **mandatory**, type of report, here should
always be **act** (user progress with a learning object)\n\* **dir** –
**mandatory**, upload request flag, should be either **out** (if
scenario 1 is used) or in (if scenario 2 is user)\n\* **frm** –
**mandatory**, format, for Java serialized objects report should be
**dat**\n\* **app** – **mandatory**, application id, for a list of valid
application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>\n\*
**usr** – **mandatory**, user whose progress is requested\n\* **grp** –
**mandatory**, user group, if present an average group report will be
added to individual user report\n\n**Example request URL:**\n

    http://adapt2.sis.pitt.edu/cbum/ReportManager?typ=act&dir=out&frm=dat&app=2&usr=myudelson&grp=200721

\nThis request will return result equivalent to the XML returned by the
example request of the previous section.\n\n**Java example 1**: Using
scenario 1 to request user progress with all learning objects of
application with id 12\n

    \nimport java.net.*;\nimport java.util.*;\nimport java.edu.pitt.sis.paws.cbum.structures.report.ProgressEstimatorReport;\n...\nString report_manager_url = "http://adapt2.sis.pitt.edu/cbum/ReportManager";\nString user_login = "myudelson";\nString group = "200721";\nString application_id= "12";\nArrayList um_response = null; // report will be saved in this variable\ntry\n{\n   // requesting report - dir=out\n   URL url = new URL(report_manager_url + "?typ=act&dir=out&frm=dat&app=" +\n      application_id + "&usr=" + user_login + "&grp=" + group);\n   URLConnection conn = url.openConnection();\n   ObjectInputStream recv_stream = new ObjectInputStream(conn.getInputStream());\n   try\n   {\n      um_response = (ArrayList)recv_stream.readObject();\n   }\n   catch(Exception e) { e.printStackTrace(System.err); }\n   finally { recv_stream.close(); }\n   \n   // parsing the report\n   double user_progress = 0.0;\n   for(int i=0; i<um_response.size(); i++)\n   {\n      user_progress = ((ProgressEstimatorReport)um_response.get(i)).progress;\n      // save user_progress elsewhere\n      ...\n   }\n   ...\n}\ncatch(Exception e) { e.printStackTrace(System.out); }\n

\n\n**Java example 2**: Using scenario 2 to request user progress with 2
learning objects lo_one and lo_two of application with id 12\n

    \nimport java.net.*;\nimport java.util.*;\nimport java.edu.pitt.sis.paws.cbum.structures.report.ProgressEstimatorReport;\n...\nString report_manager_url = "http://adapt2.sis.pitt.edu/cbum/ReportManager";\nString user_login = "myudelson";\nString group = "200721";\nString application_id= "12";\nArrayList um_response = null; // report will be saved in this variable\nArrayList request = null; // request will be formed in this variable\ntry\n{\n   // create the request\n   request = new ArrayList();\n   request.add(new ProgressEstimatorReport("lo_one", 0, 0));;\n   request.add(new ProgressEstimatorReport("lo_two", 0, 0));;\n   \n   // upload the request - dir=in\n   URL url = new URL(report_manager_url + "?typ=act&dir=in&frm=dat&app=" +\n      application_id + "&usr=" + user_login + "&grp=" + group);\n   URLConnection conn = url.openConnection();\n   conn.setUseCaches(false);\n   conn.setDefaultUseCaches(false);\n   conn.setDoOutput(true);\n   conn.setDoInput(true);\n   conn.setRequestProperty("Content-Type","java-internal/" + req.getClass().getName());\n   ObjectOutputStream send_strean = new ObjectOutputStream(conn.getOutputStream());\n   send_strean.writeObject(req);\n   send_strean.flush();\n   send_strean.close();\n   \n   // receiving report\n   ObjectInputStream recv_stream = new ObjectInputStream(conn.getInputStream());\n   try\n   {\n      um_response = (ArrayList)recv_stream.readObject();\n   }\n   catch(Exception e) { e.printStackTrace(System.err); }\n   finally { recv_stream.close(); }\n   \n   // parsing the report\n   double user_progress = 0.0;\n   for(int i=0; i<um_response.size(); i++}\n   {\n      user_progress = ((ProgressEstimatorReport)um_response.get(i)).progress;\n      // save user_progress elsewhere\n   }\n   ...\n}\ncatch(Exception e) { e.printStackTrace(System.out); }\n

\n\n<a href="#top" class="wikilink" title="^top">^top</a>\n\n\n\n=
Protocol for requesting user knowledge of concepts =\nUser knowledge of
concepts is measured as probability of knowing a portion of learning
domain described by certain concepts. Information about user progress
can be requested in XML format and in the format of Java serialized
objects.\n\n== Getting user knowledge of concepts report in an XML
format ==\nThis protocol allows various applications to obtain knowledge
with respect to multiple Bloom levels for a set of
concepts.\n\n**Request URL Format:**\n

    \nhttp://<report_manager>?typ=<information_type>&dir=<upload_request>&frm=<format>&app=<application_id>&usr=<user>&gpr=<group>&dom=<domain>&lev=<Bloom_level(s)>\n

\n,where:\n\* **typ** – **mandatory**, type of report, here should
always be **con** (concept progress)\n\* **dir** – **mandatory**, upload
request flag, should always be **out** (no upload) for GET requests\n\*
**frm** – **mandatory**, format, format, for XML report should be
**xml**\n\* **app** – **mandatory**, application id, for a list of valid
application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>\n\*
**usr** – **mandatory**, user whose progress is requested\n\* **grp** –
**mandatory**, user group\n\* **lev** – *optional*, Bloom levels to be
reported, allowed values: **knowledge**, **comprehension**,
**application**, **synthesis** or a delimited list of them, if
unspecified – all levels are reported\n\* **dom** – **mandatory**,
concepts' domain (ontology)\n\n**Example request URL:**\n

    \nhttp://adapt2.sis.pitt.edu/cbum/ReportManager?typ=con&dir=out&frm=xml&app=2&usr=myudelson&grp=200721&lev=application&dom=c_programming\n

\n\nBelow is a n example of the returned XML.\nIn addition CUMULATE lets
you know several other [things:\n](things:\n)\* the date-time of the
most recent user transaction registered by CUMULATE for this user via
**user-hash** tag\n\* the date-time of the most recent user transaction
registered by CUMULATE for this user and the application specified via
**user-app-hash** tag\n\n

    \n<?xml version='1.0' encoding='UTF-8' ?>\n<report>\n   <user>myudelson</user>\n   <user-app-hash>2009-06-11 20:20:05.545</user-app-hash>\n   <user-hash>2009-06-11 20:20:05.545</user-hash>\n   <concepts>\n      ...\n      <concept>\n         <name>add</name>\n         <cog_levels>\n            <cog_level>\n               <name>application</name>\n               <value>0.6266574470377776</value>\n            </cog_level>\n         </cog_levels>\n      </concept>\n      <concept>\n         <name>sub</name>\n         <cog_levels>\n            <cog_level>\n               <name>application</name>\n               <value>0.36388277385950873</value>\n            </cog_level>\n         </cog_levels>\n      </concept>\n      ...\n      </concepts>\n</report>\n

\n\n<a href="#top" class="wikilink" title="^top">^top</a>\n\n== Getting
user knowledge of concepts report in the format of Java serialized
objects ==\nThe protocol is identical to one in the previous section
6.1. In addition it allows to submit requests for specific concepts
rather than the whole realm of concepts or a domain of concepts. The
report is returned in the form of Java serialized objects.\n\n**Request
URL Format:**\n

    \nhttp://<report_manager>?typ=<information_type>&dir=<upload_request>&frm=<format>&app=<application_id>&usr=<user>&gpr=<group>&dom=<scope>\n

\n,where:\n\* **typ** – **mandatory**, type of report, here should
always be con (concept)\n\* **dir** – **mandatory**, upload request
flag, can be in or out, depending on whether you want to upload the ids
of the concepts that you'd like to receive the report about\n\* **frm**
– **mandatory**, format, for Java serialized objects report should be
dat\n\* **app** – **mandatory**, application id, for a list of valid
application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>\n\*
**usr** – **mandatory**, user whose progress is requested\n\* **grp** –
**mandatory**, user group\n\* **dom** – **mandatory**, concepts' domain
(ontology), if not specified the whole realm of concepts are
reported\n\n**Example request URL:**\n

    \nhttp://adapt2.sis.pitt.edu/cbum/ReportManager?typ=con&dir=in&frm=dat&app=2&usr=myudelson&grp=200721&dom=c_programming\n

\n\nThis request will return result equivalent to the XML returned by
the example request of the previous section.\n

    \nJava example 1: Requesting concepts of a specific domain\nimport java.net.*;\nimport java.util.*;\n...\nString report_manager_url = "http://adapt2.sis.pitt.edu/cbum/ReportManager";\nString user_login = "myudelson";\nString group = "200721";\nString concept_cognitive_levels = "application";\nString domain = "c_programming";\nString application_id= "3";\nArrayList um_response = null; // user model report withh be saved in this variable\ntry\n{\n   URL url = new URL(report_manager_url + "?typ=con&dir=out&frm=dat&lev=" +\n      concept_cognitive_levels +"&app=" + application_id +\n      "&usr=" + user_login + "&grp=" + group + "&dom=" + domain);\n   URLConnection conn = url.openConnection();\n   ObjectInputStream recv_stream = new ObjectInputStream(conn.getInputStream());\n   try\n   {\n      um_response = (ArrayList)recv_stream.readObject();\n   }\n   catch(Exception e) { e.printStackTrace(System.err); }\n   finally { recv_stream.close(); }\n}\ncatch(Exception e) { e.printStackTrace(System.out); }\n

\n\n<a href="#top" class="wikilink" title="^top">^top</a>\n\n= Protocol
for Requesting Concept-Activity Indexing =\nFor each of the activities
(aka learning objects) CUMULATE can store a list of knowledge concepts
from a particular domain. The following protocols expose this
indexing.\n\n== Getting Concepts for an Activity (List of Activities)
==\nThis protocol lists concepts connected to a given activity (list of
activities).\n\n**Request URL Format:**\n

    \nhttp://<report_manager>?typ=<information_type>&frm=<format>&app=<application_id>&act=<activity>&dom=<domain>\n

\n,where:\n\* **typ** – **mandatory**, type of report, here should
always be **act2con** (activity-to-concept mapping)\n\* **dir** –
**mandatory**, upload request flag, should be **in**\n\* **frm** –
**mandatory**, format, supported formats are XML and RDF - **xml** and
**rdf** values respectively\n\* **app** – **mandatory**, application id
mapping of activities of which are requested, for a list of valid
application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>\n\*
**act** – **mandatory**, activity, or a comma-delimited list of
activities\n\* **dom** – **mandatory**, domain of concepts \n\n**Example
request URL (XML format):**\n

    \nhttp://adapt2.sis.pitt.edu/cbum/ReportManager?typ=act2con&dir=in&frm=xml&app=3&act=helloworld.c,printing.c&dom=c_programming\n

\n\nAnd the returned XML result:\n

    \n<?xml version='1.0' encoding='UTF-8'?>\n<report>\n\t<mappings>\n\t\t<mapping>\n\t\t\t<activity>helloworld.c</activity>\n\t\t\t<concept>printf</concept>\n\t\t\t<concept>main_function</concept>\n\t\t\t<concept>include</concept>\n\t\t\t<concept>void</concept>\n\t\t</mapping>\n\t\t<mapping>\n\t\t\t<activity>printing.c</activity>\n\t\t\t<concept>printf</concept>\n\t\t\t<concept>main_function</concept>\n\t\t\t<concept>include</concept>\n\t\t\t<concept>void</concept>\n\t\t</mapping>\n\t</mappings>\n</report>\n

\n\n**Example request URL (RDF format):**\n

    \nhttp://adapt2.sis.pitt.edu/cbum/ReportManager?typ=act2con&dir=in&frm=rdf&app=3&act=helloworld.c,printing.c&dom=c_programming\n

\n\nAnd the returned RDF result:\n

    \n<?xml version='1.0' encoding='UTF-8'?>\n<rdf:RDF\n\txmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'\n\txmlns:dc='http://purl.org/dc/elements/1.1/'>\n\n\t<rdf:Description rdf:about='http://adapt2.sis.pitt.edu/webex/webex.rdf#helloworld.c'>\n\t\t<dc:subject>printf</dc:subject>\n\t\t<dc:subject>main_function</dc:subject>\n\t\t<dc:subject>include</dc:subject>\n\t\t<dc:subject>void</dc:subject>\n\t</rdf:Description>\n\t<rdf:Description rdf:about='http://adapt2.sis.pitt.edu/webex/webex.rdf#printing.c'>\n\t\t<dc:subject>printf</dc:subject>\n\t\t<dc:subject>main_function</dc:subject>\n\t\t<dc:subject>include</dc:subject>\n\t\t<dc:subject>void</dc:subject>\n\t</rdf:Description>\n</rdf:RDF>\n

\n\n<a href="#top" class="wikilink" title="^top">^top</a>\n\n== Getting
Activities for a Concept (List of Concepts) ==\nThis protocol lists
activities connected to a given concepts (list of
concepts).\n\n**Request URL Format:**\n

    \nhttp://<report_manager>?typ=<information_type>&frm=<format>&app=<application_id>&con=<concept>&dom=<domain>\n

\n,where:\n\* **typ** – **mandatory**, type of report, here should
always be **con2act** (concept-to-activity mapping)\n\* **dir** –
**mandatory**, upload request flag, should be **in**\n\* **frm** –
**mandatory**, format, supported formats are XML and RDF - **xml** and
**rdf** values respectively (RDF is not supported yet)\n\* **app** –
**mandatory**, application id activities of which concepts are mapped
to, for a list of valid application ids refer to
<a href="#Parameter_Naming_Conventions" class="wikilink"
title="Parameter Naming Conventions">Parameter Naming Conventions</a>\n\*
**dom** – **mandatory**, domain of concepts\n\* **con** – **mandatory**,
concept, or a comma-delimited list of concepts\n\n**Example request URL
(XML format)**\n

    \nhttp://adapt2.sis.pitt.edu/cbum/ReportManager?typ=con2act&dir=in&frm=xml&app=3&con=printf,if_else&dom=c_programming\n

\n\nAnd the returned XML result:\n

    \n<?xml version='1.0' encoding='UTF-8'?>\n<report>\n\t<mappings>\n\t\t<mapping>\n\t\t\t<concept>printf</concept>\n\t\t\t<activity>abcounting.c</activity>\n\t\t\t<activity>abcounting_case.c</activity>\n\t\t\t<activity>accumulator.c</activity>\n\t\t\t...\n\t\t</mapping>\n\t\t<mapping>\n\t\t\t<concept>if_else</concept>\n\t\t\t<activity>abcounting.c</activity>\n\t\t\t<activity>babyweighting.c</activity>\n\t\t\t<activity>battleship.c</activity>\n\t\t\t<activity>betterbattle.c</activity>\n\t\t\t...\n\t\t</mapping>\n\t</mappings>\n</report>\n

\n\n<a href="#top" class="wikilink" title="^top">^top</a>
