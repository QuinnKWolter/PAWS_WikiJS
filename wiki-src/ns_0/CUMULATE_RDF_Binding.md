\n\nThis page describes
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
binding of
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a> data
model as part of <a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a> initiative.\n\n== ER
Model ==\nThis model only describes what we intend to serialize in RDF,
which is only a part of
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a> data
model.\n\* **<span id='User Action'>User Action</span>** -
<a href="dcmitypes#Event" class="wikilink"
title="dcmitypes:Event">dcmitypes:Event</a>\n\*\*
<span id='Node.hasChildNode'>User Action.Application</span> -
application reporting user action -
<a href="dcmitypes#Service" class="wikilink"
title="dcmitypes:Service">dcmitypes:Service</a> or maybe
<a href="dc#publisher" class="wikilink"
title="dc:publisher">dc:publisher</a>\n\*\*
<span id='User Action.User'>User Action.User</span> - user -
<a href="foaf#Person" class="wikilink"
title="foaf:Person">foaf:Person</a>\n\*\*
<span id='User Action.Group'>User Action.Group</span> - group user
belongs to -
<a href="foaf#Group" class="wikilink" title="foaf:Group">foaf:Group</a>\n\*\*
<span id='User Action.Result'>User Action.Result</span> - result of user
action\n\*\* <span id='User Action.Learning Object'>User Action.Learning
Object</span> - learning object being interacted with -
<a href="dcmitypes#InteractiveResource" class="wikilink"
title="dcmitypes:InteractiveResource">dcmitypes:InteractiveResource</a>,
something from LOM?\n\*\* <span id='User Action.Session'>User
Action.Session</span> - user session -\n\*\*
<span id='User Action.DateTime'>User Action.DateTime</span> - date and
time - <a href="dcterms#dateSubmitted" class="wikilink"
title="dcterms:dateSubmitted">dcterms:dateSubmitted</a> or
<a href="dc#date" class="wikilink" title="dc:date">dc:date</a>\n\*\*
<span id='User Action.SVC'>User Action.SVC</span> - additional character
data\n\*\* <span id='User Action.AllParameters'>User
Action.AllParameters</span> - concatenation of all reported data -
hashed via
<a href="rdf#about" class="wikilink" title="rdf:about">rdf:about</a>\n\*
**<span id='User Knowledge Assertion'>User Knowledge
Assertion</span>** - \n\*\*
<span id='User Knowledge Assertion.User'>User Knowledge
Assertion.User</span> - user - <a href="foaf#Person" class="wikilink"
title="foaf:Person">foaf:Person</a>\n\*\*
<span id='User Knowledge Assertion.Knowledge Component'>User Knowledge
Assertion.Knowledge Component</span> - item user knowledge is being
related to - \n\*\*
<span id='User Knowledge Assertion.Cognitive Level'>User Knowledge
Assertion.Cognitive Level</span> - Bloom's cognitive level of
knowledge - \n\*\* <span id='User Knowledge Assertion.Value'>User
Knowledge Assertion.Value</span> - knowledge value - \n\*
**<span id='User Progress Assertion'>User Progress Assertion</span>** -
\n\*\* <span id='User Progress Assertion.User'>User Progress
Assertion.User</span> - user - <a href="foaf#Person" class="wikilink"
title="foaf:Person">foaf:Person</a>\n\*\*
<span id='User Progress Assertion.Learning Object'>User Progress
Assertion.Learning Object</span> - learning object being interacted
with - <a href="dcmitypes#InteractiveResource" class="wikilink"
title="dcmitypes:InteractiveResource">dcmitypes:InteractiveResource</a>,
something from LOM?\n\*\* <span id='User Progress Assertion.Value'>User
Progress Assertion.Value</span> - progress vale -\n\n== See also ==\n\*
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>\n\*
<a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT2 RDF Binding</a>
