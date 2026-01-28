# About Ensemble

\n<a href="Ensemble" class="wikilink" title="Ensemble">Ensemble</a> is a
new NSF NSDL Pathways project working to establish a national,
distributed digital library for computing education. Our project is
building a distributed portal providing access to a broad range of
existing educational resources for computing while preserving the
collections and their associated curation processes. We want to
encourage contribution, use, reuse, review and evaluation of educational
materials at multiple levels of granularity and we seek to support the
full range of computing education communities including computer
science, computer engineering, software engineering, information
science, information systems and information technology as well as other
areas often called “computing + X” or “X informatics.”\n\n= Overview
=\n![**100**\|Figure 1. Group-based social
navigation](Portal-group-social-navigation.png "100|Figure 1. Group-based social navigation")\n![**100**\|Figure
2. Group-based and individual social
navigation](Portal-group-n-individual-social-navigation.png "100|Figure 2. Group-based and individual social navigation")\nThe
main goal of enhancing Ensemble portal (http://www.computingportal.org)
with adaptation is to provide an extra value to the rich collection of
resources that the portal is currently hosting. Out of a large set of
possible adaptation techniques we selected the one that captures the
social traits of portal users. Namely, visualizes users' browsing
behaviors.\n\nIn Figure 1 there is a screenshot of an existing portal
page with adaptive navigation cues added. Here green bullets of various
shades denote the intensity of the users' click traffic: the darker the
shade - the more clicks visits the page has. Here users are not
distinguished from each other. Instead, a page-viewing behavior of a
community of all portal users is visualized. Figure 2 is a more
elaborate example where each individual user is contrasted to the rest
of the community. The bullet background represents the whole user
community, an the foreground person icon denotes an individual
user.\n\nFor the adaptation to work, Ensemble portal has to "cooperate"
with the adaptation providers. There are two components that are
responsible for adaptation.\n# User modeling server
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>, that
collects user page-viewing behavior. Portal should be able to send
page-view events containing the viewed page URL and potentially
additional information about the user.\n# Adaptation server
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a>, that,
upon request, renders a visualization of aggregated user
viewing-behaviors collected by the user modeling server. Portal should
be able to query
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a> to obtain
navigation icons (just like those in figure 1 and 2) for links on a
particular portal page (all or a subset). It should also to be able to
parse the
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a>'s
response and paste these icons on the rendered page.\n\n= Implementation
=\n\n== Reporting users's page-views ==\nThis par is absolutely
necessary. Adaptation requires a special kind of user-data processing
and cannot be easily implemented as a plugin for Drupal (the basis for
Ensemble portal). Portal has to send an HTTP GET request to the
<a href="CUMULATE" class="wikilink"
title="user modeling server&#39;s">user modeling server's</a> listening
url that contains:\n\* URL of the page being viewed\n\* Some form of
user identity (e.g. client IP address or portal login). This information
is optional but desirable to be able to support a more advanced
adaptation such as the one in Figure 2.\n\n== Requesting adaptation
("easy", abandoned) ==\n![**100**\|Figure 3.
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a> embedlet
rendered in a
browser](Ensemble-embedlet-browser.png "100|Figure 3. PERSEUS embedlet rendered in a browser")\nAdaptation
can be provided in a fairly painless manner by inserting **embed** HTML
tags, just like those [YouTube](http://www.youtube.com) offers.
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a>'s
embedlet is, in some way, an iframe and
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a> assumes
full responsibility to render links' presentation (see Figure 3 for an
example of embedlet's rendering in a browser).\n\nThe use of these
**embedlets** requires for the list of links adaptation is provided for
to be cached in advance, so that the enumeration of links to be
adaptively presented can be done in a concise manner and the invoked
embedlet URL does not exceed 255 characters.\n\nEmbedlet could work in
both group-based mode providing adaptation similar to the one shown in
Figure 1, or group-and-individual mode, similar to the one shown in
Figure 2.\n\n== Requesting adaptation ("hard", implemented) ==\nHere the
Content Management System (CMS) has to be more engaged but the solution
is more flexible.\n\nThe two requirements for the CMS that is has to be
able to send a query to
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a> with a
list of links to adapt and to be able to parse the response. Concrete
format of the request/response is not important, since a special version
of the adaptation services would be built for
<a href="Ensemble" class="wikilink" title="Ensemble">Ensemble</a>.\n\nThe
following is a working draft for invoking
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a>
adaptation (HTTP POST request is a must):\n\*
**<http://adapt2.sis.pitt.edu/pservice/service/ensemble-sn/invoke/ensemble-sn>**
is a base URL of PERSEUS social navigation support service for
<a href="Ensemble" class="wikilink" title="Ensemble">Ensemble</a>\n\*
HTTP POST should be used to invoke, HTTP GET to access a 'manual' mode
for testing\n\* **user_id** - user id login of the logged-in portal
user; currently meta user **meta_ensemble** should be used\n\*
**group_id** group id, id of the portal community; currently meta
community **meta_group** should be used\n\* **uri** - list of links to
adapt; these are the links sent to CUMULATE with reports of user clicks;
the list items should be separated by CR (carriage return)\n\*
**vis_id** - an id of a visualizer that formats the output by selecting
appropriate annotations for the aggregated numerical values; at this
point should be equal to **ensemble-sn-shadeviz**; alternatively
**/vis/ensemble-sn-shadeviz/** could be added at the end of the base URL
to achieve the same result, so the URL would be
**<http://adapt2.sis.pitt.edu/pservice/service/ensemble-sn/invoke/ensemble-sn/vis/ensemble-sn-shadeviz>**\n\*
returned response is a list of annotations - HTML snippets (e.g. img tag
and maybe something extra) to be placed in front of the link; the order
of annotations is the same as in the request.\n\n== Relevant Links
==\n\* [Ensemble Computing Portal](http://www.computingportal.org/)\n\*
<a href="CUMULATE_protocol" class="wikilink"
title="Protocol">Protocol</a> for exchanging data with
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>'s user
model, in particular - a
<a href="CUMULATE_protocol#Protocol_for_reporting_user_activity"
class="wikilink" title="section">section</a> on how to send clicks to
the user model\n\* [Module for sending user clicks to CUMULATE settings
page](http://www.computingportal.org/admin/settings/navigation_cues)
(authentication necessary)\n\n= Progress Blog =\n\* 13:49, 9 July 2010
(EDT) : Drupal Rules module identified as a way to redirect user clicks
to <a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>
UMS\n\* 18:27, 15 July 2010 (EDT) :
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>
configured for accepting test input of Ensemble portal user navigation
reports via
<a href="CUMULATE_protocol#Protocol_for_reporting_user_activity"
class="wikilink" title="this">this</a> protocol. Preliminary by-hand
testing is successful.\n\* 18:51, 15 July 2010 (EDT) : Preliminary test
of Ensemble portal user navigation reports to
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>
successful\n\* 10:44, 27 July 2010 (EDT) : Drupal module for sending
user clicks to
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a> is
confirmed to work properly on [U. of Oregon test
portal](http://owaine.dlib.vt.edu/sites/)\n\* 12:05, 29 July 2010 (EDT)
Meeting with [Dr. Delcambre](http://web.cecs.pdx.edu/~lmd/) and
Elizabeth on moving forward with building the adaptation into the
portal. Decided to look further onto Drupal themes and modules
(Elizabeth) for ways to paste the calls for adaptations and to create a
specialized version of
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a> service
for the Portal
(<a href="User:Myudelson" class="wikilink" title="Michael">Michael</a>).\n\*
16:43, 31 August 2010 (EDT) : Stub
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a> social
navigation service for
<a href="Ensemble" class="wikilink" title="Ensemble">Ensemble</a> is
created and deployed
(<a href="User:Myudelson" class="wikilink" title="Michael">Michael</a>).\n\*
07:06, 3 September 2010 (EDT) : first vanilla working
[example](http://ensemble.cs.pdx.edu/vanilla) of
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a>
adaptation on the portal is deployed by Elizabeth\n\* 14:13, 23
September 2010 (EDT) : Group-based social adaptation is now fully
operational. It is currently deployed on U. of Portland test server.
Check [vanilla example](http://ensemble.cs.pdx.edu/vanilla).\n\* 11:14,
28 September 2010 (EDT) : Group-based social adaptation
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a>
adaptation is fully operational on the main server, refer to [this
example](http://owaine.dlib.vt.edu/sites/cs1).\n\n= Contacts =\n\*
<a href="User:Myudelson" class="wikilink" title=" Michael V. Yudelson">
Michael V. Yudelson</a>\n\* Elizabeth Heinlein
