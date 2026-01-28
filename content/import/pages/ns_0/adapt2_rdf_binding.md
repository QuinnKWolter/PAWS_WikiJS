---
title: "ADAPT2 RDF Binding"
source_namespace: "ns_0"
source_filename: "ADAPT2_RDF_Binding.md"
---


The main purpose of this effort is to map entity-relationship models
of applications in
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
architecture to
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework). If
necessary, appropriate comments would be given about models, schemata
and vocabularies themselves.

Further work has the following
structural units:
* ER Models - describe individual adaptive
applications. Each entity and relationship is supplied with a list of
suggested
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
bindings
*
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
schemata - describe classes and properties with suggested use in
describing entities and relationships of applications. Each schema can
have several vocabularies identified by prefixes

= Tentative
Conventions =
* Objects and Entities are shown in **boldface**
*
Properties and relationships - regular face
* Schema is written in
upper case, e.g. [DC](/ns_0/dc),
vocabulary in lower case, e.g.
[dc](/ns_0/dc),
[dcterms](/ns_0/dcterms)
* A
chain of Object/Property statements is abbreviated with the help of →
(`&rarr;`), e.g. <a href="rdf#Description" class="wikilink"
title="rdf:Description">rdf:Description</a>→[rdf:type](/ns_0/rdf#type)→<a href="rss#channel" class="wikilink"
title="rss:channel">rss:channel</a>
* Domain-Range pair of a Property
is prefixed with :: (double colon) and connected by ⇒ (`&rArr;`), e.g.
<a href="lom#annotation" class="wikilink"
title="lom:annotation">lom:annotation</a> ::
<a href="lom#LearningObject" class="wikilink"
title="lom:LearningObject">lom:LearningObject</a>⇒<a href="lom#Annotation" class="wikilink"
title="lom:Annotation">lom:Annotation</a>
* RDF-serialization of an ER
Element is implemented -
<span style='color:white;background-color:green;padding:2px;'>Done</span>
*
RDF-serialization of an ER Element is (arguably) unnecessary -
<span style='color:white;background-color:red;padding:2px;'>Not</span>
*
Decision on RDF serialization needs clarification -
<span style='color:white;background-color:orange;padding:2px;'>Clarify</span>

=
ER Models =
* <a href="Knowledge_Tree_RDF_Binding" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a> - course portal
(<span style='color:green;'>15</span>\|<span style='color:orange;'>0</span>\|<span style='color:red;'>1</span>\|<span style='color:black;'>33</span>)
*
[WebEx](/ns_0/webex_rdf_binding) -
application serving dissected examples
(<span style='color:green;'>--</span>\|<span style='color:orange;'>--</span>\|<span style='color:red;'>--</span>\|<span style='color:black;'>--</span>)
*
<a href="PERSEUS_RDF_Binding" class="wikilink"
title="PERSEUS">PERSEUS</a> - adaptive functionality profider
(<span style='color:green;'>--</span>\|<span style='color:orange;'>--</span>\|<span style='color:red;'>--</span>\|<span style='color:black;'>--</span>)
*
<a href="QuizPACK_RDF_Binding" class="wikilink"
title="QuizPACK">QuizPACK</a> - a package of parametrized quizzes in C
(<span style='color:green;'>--</span>\|<span style='color:orange;'>--</span>\|<span style='color:red;'>--</span>\|<span style='color:black;'>--</span>)
*
<a href="CUMULATE_RDF_Binding" class="wikilink"
title="CUMULATE">CUMULATE</a> - Centralized User Modeling Server
(<span style='color:green;'>--</span>\|<span style='color:orange;'>--</span>\|<span style='color:red;'>--</span>\|<span style='color:black;'>--</span>)

=
RDF Schemata and Vocabularies =
*
[RDF](/ns_0/rdf) - has single
vocabulary [rdf](/ns_0/rdf)
*
[RDFS](/ns_0/rdfs) - has single
vocabulary [rdfs](/ns_0/rdfs)
*
[OWL](/ns_0/OWL)
*
[Dublin Core](/ns_0/dc) - has
vocabularies [dc](/ns_0/dc),
[dcterms](/ns_0/dcterms),
[dcmitypes](/ns_0/dcmitypes)
*
[RSS](/ns_0/rss) - has single
vocabulary [rss](/ns_0/rss) (here we
mean RSS v.1.0)
*
[FOAF](/ns_0/foaf) - has single
vocabulary [foaf](/ns_0/foaf)
*
[LOM](/ns_0/lom) - has vocabularies
[lom](/ns_0/lom),
[lomvoc](/ns_0/lomvoc),
[lomstruc](/ns_0/lomstruc),
[lomagglvl](/ns_0/lomagglvl),
[lomstatus](/ns_0/lomstatus),
[lominttype](/ns_0/lominttype),
[lomlrtype](/ns_0/lomlrtype),
[lomintlvl](/ns_0/lomintlvl),
[lomsemden](/ns_0/lomsemden),
[lominteur](/ns_0/lominteur),
[lomcon](/ns_0/lomcon),
[lomdiff](/ns_0/lomdiff),
[lomrole](/ns_0/lomrole),
[lombrotech](/ns_0/lombrotech),
[lomostech](/ns_0/lomostech),
[lompurp](/ns_0/lompurp)

=
Polisemy AKA Equivalence =
Among various
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
schemata and vocabularies there exist overlap in what they actually
mean. For example, dc:title, rdf:label, and rss:title all mean the same.
We will maintain (our) <a href="classes_of_equivalence" class="wikilink"
title="classes of equivalence">classes of equivalence</a> as a reference
to [RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
homonyms.
