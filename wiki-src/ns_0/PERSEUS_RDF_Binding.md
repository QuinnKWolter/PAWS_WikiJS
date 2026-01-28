\n\nThis page describes
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
binding of
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a> data
model as part of <a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a> initiative. \n\n==
Overview ==\n\nEach
<a href="#pservice" class="wikilink" title="PService">PService</a> can
be set up to use several data sources -
<a href="#configuration" class="wikilink"
title="configurations">configurations</a>. Annotations each
<a href="#pservice" class="wikilink" title="PService">PService</a>
provides can either be used as is, in the form of RDF, or can be
interpreted. Interpretation is provided by
<a href="#visualizer" class="wikilink"
title="visualizers">visualizers</a> and
<a href="#syndicator" class="wikilink"
title="syndicators">syndicators</a>. Both
<a href="#visualizer" class="wikilink"
title="visualizers">visualizers</a> and
<a href="#syndicator" class="wikilink"
title="syndicators">syndicators</a> do the same work, but at a different
level of granularity. \n<a href="#visualizer" class="wikilink"
title="Visualizers">Visualizers</a> only interpret a piece of annotation
<a href="#pservice" class="wikilink" title="PService">PService</a>
associates with resource or a feed.
<a href="#syndicator" class="wikilink"
title="Syndicators">Syndicators</a> in addition encapsulate access to
the resource feed(s) in the form of user interface.\n\n== ER Model,
Annotations and RDF
Bindings==\n\n<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a>
does not expose its model in RDF format. The only visible part is the
annotations
<a href="#pservice" class="wikilink" title="PServices">PServices</a>
generate.\n\n=== ER Model ===\n\n\*
**<span id="pservice">pservice</span>** - Personalization Service
itself\n\*\* <span id="pservice.name">pservice name</span> - name of
PService\n\*\* <span id="pservice.description">pservice
description</span> - description of PService\n\*\*
<span id="pservice.classname">pservice classname</span> - class that
implements PService Functionality\n\*\*
<span id="pservice.hasConfiguration">pservice hasConfiguration</span> -
related data configurations\n\* **\[data\]
<span id="configuration">configuration</span>** - data configuration
that PService can use\n\* **<span id="visualizer">visualizer</span>** -
PService annotation interpreter\n\*
**<span id="syndicator">syndicator</span>** - PService annotation
interpreter\n\n=== Annotations ===\n\n\* personal level annotations -
describe user\n\*\* personal attempt count - \n\*\* personal progress -
\n\*\* personal knowledge - \n\* group level annotations - describe
group user is part of (e.g. class)\n\*\* \[average\] group attempt
count - \n\*\* \[average\] group progress -\n\*\* \[average\] group
knowledge -\n\n== See also ==\n\*
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a>\n\*
<a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a>
