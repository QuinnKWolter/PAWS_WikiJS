---
title: "Knowledge Tree RDF Binding"
source_namespace: "ns_0"
source_filename: "Knowledge_Tree_RDF_Binding.md"
---



This page describes
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
binding of <a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a> data model as part of
<a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a> initiative.

==ER
Model and RDF Bindings==

===Quick Example===



<?xml version="1.0" encoding="utf-8"?>
<rdf:RDF
\txmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
\txmlns="http://purl.org/rss/1.0/"
>
\t<channel rdf:about="http://adapt2.sis.pitt.edu/kt/rest/ktree3509">
\t\t<title rdf:parseType='Literal'>KnowledgeTree:: IS 1022/2710 Database Management</title>
\t\t<link>http://adapt2.sis.pitt.edu/kt/content/Show?id=3509</link>
\t\t<items>
\t\t\t<rdf:Seq>
\t\t\t\t<rdf:li rdf:resource="http://adapt2.sis.pitt.edu/kt/rest/ktree4014"/>
\t\t\t\t<rdf:li rdf:resource="http://adapt2.sis.pitt.edu/kt/rest/ktree3521"/>
\t\t\t\t<rdf:li rdf:resource="http://adapt2.sis.pitt.edu/kt/rest/ktree3522"/>
\t\t\t\t
\t\t\t</rdf:Seq>
\t\t</items>
\t</channel>
\t<item rdf:about="http://adapt2.sis.pitt.edu/kt/rest/ktree4014">
\t\t<rdf:value rdf:datatype='http://www.w3.org/2001/XMLSchema#double'>1.0</rdf:value>
\t\t<title rdf:parseType='Literal'>QuizGuide - Adaptive Quizzes</title>
\t\t<link>http://adapt2.sis.pitt.edu/kt/content/Show?id=4014</link>
\t</item>
\t<item rdf:about="http://adapt2.sis.pitt.edu/kt/rest/ktree3521">
\t\t<rdf:value rdf:datatype='http://www.w3.org/2001/XMLSchema#double'>1.0</rdf:value>
\t\t<title rdf:parseType='Literal'>Table Creation</title>
\t\t<link>http://adapt2.sis.pitt.edu/kt/content/Show?id=3521</link>
\t\t<rdf:type rdf:resource='http://purl.org/dc/dcmitype/Collection'/>
\t</item>
\t<item rdf:about="http://adapt2.sis.pitt.edu/kt/rest/ktree3522">
\t\t<rdf:value rdf:datatype='http://www.w3.org/2001/XMLSchema#double'>1.0</rdf:value>
\t\t<title rdf:parseType='Literal'>Table Deletion and Alteration</title>
\t\t<link>http://adapt2.sis.pitt.edu/kt/content/Show?id=3522</link>
\t\t<rdf:type rdf:resource='http://purl.org/dc/dcmitype/Collection'/>
\t</item>
\t
</rdf:RDF>





* **<span id='Node'>Node</span>** -
<a href="rss#channel" class="wikilink"
title="rss:channel">rss:channel</a> or
[rss:item](/ns_0/rss#item)
depending on context, in addition
<a href="dcmitypes#Collection" class="wikilink"
title="dcmitypes:Collection">dcmitypes:Collection</a> when a folder
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id='Node.hasChildNode'>Node.hasChildNode</span> -
[rss:items](/ns_0/rss#items)
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id='Node.hasParentNode'>Node.hasParentNode</span>
**
<span id='Node.{ordered list of subordinates}'>Node.{ordered list of
subordinates}</span> - via
[rdf:Seq](/ns_0/rdf#seq)
subordinate of the
[rss:items](/ns_0/rss#items)
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id='Node.{weight of subordinate}'>Node.{weight of
subordinates}</span>
**
<span id='Node.hasCreator'>Node.hasCreator</span> -
[dc:creator](/ns_0/dc#creator)
**
<span id='Node.creationDate'>Node.creationDate</span> -
<a href="dcterms#created" class="wikilink"
title="dc:created">dc:created</a>
**
<span id='Node.modificationDate'>Node.modificationDate</span> -
<a href="dcterms#modified" class="wikilink"
title="dc:modified">dc:modified</a>
**
<span id='Node.nodeTitle'>Node.nodeTitle</span> -
<a href="rss#item.title" class="wikilink"
title="rss:item.title">rss:item.title</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id='Node.nodeDescription'>Node.nodeDescription</span> -
<a href="rss#item.description" class="wikilink"
title="rss:item.description">rss:item.description</a>

**
<span id='Node.hasNodeType'>Node.hasNodeType</span> - refine
dcmitypes?
** <span id='Node.hasURL'>Node.hasURL</span> -
<a href="rss#item.link" class="wikilink"
title="rss:item.link">rss:item.link</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id='Node.hasURI'>Node.hasURI</span> - implicitly via
[rdf:about](/ns_0/rdf#about)→[rss:item](/ns_0/rss#item)
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id='Node.hasIcon'>Node.hasIcon</span>
**
<span id='Node.isFolder'>Node.isFolder</span> -
<a href="rss#channel" class="wikilink"
title="rss:channel">rss:channel</a> and
<a href="dcmitypes#Collection" class="wikilink"
title="dcmitypes:Collection">dcmitypes:Collection</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>
*
**<span id='User'>User</span>** - <a href="foaf#Person" class="wikilink"
title="foaf:Person">foaf:Person</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id='User.isMemberOf'>User.isMemberOf</span> - applicable to User
only - as inverse of <a href="foaf#hasMember" class="wikilink"
title="foaf:hasMember">foaf:hasMember</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id='User.hasURI'>User.hasURI</span> -
[rdf:about](/ns_0/rdf#about)
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id='User.hasLogin'>User.hasLogin</span> -
<a href="foaf#holdsAccount" class="wikilink"
title="foaf:holdsAccount">foaf:holdsAccount</a>→**<a href="foaf#OnlineAccount" class="wikilink"
title="foaf:OnlineAccount">foaf:OnlineAccount</a>**→
<a href="foaf#accountName" class="wikilink"
title="foaf:accountName">foaf:accountName</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id='User.hasName'>User.hasName</span> -
[foaf:name](/ns_0/foaf#name)
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id='User.hasPass'>User.hasPass</span> - not to make available via
RDF serialization
<span style='color:white;background-color:red;padding:2px;'>Not</span>
**
<span id='User.isGroup'>User.isGroup</span> - via
[foaf:Group](/ns_0/foaf#group)
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id='User.hasEmail'>User.hasEmail</span> - SHA1-encoded -
<a href="foaf#mbox_sha1sum" class="wikilink"
title="foaf:mbox_sha1sum">foaf:mbox_sha1sum</a>
**
<span id='User.hasOrganization'>User.hasOrganization</span>
**
<span id='User.hasCity'>User.hasCity</span>
**
<span id='User.hasCountry'>User.hasCountry</span>
**
<span id='User.hasNote'>User.hasNote</span>
**
<span id='User.hasMember'>User.hasMember</span> - applicable to Group
users only - <a href="foaf#hasMember" class="wikilink"
title="foaf:hasMember">foaf:hasMember</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>
*
**<span id='Group'>Group</span>** - group is a special kind of User
entity -
[foaf:Group](/ns_0/foaf#group)
<span style='color:white;background-color:green;padding:2px;'>Done</span>
*
**<span id='Right'>Right</span>**
**
<span id='hasTargetAgent'>hasTargetAgent</span>
**
<span id='hasRightType'>hasRightType</span>
**
<span id='hasParentNodeType'>hasParentNodeType</span>
**
<span id='hasChildNodeType'>hasChildNodeType</span>
**
<span id='hasSubtreeNode'>hasSubtreeNode</span>
**
<span id='hasQuantity'>hasQuantity</span>
**
<span id='hasDescription'>hasDescription</span>
**
<span id='hasOwnerFlag'>hasOwnerFlag</span>

*
**<span id='ItemType'>ItemType</span>** - arguably doesn't need RDF
serialization
** <span id='itemtypeTitle'>itemtypeTitle</span>
**
<span id='itemtypeDescription'>itemtypeDescription</span>
**
<span id='itemtypeType'>itemtypeType</span>
**
<span id='itemtypeURL'>itemtypeURL</span>
**
<span id='itemtypeIcon'>itemtypeIcon</span>
**
<span id='itemtypeClassName'>itemtypeClassName</span>
**
<span id='itemtypeURLSufix'>itemtypeURLSufix</span>
*
**<span id='RightType'>RightType</span>** - arguably doesn't need RDF
serialization
**
<span id='righttypeTitle'>righttypeTitle</span>
**
<span id='righttypeDescription'>righttypeDescription</span>


#### See also

* <a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a>
*
<a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a>
