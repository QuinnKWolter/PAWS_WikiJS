---
title: "WebEx RDF Binding"
source_namespace: "ns_0"
source_filename: "WebEx_RDF_Binding.md"
---


This page describes
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
binding of [WebEx](/ns_0/webex) data
model as part of <a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a> initiative.

== ER
Model and RDF Bindings==
* **<span id="scope">scope</span>** -
collection (set, bag) of <a href="#dissection" class="wikilink"
title="dissections">dissections</a> -
<a href="rss#channel" class="wikilink"
title="rss:channel">rss:channel</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>,
alternatively <a href="dcmitypes#Collection" class="wikilink"
title="dcmitypes:Collection">dcmitypes:Collection</a>
**
<span id="scope.name">scope.name</span> -
<a href="rss#channel.title" class="wikilink"
title="rss:channel.title">rss:channel.title</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id="scope.description">scope.description</span> -
<a href="rss#channel.description" class="wikilink"
title="rss:channel.description">rss:channel.description</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id="scope.hasDissection">scope.hasDissection</span> -
<a href="rss#channel.items" class="wikilink"
title="rss:channel.items">rss:channel.items</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>
*
**<span id="dissection">dissection</span>** -
**
<span id="dissection.name">dissection.name</span> -
<a href="rss#item.title" class="wikilink"
title="rss:item.title">rss:item.title</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id="dissection.description">dissection.description</span> -
<a href="rss#item.description" class="wikilink"
title="rss:item.description">rss:item.description</a>
<span style='color:white;background-color:green;padding:2px;'>Done</span>
**
<span id="dissection.hasLine">dissection.hasLine</span> -
*
**<span id="line">line</span>** -
*
**<span id="annotation">annotation</span>** -

#### See also

*
[WebEx](/ns_0/webex)
*
<a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a>
