---
title: "CUMULATE RDF Binding"
source_namespace: "ns_0"
source_filename: "CUMULATE_RDF_Binding.md"
---



This page describes
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
binding of
[CUMULATE](/ns_0/cumulate) data
model as part of <a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a> initiative.

#### ER Model

This model only describes what we intend to serialize in RDF,
which is only a part of
[CUMULATE](/ns_0/cumulate) data
model.
* **<span id='User Action'>User Action</span>** -
<a href="dcmitypes#Event" class="wikilink"
title="dcmitypes:Event">dcmitypes:Event</a>
**
<span id='Node.hasChildNode'>User Action.Application</span> -
application reporting user action -
<a href="dcmitypes#Service" class="wikilink"
title="dcmitypes:Service">dcmitypes:Service</a> or maybe
<a href="dc#publisher" class="wikilink"
title="dc:publisher">dc:publisher</a>
**
<span id='User Action.User'>User Action.User</span> - user -
<a href="foaf#Person" class="wikilink"
title="foaf:Person">foaf:Person</a>
**
<span id='User Action.Group'>User Action.Group</span> - group user
belongs to -
[foaf:Group](/ns_0/foaf#group)
**
<span id='User Action.Result'>User Action.Result</span> - result of user
action
** <span id='User Action.Learning Object'>User Action.Learning
Object</span> - learning object being interacted with -
<a href="dcmitypes#InteractiveResource" class="wikilink"
title="dcmitypes:InteractiveResource">dcmitypes:InteractiveResource</a>,
something from LOM?
** <span id='User Action.Session'>User
Action.Session</span> - user session -
**
<span id='User Action.DateTime'>User Action.DateTime</span> - date and
time - <a href="dcterms#dateSubmitted" class="wikilink"
title="dcterms:dateSubmitted">dcterms:dateSubmitted</a> or
[dc:date](/ns_0/dc#date)
**
<span id='User Action.SVC'>User Action.SVC</span> - additional character
data
** <span id='User Action.AllParameters'>User
Action.AllParameters</span> - concatenation of all reported data -
hashed via
[rdf:about](/ns_0/rdf#about)
*
**<span id='User Knowledge Assertion'>User Knowledge
Assertion</span>** -
**
<span id='User Knowledge Assertion.User'>User Knowledge
Assertion.User</span> - user - <a href="foaf#Person" class="wikilink"
title="foaf:Person">foaf:Person</a>
**
<span id='User Knowledge Assertion.Knowledge Component'>User Knowledge
Assertion.Knowledge Component</span> - item user knowledge is being
related to -
**
<span id='User Knowledge Assertion.Cognitive Level'>User Knowledge
Assertion.Cognitive Level</span> - Bloom's cognitive level of
knowledge -
** <span id='User Knowledge Assertion.Value'>User
Knowledge Assertion.Value</span> - knowledge value -
*
**<span id='User Progress Assertion'>User Progress Assertion</span>** -

** <span id='User Progress Assertion.User'>User Progress
Assertion.User</span> - user - <a href="foaf#Person" class="wikilink"
title="foaf:Person">foaf:Person</a>
**
<span id='User Progress Assertion.Learning Object'>User Progress
Assertion.Learning Object</span> - learning object being interacted
with - <a href="dcmitypes#InteractiveResource" class="wikilink"
title="dcmitypes:InteractiveResource">dcmitypes:InteractiveResource</a>,
something from LOM?
** <span id='User Progress Assertion.Value'>User
Progress Assertion.Value</span> - progress vale -

#### See also

*
[CUMULATE](/ns_0/cumulate)
*
<a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a>
