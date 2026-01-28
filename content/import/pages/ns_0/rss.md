---
title: "RSS"
source_namespace: "ns_0"
source_filename: "RSS.md"
---

## Overview


The following is an enumeration of objects and properties from
[rss](/ns_0/rss) vocabulry of
[RSS](/ns_0/rss) schema as well as
bindings of objects and properties to model entities and relationships.
So far only <a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a> and
[WebEx](/ns_0/webex_rdf_binding) are
bound.

== Prefix #### rss : [http://purl.org/rss/1.0/](http://purl.org/rss/1.0/

==) Objects
and Properties ==
* **<span id="channel">channel</span>** -
<a href="Knowledge_Tree#Node" class="wikilink"
title="Knowledge Tree:Node">Knowledge Tree:Node</a>,
<a href="WebEx_RDF_Binding#scope" class="wikilink"
title="WebEx:scope">WebEx:scope</a>
**
<span id="channel.title">channel title</span> -
<a href="Knowledge_Tree#Node.nodeTitle" class="wikilink"
title="Knowledge Tree:Node.nodeTitle">Knowledge Tree:Node.nodeTitle</a>,
<a href="WebEx_RDF_Binding#scope.name" class="wikilink"
title="WebEx:scope.name">WebEx:scope.name</a>
**
<span id="channel.link">channel link</span> -
<a href="Knowledge_Tree#Node.hasURL" class="wikilink"
title="Knowledge Tree:Node.hasURL">Knowledge Tree:Node.hasURL</a>,
<a href="WebEx_RDF_Binding#scope" class="wikilink"
title="WebEx:scope">WebEx:scope</a>
**
<span id="channeldescription">channel description</span> -
<a href="Knowledge_Tree#Node.nodeDescription" class="wikilink"
title="Knowledge Tree:Node.nodeDescription">Knowledge
Tree:Node.nodeDescription</a>,
<a href="WebEx_RDF_Binding#scope.description" class="wikilink"
title="WebEx:scope.description">WebEx:scope.description</a>
**
<span id="channel.image">channel image</span> - optional logo
**
<span id="channel.items">channel items</span> -
<a href="Knowledge_Tree#hasChildNode" class="wikilink"
title="Knowledge Tree:hasChildNode">Knowledge Tree:hasChildNode</a>,
[WebEx](/ns_0/webex_rdf_binding)
scope-dissection relationship
** <span id="channel.textinput">channel
textinput</span> - intended as
[WebEx](/ns_0/webex_rdf_binding)
item search (future)
* **<span id="image">image</span>** - optional
logo
** <span id="image.title">image title</span> -
**
<span id="image.url">image url</span>
** <span id="image.link">image
link</span>
* **<span id="item">item</span>** -
<a href="Knowledge_Tree#Node" class="wikilink"
title="Knowledge Tree:Node">Knowledge Tree:Node</a>,
<a href="WebEx_RDF_Binding#dissecion" class="wikilink"
title="WebEx:dissecion">WebEx:dissecion</a>
**
<span id="item.title">item title</span> -
<a href="Knowledge_Tree#Node.nodeTitle" class="wikilink"
title="Knowledge Tree:Node.nodeTitle">Knowledge Tree:Node.nodeTitle</a>,
<a href="WebEx_RDF_Binding#dissection.title" class="wikilink"
title="WebEx:dissection.title">WebEx:dissection.title</a>
**
<span id="item.link">item link</span> -
<a href="Knowledge_Tree#Node.hasURL" class="wikilink"
title="Knowledge Tree:Node.hasURL">Knowledge Tree:Node.hasURL</a>,
<a href="WebEx_RDF_Binding#dissection" class="wikilink"
title="WebEx:dissection">WebEx:dissection</a>
**
<span id="item.description">item description</span> -
<a href="Knowledge_Tree#Node.nodeDescription" class="wikilink"
title="Knowledge Tree:Node.nodeDescription">Knowledge
Tree:Node.nodeDescription</a>,
<a href="WebEx_RDF_Binding#dissection.description" class="wikilink"
title="WebEx:dissection.description">WebEx:dissection.description</a>

* **<span id="textinput">textinput</span>** -
**
<span id="textinput.title">textinput title</span> -
**
<span id="textinput.description">textinput description</span> -
**
<span id="textinput.name">textinput name</span> -
**
<span id="textinput.link">textinput link</span> -
