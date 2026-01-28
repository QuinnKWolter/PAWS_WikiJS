\nThe main purpose of this effort is to map entity-relationship models
of applications in
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
architecture to
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework). If
necessary, appropriate comments would be given about models, schemata
and vocabularies themselves.\n\nFurther work has the following
structural units:\n\* ER Models - describe individual adaptive
applications. Each entity and relationship is supplied with a list of
suggested
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
bindings\n\*
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
schemata - describe classes and properties with suggested use in
describing entities and relationships of applications. Each schema can
have several vocabularies identified by prefixes\n\n= Tentative
Conventions =\n\* Objects and Entities are shown in **boldface**\n\*
Properties and relationships - regular face\n\* Schema is written in
upper case, e.g. <a href="DC" class="wikilink" title="DC">DC</a>,
vocabulary in lower case, e.g.
<a href="dc" class="wikilink" title="dc">dc</a>,
<a href="dcterms" class="wikilink" title="dcterms">dcterms</a>\n\* A
chain of Object/Property statements is abbreviated with the help of →
(`&rarr;`), e.g. <a href="rdf#Description" class="wikilink"
title="rdf:Description">rdf:Description</a>→<a href="rdf#type" class="wikilink" title="rdf:type">rdf:type</a>→<a href="rss#channel" class="wikilink"
title="rss:channel">rss:channel</a>\n\* Domain-Range pair of a Property
is prefixed with :: (double colon) and connected by ⇒ (`&rArr;`), e.g.
<a href="lom#annotation" class="wikilink"
title="lom:annotation">lom:annotation</a> ::
<a href="lom#LearningObject" class="wikilink"
title="lom:LearningObject">lom:LearningObject</a>⇒<a href="lom#Annotation" class="wikilink"
title="lom:Annotation">lom:Annotation</a>\n\* RDF-serialization of an ER
Element is implemented -
<span style='color:white;background-color:green;padding:2px;'>Done</span>\n\*
RDF-serialization of an ER Element is (arguably) unnecessary -
<span style='color:white;background-color:red;padding:2px;'>Not</span>\n\*
Decision on RDF serialization needs clarification -
<span style='color:white;background-color:orange;padding:2px;'>Clarify</span>\n\n=
ER Models =\n\* <a href="Knowledge_Tree_RDF_Binding" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a> - course portal
(<span style='color:green;'>15</span>\|<span style='color:orange;'>0</span>\|<span style='color:red;'>1</span>\|<span style='color:black;'>33</span>)\n\*
<a href="WebEx_RDF_Binding" class="wikilink" title="WebEx">WebEx</a> -
application serving dissected examples
(<span style='color:green;'>--</span>\|<span style='color:orange;'>--</span>\|<span style='color:red;'>--</span>\|<span style='color:black;'>--</span>)\n\*
<a href="PERSEUS_RDF_Binding" class="wikilink"
title="PERSEUS">PERSEUS</a> - adaptive functionality profider
(<span style='color:green;'>--</span>\|<span style='color:orange;'>--</span>\|<span style='color:red;'>--</span>\|<span style='color:black;'>--</span>)\n\*
<a href="QuizPACK_RDF_Binding" class="wikilink"
title="QuizPACK">QuizPACK</a> - a package of parametrized quizzes in C
(<span style='color:green;'>--</span>\|<span style='color:orange;'>--</span>\|<span style='color:red;'>--</span>\|<span style='color:black;'>--</span>)\n\*
<a href="CUMULATE_RDF_Binding" class="wikilink"
title="CUMULATE">CUMULATE</a> - Centralized User Modeling Server
(<span style='color:green;'>--</span>\|<span style='color:orange;'>--</span>\|<span style='color:red;'>--</span>\|<span style='color:black;'>--</span>)\n\n=
RDF Schemata and Vocabularies =\n\*
<a href="RDF" class="wikilink" title="RDF">RDF</a> - has single
vocabulary <a href="rdf" class="wikilink" title="rdf">rdf</a>\n\*
<a href="RDFS" class="wikilink" title="RDFS">RDFS</a> - has single
vocabulary <a href="rdfs" class="wikilink" title="rdfs">rdfs</a>\n\*
<a href="OWL" class="wikilink" title="OWL">OWL</a>\n\*
<a href="DC" class="wikilink" title="Dublin Core">Dublin Core</a> - has
vocabularies <a href="dc" class="wikilink" title="dc">dc</a>,
<a href="dcterms" class="wikilink" title="dcterms">dcterms</a>,
<a href="dcmitypes" class="wikilink" title="dcmitypes">dcmitypes</a>\n\*
<a href="RSS" class="wikilink" title="RSS">RSS</a> - has single
vocabulary <a href="rss" class="wikilink" title="rss">rss</a> (here we
mean RSS v.1.0)\n\*
<a href="FOAF" class="wikilink" title="FOAF">FOAF</a> - has single
vocabulary <a href="foaf" class="wikilink" title="foaf">foaf</a>\n\*
<a href="LOM" class="wikilink" title="LOM">LOM</a> - has vocabularies
<a href="lom" class="wikilink" title="lom">lom</a>,
<a href="lomvoc" class="wikilink" title="lomvoc">lomvoc</a>,
<a href="lomstruc" class="wikilink" title="lomstruc">lomstruc</a>,
<a href="lomagglvl" class="wikilink" title="lomagglvl">lomagglvl</a>,
<a href="lomstatus" class="wikilink" title="lomstatus">lomstatus</a>,
<a href="lominttype" class="wikilink" title="lominttype">lominttype</a>,
<a href="lomlrtype" class="wikilink" title="lomlrtype">lomlrtype</a>,
<a href="lomintlvl" class="wikilink" title="lomintlvl">lomintlvl</a>,
<a href="lomsemden" class="wikilink" title="lomsemden">lomsemden</a>,
<a href="lominteur" class="wikilink" title="lominteur">lominteur</a>,
<a href="lomcon" class="wikilink" title="lomcon">lomcon</a>,
<a href="lomdiff" class="wikilink" title="lomdiff">lomdiff</a>,
<a href="lomrole" class="wikilink" title="lomrole">lomrole</a>,
<a href="lombrotech" class="wikilink" title="lombrotech">lombrotech</a>,
<a href="lomostech" class="wikilink" title="lomostech">lomostech</a>,
<a href="lompurp" class="wikilink" title="lompurp">lompurp</a>\n\n=
Polisemy AKA Equivalence =\nAmong various
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
schemata and vocabularies there exist overlap in what they actually
mean. For example, dc:title, rdf:label, and rss:title all mean the same.
We will maintain (our) <a href="classes_of_equivalence" class="wikilink"
title="classes of equivalence">classes of equivalence</a> as a reference
to [RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
homonyms.
