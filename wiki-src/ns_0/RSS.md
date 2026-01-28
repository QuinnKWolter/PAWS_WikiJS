## Overview

\nThe following is an enumeration of objects and properties from
<a href="rss" class="wikilink" title="rss">rss</a> vocabulry of
<a href="RSS" class="wikilink" title="RSS">RSS</a> schema as well as
bindings of objects and properties to model entities and relationships.
So far only <a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a> and
<a href="WebEx_RDF_Binding" class="wikilink" title="WebEx">WebEx</a> are
bound.\n\n== Prefix ==\nrss :
[http://purl.org/rss/1.0/\n\n==](http://purl.org/rss/1.0/\n\n==) Objects
and Properties ==\n\* **<span id="channel">channel</span>** -
<a href="Knowledge_Tree#Node" class="wikilink"
title="Knowledge Tree:Node">Knowledge Tree:Node</a>,
<a href="WebEx_RDF_Binding#scope" class="wikilink"
title="WebEx:scope">WebEx:scope</a>\n\*\*
<span id="channel.title">channel title</span> -
<a href="Knowledge_Tree#Node.nodeTitle" class="wikilink"
title="Knowledge Tree:Node.nodeTitle">Knowledge Tree:Node.nodeTitle</a>,
<a href="WebEx_RDF_Binding#scope.name" class="wikilink"
title="WebEx:scope.name">WebEx:scope.name</a>\n\*\*
<span id="channel.link">channel link</span> -
<a href="Knowledge_Tree#Node.hasURL" class="wikilink"
title="Knowledge Tree:Node.hasURL">Knowledge Tree:Node.hasURL</a>,
<a href="WebEx_RDF_Binding#scope" class="wikilink"
title="WebEx:scope">WebEx:scope</a>\n\*\*
<span id="channeldescription">channel description</span> -
<a href="Knowledge_Tree#Node.nodeDescription" class="wikilink"
title="Knowledge Tree:Node.nodeDescription">Knowledge
Tree:Node.nodeDescription</a>,
<a href="WebEx_RDF_Binding#scope.description" class="wikilink"
title="WebEx:scope.description">WebEx:scope.description</a>\n\*\*
<span id="channel.image">channel image</span> - optional logo\n\*\*
<span id="channel.items">channel items</span> -
<a href="Knowledge_Tree#hasChildNode" class="wikilink"
title="Knowledge Tree:hasChildNode">Knowledge Tree:hasChildNode</a>,
<a href="WebEx_RDF_Binding" class="wikilink" title="WebEx">WebEx</a>
scope-dissection relationship\n\*\* <span id="channel.textinput">channel
textinput</span> - intended as
<a href="WebEx_RDF_Binding" class="wikilink" title="WebEx">WebEx</a>
item search (future)\n\* **<span id="image">image</span>** - optional
logo\n\*\* <span id="image.title">image title</span> -\n\*\*
<span id="image.url">image url</span>\n\*\* <span id="image.link">image
link</span>\n\* **<span id="item">item</span>** -
<a href="Knowledge_Tree#Node" class="wikilink"
title="Knowledge Tree:Node">Knowledge Tree:Node</a>,
<a href="WebEx_RDF_Binding#dissecion" class="wikilink"
title="WebEx:dissecion">WebEx:dissecion</a>\n\*\*
<span id="item.title">item title</span> -
<a href="Knowledge_Tree#Node.nodeTitle" class="wikilink"
title="Knowledge Tree:Node.nodeTitle">Knowledge Tree:Node.nodeTitle</a>,
<a href="WebEx_RDF_Binding#dissection.title" class="wikilink"
title="WebEx:dissection.title">WebEx:dissection.title</a> \n\*\*
<span id="item.link">item link</span> -
<a href="Knowledge_Tree#Node.hasURL" class="wikilink"
title="Knowledge Tree:Node.hasURL">Knowledge Tree:Node.hasURL</a>,
<a href="WebEx_RDF_Binding#dissection" class="wikilink"
title="WebEx:dissection">WebEx:dissection</a> \n\*\*
<span id="item.description">item description</span> -
<a href="Knowledge_Tree#Node.nodeDescription" class="wikilink"
title="Knowledge Tree:Node.nodeDescription">Knowledge
Tree:Node.nodeDescription</a>,
<a href="WebEx_RDF_Binding#dissection.description" class="wikilink"
title="WebEx:dissection.description">WebEx:dissection.description</a>
\n\* **<span id="textinput">textinput</span>** - \n\*\*
<span id="textinput.title">textinput title</span> - \n\*\*
<span id="textinput.description">textinput description</span> - \n\*\*
<span id="textinput.name">textinput name</span> - \n\*\*
<span id="textinput.link">textinput link</span> -
