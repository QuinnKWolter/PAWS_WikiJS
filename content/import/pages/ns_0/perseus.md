---
title: "PERSEUS"
source_namespace: "ns_0"
source_filename: "PERSEUS.md"
---

## Overview


<img src="../../media/images/other/Perseus.gif" title="PERSEUS" width="100" alt="PERSEUS" />
[PERSEUS](/ns_0/perseus)
is a Personalization Service Engine. It provides adaptive support for
non-personalized (educational) hypermedia systems by abstracting content
presentation/aggregation from user modeling.
[PERSEUS](/ns_0/perseus) protocols
are based on [RDF](http://en.wikipedia.org/wiki/Rdf) and [RSS
1.0](http://en.wikipedia.org/wiki/RSS_(file_format)#RSS_1.0). Although,
[PERSEUS](/ns_0/perseus) was
initially developed for
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
framework, its data model permits seamless support of any other
hypermedia application. Currently
[PERSEUS](/ns_0/perseus) provides
social navigation support, topic-based navigation support, concept-based
navigation support, and adaptive recommendation.

#### Architecture

<img src="../../media/images/diagrams/Perseus_architecture.png" title="PERSEUS Architecture"
width="100" alt="PERSEUS Architecture" />
[PERSEUS](/ns_0/perseus)
resides between the user interface (e.g. portal) and the user modeling
server. The major sources of information for it are the content model
(structure of the adapted hyperspace) and the user model (information
about users).
[PERSEUS](/ns_0/perseus) is
comprised of three major components: adaptation strategies,
visualization model, and data model.

**Data model** plays a central
role in structuring the process of acquiring data from the environment.
Items of data model – called data contexts – contain several types of
information. These include addresses of the user modeling servers for
acquiring the user data, access points to data stores (relational and/or
semantic), URIs and URLs marking entry points to data stores, URI/URL
patterns to filter/select resources of interest in the content model,
etc.

**Adaptation strategies** (or \[personalization\] services )
are the scenarios used to produce the adaptation. They prescribe what
kind of data should be obtained from the available sources and how it
should be processed. The sources are specified in data contexts or could
be the results of other adaptation strategy (chained adaptations).
Relative independence of adaptation strategies allows them to be
(re-)used with multiple data contexts.

**Visualization model** is
comprised of special entities called visualizers. Visualizers contain
rules prescribing how the continuous data produced by adaptation
strategies (for example various measures of interest, importance,
knowledge, etc.) can be presented to the user. Often these rules control
how ranges of continuous values are mapped to discrete visual
annotations. Visualizers, just like the data contexts are relatively
independent from adaptation strategies. Different visualizers can be
selectively used with one adaptation strategy and also the same
visualizer to be used with different adaptation strategies.

#### Adaptation Strategies

Below are the schematic representations of the
three major adaptation techniques implemented in
[PERSEUS](/ns_0/perseus):
social-based, topic-based, and concept-based navigation.



Image:Perseus-service-social.png\|Schema of social-based navigation in
[PERSEUS](/ns_0/perseus)
Image:Perseus-service-topic.png\|Schema
of topic-based navigation in
[PERSEUS](/ns_0/perseus)
Image:Perseus-service-concept.png\|Schema
of concept-based navigation in
[PERSEUS](/ns_0/perseus)




==Publications==
<onlyinclude>

*
<a href="User:myudelson" class="wikilink" title="Yudelson, M.">Yudelson,
M.</a> (2010) **Providing Service-based Personalization in an Adaptive
Hypermedia System**. Doctoral Dissertation, University of Pittsburgh.
[ETD](http://d-scholarship.pitt.edu/9463/)
*
<a href="User:myudelson" class="wikilink" title="Yudelson, M.">Yudelson,
M.</a> and <a href="User:peterb" class="wikilink"
title="Brusilovsky, P.">Brusilovsky, P.</a>. (2008). **Adaptive Link
Annotation in Distributed Hypermedia Systems: The Evaluation of a
Service-Based Approach**. In W. Nejdl, J. Kay, P. Pu, and E. Herder
(Eds.), 5th International Conference on Adaptive Hypermedia and Adaptive
Web-Based Systems (AH 2008), (pp. 245-254).
[DOI](http://dx.doi.org/10.1007/978-3-540-70987-9_27)
* Zadorozhny,
V.,
<a href="User:myudelson" class="wikilink" title="Yudelson, M.">Yudelson,
M.</a>, and <a href="User:peterb" class="wikilink"
title="Brusilovsky, P.">Brusilovsky, P.</a> (2008) **A Framework for
Performance Evaluation of User Modeling Servers for Web Applications**.
Web Intelligence and Agent Systems 6(2), 175-191.
[DOI](http://dx.doi.org/10.3233/WIA-2008-0136)
*
<a href="User:myudelson" class="wikilink" title="Yudelson, M.">Yudelson,
M.</a>, <a href="User:peterb" class="wikilink"
title="Brusilovsky, P.">Brusilovsky, P.</a>, and Zadorozhny, V. (2007)
**A user modeling server for contemporary adaptive hypermedia: An
evaluation of the push approach to evidence propagation**. In Conati,
C., McCoy, K. F., and Paliouras, G. Eds., User Modeling, volume 4511 of
Lecture Notes in Computer Science, pp 27-36. Springer, 2007.
[PDF](http://www.pitt.edu/~mvy3/assets/YudelsonUM2007.pdf)
[DOI](http://dx.doi.org/10.1007/978-3-540-73078-1_6)
</onlyinclude>

==See
also==
*
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a> -
Advanced Distributed Architecture for Personalized Teaching and
Training
* <a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a>
* Standardization:
<a href="PERSEUS_RDF_Binding" class="wikilink"
title="PERSEUS RDF Binding">PERSEUS RDF Binding</a>
*
<a href="PERSEUS_adaptation_for_Ensemble_project" class="wikilink"
title="PERSEUS adaptation for Ensemble project">PERSEUS adaptation for
Ensemble project</a>

#### Contacts

<a href="User:Myudelson" class="wikilink" title=" Michael V. Yudelson">
Michael V. Yudelson</a>
