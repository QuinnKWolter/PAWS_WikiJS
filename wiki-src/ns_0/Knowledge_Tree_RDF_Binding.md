\n\nThis page describes
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
binding of <a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a> data model as part of
<a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a> initiative. \n\n==ER
Model and RDF Bindings==\n\n===Quick Example===\n

    \n<?xml version="1.0" encoding="utf-8"?>\n<rdf:RDF\n\txmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"\n\txmlns="http://purl.org/rss/1.0/"\n>\n\t<channel rdf:about="http://adapt2.sis.pitt.edu/kt/rest/ktree3509">\n\t\t<title rdf:parseType='Literal'>KnowledgeTree:: IS 1022/2710 Database Management</title>\n\t\t<link>http://adapt2.sis.pitt.edu/kt/content/Show?id=3509</link>\n\t\t<items>\n\t\t\t<rdf:Seq>\n\t\t\t\t<rdf:li rdf:resource="http://adapt2.sis.pitt.edu/kt/rest/ktree4014"/>\n\t\t\t\t<rdf:li rdf:resource="http://adapt2.sis.pitt.edu/kt/rest/ktree3521"/>\n\t\t\t\t<rdf:li rdf:resource="http://adapt2.sis.pitt.edu/kt/rest/ktree3522"/>\n\t\t\t\t\n\t\t\t</rdf:Seq>\n\t\t</items>\n\t</channel>\n\t<item rdf:about="http://adapt2.sis.pitt.edu/kt/rest/ktree4014">\n\t\t<rdf:value rdf:datatype='http://www.w3.org/2001/XMLSchema#double'>1.0</rdf:value>\n\t\t<title rdf:parseType='Literal'>QuizGuide - Adaptive Quizzes</title>\n\t\t<link>http://adapt2.sis.pitt.edu/kt/content/Show?id=4014</link>\n\t</item>\n\t<item rdf:about="http://adapt2.sis.pitt.edu/kt/rest/ktree3521">\n\t\t<rdf:value rdf:datatype='http://www.w3.org/2001/XMLSchema#double'>1.0</rdf:value>\n\t\t<title rdf:parseType='Literal'>Table Creation</title>\n\t\t<link>http://adapt2.sis.pitt.edu/kt/content/Show?id=3521</link>\n\t\t<rdf:type rdf:resource='http://purl.org/dc/dcmitype/Collection'/>\n\t</item>\n\t<item rdf:about="http://adapt2.sis.pitt.edu/kt/rest/ktree3522">\n\t\t<rdf:value rdf:datatype='http://www.w3.org/2001/XMLSchema#double'>1.0</rdf:value>\n\t\t<title rdf:parseType='Literal'>Table Deletion and Alteration</title>\n\t\t<link>http://adapt2.sis.pitt.edu/kt/content/Show?id=3522</link>\n\t\t<rdf:type rdf:resource='http://purl.org/dc/dcmitype/Collection'/>\n\t</item>\n\t\n</rdf:RDF>\n

\n\n \n\* **<span id='Node'>Node</span>** -
<a href="rss#channel" class="wikilink"
title="rss:channel">rss:channel</a> or
<a href="rss#item" class="wikilink" title="rss:item">rss:item</a>
depending on context, in addition
<a href="dcmitypes#Collection" class="wikilink"
title="dcmitypes:Collection">dcmitypes:Collection</a> when a folder
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*\*
<span id='Node.hasChildNode'>Node.hasChildNode</span> -
<a href="rss#items" class="wikilink" title="rss:items">rss:items</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*\*
<span id='Node.hasParentNode'>Node.hasParentNode</span>\n\*\*
<span id='Node.{ordered list of subordinates}'>Node.{ordered list of
subordinates}</span> - via
<a href="rdf#Seq" class="wikilink" title="rdf:Seq">rdf:Seq</a>
subordinate of the
<a href="rss#items" class="wikilink" title="rss:items">rss:items</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*\*
<span id='Node.{weight of subordinate}'>Node.{weight of
subordinates}</span>\n\*\*
<span id='Node.hasCreator'>Node.hasCreator</span> -
<a href="dc#creator" class="wikilink" title="dc:creator">dc:creator</a>\n\*\*
<span id='Node.creationDate'>Node.creationDate</span> -
<a href="dcterms#created" class="wikilink"
title="dc:created">dc:created</a>\n\*\*
<span id='Node.modificationDate'>Node.modificationDate</span> -
<a href="dcterms#modified" class="wikilink"
title="dc:modified">dc:modified</a>\n\*\*
<span id='Node.nodeTitle'>Node.nodeTitle</span> -
<a href="rss#item.title" class="wikilink"
title="rss:item.title">rss:item.title</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*\*
<span id='Node.nodeDescription'>Node.nodeDescription</span> -
<a href="rss#item.description" class="wikilink"
title="rss:item.description">rss:item.description</a>\n \n\*\*
<span id='Node.hasNodeType'>Node.hasNodeType</span> - refine
dcmitypes?\n\*\* <span id='Node.hasURL'>Node.hasURL</span> -
<a href="rss#item.link" class="wikilink"
title="rss:item.link">rss:item.link</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*\*
<span id='Node.hasURI'>Node.hasURI</span> - implicitly via
<a href="rdf#about" class="wikilink" title="rdf:about">rdf:about</a>→<a href="rss#item" class="wikilink" title="rss:item">rss:item</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*\*
<span id='Node.hasIcon'>Node.hasIcon</span>\n\*\*
<span id='Node.isFolder'>Node.isFolder</span> -
<a href="rss#channel" class="wikilink"
title="rss:channel">rss:channel</a> and
<a href="dcmitypes#Collection" class="wikilink"
title="dcmitypes:Collection">dcmitypes:Collection</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*
**<span id='User'>User</span>** - <a href="foaf#Person" class="wikilink"
title="foaf:Person">foaf:Person</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*\*
<span id='User.isMemberOf'>User.isMemberOf</span> - applicable to User
only - as inverse of <a href="foaf#hasMember" class="wikilink"
title="foaf:hasMember">foaf:hasMember</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*\*
<span id='User.hasURI'>User.hasURI</span> -
<a href="rdf#about" class="wikilink" title="rdf:about">rdf:about</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*\*
<span id='User.hasLogin'>User.hasLogin</span> -
<a href="foaf#holdsAccount" class="wikilink"
title="foaf:holdsAccount">foaf:holdsAccount</a>→**<a href="foaf#OnlineAccount" class="wikilink"
title="foaf:OnlineAccount">foaf:OnlineAccount</a>**→
<a href="foaf#accountName" class="wikilink"
title="foaf:accountName">foaf:accountName</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*\*
<span id='User.hasName'>User.hasName</span> -
<a href="foaf#name" class="wikilink" title="foaf:name">foaf:name</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*\*
<span id='User.hasPass'>User.hasPass</span> - not to make available via
RDF serialization
<span style='color:white;background-color:red;padding:2px;'>Not</span>\n\*\*
<span id='User.isGroup'>User.isGroup</span> - via
<a href="foaf#Group" class="wikilink" title="foaf:Group">foaf:Group</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*\*
<span id='User.hasEmail'>User.hasEmail</span> - SHA1-encoded -
<a href="foaf#mbox_sha1sum" class="wikilink"
title="foaf:mbox_sha1sum">foaf:mbox_sha1sum</a>\n\*\*
<span id='User.hasOrganization'>User.hasOrganization</span>\n\*\*
<span id='User.hasCity'>User.hasCity</span>\n\*\*
<span id='User.hasCountry'>User.hasCountry</span>\n\*\*
<span id='User.hasNote'>User.hasNote</span>\n\*\*
<span id='User.hasMember'>User.hasMember</span> - applicable to Group
users only - <a href="foaf#hasMember" class="wikilink"
title="foaf:hasMember">foaf:hasMember</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*
**<span id='Group'>Group</span>** - group is a special kind of User
entity -
<a href="foaf#Group" class="wikilink" title="foaf:Group">foaf:Group</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*
**<span id='Right'>Right</span>**\n\*\*
<span id='hasTargetAgent'>hasTargetAgent</span>\n\*\*
<span id='hasRightType'>hasRightType</span>\n\*\*
<span id='hasParentNodeType'>hasParentNodeType</span>\n\*\*
<span id='hasChildNodeType'>hasChildNodeType</span>\n\*\*
<span id='hasSubtreeNode'>hasSubtreeNode</span>\n\*\*
<span id='hasQuantity'>hasQuantity</span>\n\*\*
<span id='hasDescription'>hasDescription</span>\n\*\*
<span id='hasOwnerFlag'>hasOwnerFlag</span>\n \n\*
**<span id='ItemType'>ItemType</span>** - arguably doesn't need RDF
serialization\n\*\* <span id='itemtypeTitle'>itemtypeTitle</span>\n\*\*
<span id='itemtypeDescription'>itemtypeDescription</span>\n\*\*
<span id='itemtypeType'>itemtypeType</span>\n\*\*
<span id='itemtypeURL'>itemtypeURL</span>\n\*\*
<span id='itemtypeIcon'>itemtypeIcon</span>\n\*\*
<span id='itemtypeClassName'>itemtypeClassName</span>\n\*\*
<span id='itemtypeURLSufix'>itemtypeURLSufix</span>\n\*
**<span id='RightType'>RightType</span>** - arguably doesn't need RDF
serialization\n\*\*
<span id='righttypeTitle'>righttypeTitle</span>\n\*\*
<span id='righttypeDescription'>righttypeDescription</span>\n \n\n== See
also ==\n\* <a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a>\n\*
<a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a>
