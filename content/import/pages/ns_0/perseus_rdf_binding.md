---
title: "PERSEUS RDF Binding"
source_namespace: "ns_0"
source_filename: "PERSEUS_RDF_Binding.md"
---



This page describes
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
binding of
[PERSEUS](/ns_0/perseus) data
model as part of <a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a> initiative.

#### Overview

Each
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
level of granularity.
<a href="#visualizer" class="wikilink"
title="Visualizers">Visualizers</a> only interpret a piece of annotation
<a href="#pservice" class="wikilink" title="PService">PService</a>
associates with resource or a feed.
<a href="#syndicator" class="wikilink"
title="Syndicators">Syndicators</a> in addition encapsulate access to
the resource feed(s) in the form of user interface.

== ER Model,
Annotations and RDF
Bindings==

[PERSEUS](/ns_0/perseus)
does not expose its model in RDF format. The only visible part is the
annotations
<a href="#pservice" class="wikilink" title="PServices">PServices</a>
generate.

###### ER Model

*
**<span id="pservice">pservice</span>** - Personalization Service
itself
** <span id="pservice.name">pservice name</span> - name of
PService
** <span id="pservice.description">pservice
description</span> - description of PService
**
<span id="pservice.classname">pservice classname</span> - class that
implements PService Functionality
**
<span id="pservice.hasConfiguration">pservice hasConfiguration</span> -
related data configurations
* **\[data\]
<span id="configuration">configuration</span>** - data configuration
that PService can use
* **<span id="visualizer">visualizer</span>** -
PService annotation interpreter
*
**<span id="syndicator">syndicator</span>** - PService annotation
interpreter

###### Annotations

* personal level annotations -
describe user
** personal attempt count -
** personal progress -

** personal knowledge -
* group level annotations - describe
group user is part of (e.g. class)
** \[average\] group attempt
count -
** \[average\] group progress -
** \[average\] group
knowledge -

#### See also

*
[PERSEUS](/ns_0/perseus)
*
<a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a>
