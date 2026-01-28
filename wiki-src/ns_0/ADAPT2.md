## Overview

\n![**100**\|ADAPT<sup>2</sup>
Architecture](adapt2-arcitecture.gif "100|ADAPT2 Architecture")\n\n<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
(read adapt-square) - Advanced Distributed Architecture for Personalized
Teaching and Training - is a framework for research on personalized and
adaptive learning, which brings together researchers exploring novel
types of interactive learning content with researchers exploring various
kinds of personalization approaches. As a part of its mission,
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
currently provides personalized learning systems to support large
classes for several computer science education topics such as Java,
Python, and SQL. It has been used in many universities on four
continents.\n\n<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
consists of the following principal component types.\n\* Portals, such
as <a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a>, which provide a single
sign-on point for users of personalized learning systems\n\*
User-modeling servers such
as<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>,
which maintain knowledge models of individual students\n\* Content
Servers, which provide access to various kinds of interactive learning
objects \n\* Adaptive Shells, which offer various kinds of personalized
access to learning objects\n\*
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a> -
personalization service engine\n\nTo provide personalized service to its
end users, these components communicate with each other using several
standard communication protocols. Two main groups of protocols are
<a href="Content_Invocation_protocols" class="wikilink"
title="Content Invocation protocols">Content Invocation protocols</a>,
which enable a portal or an adaptive shell to call interactive learning
objects residing on various content servers, and
<a href="CUMULATE_protocol" class="wikilink"
title="User Modeling protocols">User Modeling protocols</a> for
reporting user activities and requesting current state of their
knowledge from user-modeling servers.\n\nA typical personalized learning
system supported by
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
works in the following way:\n\n\* Students log in through a portal, such
as <a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a> or a regular learning
management system, which determines which courses (learning groups) they
can access. To start learning, students choose one of these courses.
\n\* A selected course provides access to one or more adaptive shells,
such as <a href="MasteryGrids" class="wikilink"
title="MasteryGrids">MasteryGrids</a>. Each of these shells provides
personalized access to multiple kinds of learning content made
accessible for the course. The selected course also determines which
student modeling server will be used for personalization.\n\* Using the
current state of the user models, which the adaptive shell requests from
the user-modeling server, the shell helps each student find and launch
an interactive learning object that is most appropriate for the current
state of their knowledge. \n\* While the students work with the selected
interactive learning object, all their activities are reported back to
the user-modeling server, which uses these activities to update the
state of individual learners' knowledge.\n\* After completing their work
with each learning object, the students return to the adaptive shell,
which now uses the updated state of the user model to assist the
learners with selecting the next knowledge- and context-appropriate
learning object.\n\nThe personalized learning process supported by
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
is quite typical for personalized learning. The difference made by
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
is the ability to integrate components developed by multiple research
teams. A research team exploring specific kind of learning objects could
release them in a new content server and re-use other components
(portals, user-modeling servers, adaptive shells) to explore these
objects in a realistic context along with other types of objects. A team
that explores new approaches for user modeling or personalization could
develop new types of user-modeling servers and adaptive shells and reuse
components developed by other teams.
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
promotes collaboration and enables each team to focus on the type of
learning technology that they want to explore.\n\nThe original design of
the
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
architecture was presented in the following papers:\n\* Brusilovsky, P.
and Nijhawan, H. (2002) A Framework for Adaptive E-Learning Based on
Distributed Re-usable Learning Activities. In: M. Driscoll and T. C.
Reeves (eds.) Proceedings of World Conference on E-Learning, E-Learn
2002, Montreal, Canada, October 15-19, 2002, AACE, pp.
154-161.Brusilovsky, P. (2004) KnowledgeTree: A distributed architecture
for adaptive e-learning. In: Proceedings of 13th International World
Wide Web Conference, WWW 2004, New York, NY, 17-22 May, 2004, ACM Press,
pp. 104-113.\n\* Brusilovsky, P., Sosnovsky, S., and Yudelson, M. (2004)
Adaptive Hypermedia Services for E-Learning. In: Proceedings of Workshop
on Applying Adaptive Hypermedia Techniques to Service Oriented
Environments at the Third International Conference on Adaptive
Hypermedia and Adaptive Web-Based Systems (AH'2004), Eindhoven, the
Netherlands, August 23, 2004, Technische University Eindhoven, pp.
470-479.\n\nOver the years, the infrastructure has been expanded with
support of several projects such as <a
href="Personalized_Access_to_Open_Corpus_Educational_Resources_through_Adaptive_Navigation_Support_and_Adaptive_Visualization"
class="wikilink"
title="Personalized Access to Open Corpus Educational Resources through Adaptive Navigation Support and Adaptive Visualization">Personalized
Access to Open Corpus Educational Resources through Adaptive Navigation
Support and Adaptive Visualization</a> and <a
href="Adaptive_Navigation_Support_and_Open_Social_Learner_Modeling_for_PAL"
class="wikilink"
title="Adaptive Navigation Support and Open Social Learner Modeling for PAL">Adaptive
Navigation Support and Open Social Learner Modeling for PAL</a>. We
developed several adaptive shells to explore a range of personalization
approaches and collaborated with many research teams to offer a broad
set of interactive learning objects for computer science education.
Currently, we are integrating
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
into a larger community-oriented infrastructure that is being developed
by NSF-supported Infrastructure project <a
href="Community-Building_and_Infrastructure_Design_for_Data-Intensive_Research_in_Computer_Science_Education"
class="wikilink"
title="Community-Building and Infrastructure Design for Data-Intensive Research in Computer Science Education">Community-Building
and Infrastructure Design for Data-Intensive Research in Computer
Science Education</a>.\n\n== Knowledge Tree ==\n{\|\n\| valign="top" \|
![**100**\|Knowledge
Tree](KnowledgeTreeLogo.gif "100|Knowledge Tree")\n\| valign="top" \|
<a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a> is a link aggregating portal.
It presents content structured according to the folder-document
paradigm. <a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a> provides authentication and
authorization and implements a simplified form of access control. It
supports collaborative authoring and social annotation.
(<a href="Knowledge_Tree" class="wikilink" title="more">more</a>)\n\|}\n\n==
CUMULATE
==\n<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a> is
a central user modeling server responsible for collecting evidence of
user activity and for generating user models, i.e., assertions about the
knowledge and mastery of individual users. Personalization components of
the architecture, such as personalized shells and personalized learning
content, could get access to the user models (using CUMULATE protocols)
to offer personalized access and other personalized services to the end
users. ==\> (<a href="CUMULATE" class="wikilink" title="more">more</a>
on CUMULATE)\n\n== Adaptive Shells ==\nADAPT2 supports multiple types of
adaptive shells (aka value-adding services) which are the key components
for providing adaptation and personalization. Adaptive shells stand
between a portal and learning objects coming from multiple content
servers. In contrast to the portal, which is not personalized, adaptive
shells can provide personalized access to learning objects. The ability
to insert various adaptive shells between the portal and the learning
content makes possible to explore various personalization approaches.
Examples of adaptive shells explored by our lab in the past include:\n\*
<a href="NavEx" class="wikilink" title="NavEx">NavEx</a> for
concept-based personalization\n\*
<a href="QuizGuide" class="wikilink" title="QuizGuide">QuizGuide</a> and
\[JavaGUide\]\] for topic-based personalization\n\*
<a href="Knowledge_Sea_II" class="wikilink"
title="Knowledge Sea II">Knowledge Sea II</a> for social navigation
support\n\*
<a href="Progressor" class="wikilink" title="Progressor">Progressor</a>
shells for a single-content social comparison\n\*
<a href="ProgressorPlus" class="wikilink"
title="Progressor+">Progressor+</a> shell for multi-type social
comparison\n\nSince 2015 most of our research uses
<a href="MasteryGrids" class="wikilink"
title="MasteryGrids">MasteryGrids</a> shell.
<a href="MasteryGrids" class="wikilink"
title="MasteryGrids">MasteryGrids</a> offers a flexible and customizable
interface for delivering and exploring personalized content access. It
combines knowledge-based personalization explored by
<a href="NavEx" class="wikilink" title="NavEx">NavEx</a> and
<a href="QuizGuide" class="wikilink" title="QuizGuide">QuizGuide</a>
with social navigation and comparison ideas explored by
<a href="Knowledge_Sea_II" class="wikilink"
title="Knowledge Sea II">Knowledge Sea II</a>,
<a href="Progressor" class="wikilink" title="Progressor">Progressor</a>,
and <a href="ProgressorPlus" class="wikilink"
title="Progressor+">Progressor+</a>.\n\n== Content Servers ==\nContent
servers provide learning objects for students to interact with. Content
servers that natively work with
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
include several systems developed by PAWS lab:
<a href="WebEx" class="wikilink" title="WebEx">WebEx</a>,
<a href="QuizPACK" class="wikilink" title="QuizPACK">QuizPACK</a>,
<a href="WADEIn" class="wikilink" title="c/jWADEIn">c/jWADEIn</a>,
<a href="SQLKnoT" class="wikilink" title="SQLKnoT">SQLKnoT</a>,
<a href="QuizJET" class="wikilink" title="QuizJET">QuizJET</a>,
<a href="PCEX" class="wikilink" title="PCEX">PCEX</a>.\nADAPT2 can also
use learning objects developed by many other research teams. There are
currently two ways to make interactive learning content usable in
ADAPT2. \n\* For unrestricted use, learning content server has to
implement with
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
content invocation protocol and CUMULATE knowledge reporting protocols.
Examples of of content servers that implement these protocols are [SQL
Tutor](http://ictg.cosc.canterbury.ac.nz:8000/) (University of
Canterbury, New Zealand),
[PCRS](https://mcs.utm.utoronto.ca/~pcrs/pcrs/) (University of Toronto),
and <a href="ACOS_server" class="wikilink" title="ACOS server">ACOS
server</a> (Aalto University).\n\n\* For the use in
<a href="MasteryGrids" class="wikilink"
title="MasteryGrids">MasteryGrids</a> interface only, a learning content
server has to implement [LTI
protocol](https://en.wikipedia.org/wiki/Learning_Tools_Interoperability)
for launching learning activities and reporting learner progress.
Examples of LTI-compatible learning content that are currently used in
courses supported by
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
are [CodeWorkout](https://codeworkout.cs.vt.edu/) (Virginia Tech) and
[DBQA](https://dl.acm.org/doi/abs/10.1145/3125659.3125688) (University
of St. Thomas).\n\n== ADAPT2 Protocols ==\n\nCommunication protocols
enable multiple components of
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
to work together in a coordinated way. A new component could be easily
integrated into the infrastructure as long as it communicates with other
components using these standardized protocols.\nTwo main groups of
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
protocols are \n\*
<a href="Content_Invocation_protocols" class="wikilink"
title="Content Invocation protocols">Content Invocation protocols</a>,
which enable a portal or an adaptive shell to call interactive learning
objects residing on various content servers\n\*
<a href="CUMULATE_protocol" class="wikilink"
title="User Modeling protocols">User Modeling protocols</a> for
reporting user activities and requesting the current state of their
knowledge from user-modeling servers.\n\n== PERSEUS
==\n<img src="Perseus.gif" title="PERSEUS" width="100" alt="PERSEUS" />\n<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a>
is a Personalization Service Engine. It provides adaptive support for
non-personalized (educational) hypermedia systems by abstracting content
presentation/aggregation from user modeling.
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a> protocols
are based on [RDF](http://en.wikipedia.org/wiki/Rdf) and [RSS
1.0](http://en.wikipedia.org/wiki/RSS_(file_format)#RSS_1.0). Although,
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a> was
initially developed for
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
framework, its data model permits seamless support of any other
hypermedia application. Currently
<a href="PERSEUS" class="wikilink" title="PERSEUS">PERSEUS</a> supports
social navigation, topic-based navigation, concept-based navigation, and
adaptive filtering techniques.\n\n==Standardization ==\nData models of
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
components are partially serialized as
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework). For
more information refer to <a href="ADAPT2_RDF_Binding" class="wikilink"
title="ADAPT2 RDF Binding">ADAPT<sup>2</sup> RDF Binding</a>.\n\n==
Contacts ==\n\*
<a href="User:peterb" class="wikilink" title=" Peter Brusilovsky"> Peter
Brusilovsky</a>\n\*
<a href="User:Myudelson" class="wikilink" title=" Michael V. Yudelson">
Michael V. Yudelson</a>\n\*
<a href="User:Sergey" class="wikilink" title=" Sergey Sosnovsky"> Sergey
Sosnovsky</a>
