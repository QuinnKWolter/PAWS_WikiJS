---
title: "Content Invocation protocols"
source_namespace: "ns_0"
source_filename: "Content_Invocation_protocols.md"
---

This page describes the content invocation protocols supported by
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>


#### Why Content Invocation?

A content invocation protocol
allows two online learning systems to work together in supporting
learners. With this protocol, a **host system**, such as a learning
portal, a learning management system, or a personalized learning
interface) can activate an independent **client system** while also
passing a range of important parameters to it, most importantly,
information about the user and group who will work with the client
system, and the user target. The target might indicate a specific
activity that the client system will need to launch for the user, while
the information about the user and group enables the client system to
customize its interaction with the user. The information about the user
and the target is also important to log the information about the user
interaction with the tool.

When
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
was originally developed in 2002, it implemented its own content
invocation protocol, since no other protocols supported personalized
invocation of external learning content at that time. As other protocols
gradually evolved, an increasing volume of interactive learning objects
that implemented these protocols was developed. To leverage this
content,
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
components now support other content invocation protocols.

==
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
protocol for user authentication and activity invocation
==

<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
content invocation protocol is the "native" protocol of
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
infrastructure.
This protocol is adopted by all
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
tools developed by our teams and by many content servers developers by
our collaborators.
It regulates how user and resource identities is
transferred from application to application via the following HTTP
parameters (see
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
<a href="CUMULATE_protocol#Parameter_Naming_Conventions"
class="wikilink" title="Parameter Naming Conventions">Parameter Naming
Conventions</a>)

* **usr** - user identifier, usually login
(mandatory)
* **grp** - group identifier (mandatory), just like a user
identifier, but for a group of users (class, research team)
*
**sid** - session identifier (optional), usually 5 character string each
application makes a choice whether and how to come up with this
parameter (e.g. truncate [\| Apache
Tomcat](http://en.wikipedia.org/wiki/Apache_Tomcat) session id to last 5
characters)
* **act** - id of the resource (mandatory), each
application maintains its own vocabulary of resource ids
* **sub** -
if a resource is a collection of multiple resources/steps, then a
sub-resource id is supplied to call a specific sub-resource or step
(optional)
* **svc** – service parameter – any character string that
can be used to store system state, should not contain ? (question mark),
& (ampersand), : (colon), and / (backward slash); however all those
symbols can be encoded using Java URLEncoder class that maps them to
%XX; service parameter (optional)
* **cid** - course id that defines
the course in which this content is being requested (optional). This
parameter is different than grp because there could be multiple groups
within a single course.


<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
content invocation protocol is "stackable". It could be used by a
learning portal to call a specific learning object for the user to work
with, but can be also used to call a specific personalized service or
shell to assist the user. By receiving information about the user, the
service could call a specific learning content for this user, passing
down the same parameters.

###### Example invocation requests

Below,
there is an example invocation request to access a learning content
using
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
content invocation protocol.

**Request URL Format**:



http|https://<content_url>?app=<application_id> &act=<learning_object> &sub=<learning_object_step> &usr=<user> &gpr=<group> &sid=<session_id> &svc=<service_parameters> & cid=<course_id>




Check above for more details about the URL parameters used in this
request. The content URL defines where this content is being hosted and
could contain content-specific parameters.
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
URL parameters should be appended if there are any content-specific URL
parameters.

For example, to invoke a PCRS coding activity using this
protocol, the following URL can be used:




https://PCRS_URL?act=PCRS&sub=rectangle_perimeter&svc=masterygrids&grp=groupid&usr=userid&sid=sessionid&cid=courseid




Here, PCRS_URL should be replaced with an actual URL obtained from
the content provider.


== Other Standard authentication and content
invocation protocols supported by
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
==

=== LTI protocol ###### More detailed information can be find here: [SPLICE LTI Tutorials](https://cssplice.org/lti/index.html) SPLICE

protocol ===
More information about SPLICE Protocol can be found here:
[SPLICE Protocol
Description](https://docs.google.com/document/d/1X6Vx6Em67t8Vp4Vecnmc-7OblVewJJKDFIJUrvRAvdc/edit?tab=t.0#heading=h.vxcmu24ix9zg)
