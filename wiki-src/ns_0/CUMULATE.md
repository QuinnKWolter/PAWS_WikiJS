\n<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>
(Centralized User Modeling Architecture for TEaching) is a central user
modeling server

> designed to provide user modeling functionality to a student-adaptive
> educational system. It collects evidence (events) about student
> learning from multiple servers that interact with the student. It
> stores students' activities and infers their learning characteristics,
> which are the basis for an individual adaptation to them. ... External
> and internal inference agents process the flow of events and update
> the values in the inference model of the server. Each inference agent
> is responsible for maintaining a specific property in the inference
> model, such as the current motivation level of the student or the
> student's current level of knowledge for each course topic...

\n

<div align="right">

Kobsa, A. (2007) Generic User Modeling Systems In P. Brusilovsky, A.
Kobsa and W. Nejdl (Eds.),  
The Adaptive Web. Methods and Strategies of Web Personalization (pp.
136-154). Berlin / Heidelberg: Springer.

</div>

\n\n== Overview
==\n<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a> is
a centralized user modeling server built for the
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
architecture. It is mainly targeted at providing user modeling support
for adaptive educational hypermedia (AEH) systems.
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>'s data
model consists of the following.\n\* users, groups of users, and group
membership links (syndicated from
<a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a>)\n\* learning objects,
learning object providers (client applications)\n\* knowledge
components - concepts - grouped in learning domains\n\* learning object
metadata index - links between learning objects and corresponding
concepts\n\* user activity log - historical log of all reported user
interaction with learning objects\n\* assertions about user's knowledge
of concepts (\[concepts'\] knowledge)\n\* summaries of user's
interaction with learning objects, such as: number of attempts, percent
complete, etc. (\[learning objects'\]
progress)\n<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>
implements several inference mechanisms to produce assertions about
user's knowledge and progress, including the following.\n\*
time-spent-reading (reading texts via
<a href="Knowledge_Sea_II" class="wikilink"
title="Knowledge Sea II">Knowledge Sea II</a> and
<a href="AnnotatEd" class="wikilink" title="AnnotatEd">AnnotatEd</a>)\n\*
thresholded averaging (browsing examples via
<a href="WebEx" class="wikilink" title="WebEx">WebEx</a> and exploring
expressions via
<a href="WADEIn" class="wikilink" title="WADEIn">WADEIn</a>)\n\*
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="asymptotic assessment of user knowledge">asymptotic assessment of
user knowledge</a> (problem solving via
<a href="QuizPACK" class="wikilink" title="QuizPACK">QuizPACK</a>,
<a href="QuizJET" class="wikilink" title="QuizJET">QuizJET</a>, and
<a href="SQLKnoT" class="wikilink" title="SQLKnoT">SQLKnoT</a>, which is
the main one deployed in our systems)\n\*
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink"
title="parametrized asymptotic assessment of user knowledge">parametrized
asymptotic assessment of user knowledge</a>
(<span style="color:maroon;">under development</span>)\n\* knowledge
tracing (<span style="color:maroon;">under consideration</span>)\n\*
<a href="Feature-Aware_Student_knowledge_Tracing_(FAST)"
class="wikilink"
title="Feature-Aware Student knowledge Tracing (FAST)">Feature-Aware
Student knowledge Tracing (FAST)</a> (<span style="color:maroon;">under
development</span>)\n\n== Modeling User's Knowledge
==\n![**100**\|Evindence propagation in
CUMULATE](CUMULATE.evidence_propagation.png "100|Evindence propagation in CUMULATE")\n<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>
models user's knowledge of concepts with respect to the following levels
of [Bloom's taxonomy](http://www.officeport.com/edu/blooms.htm).\n\*
knowledge - corresponds to reading tutorials or book chapters
(<a href="Knowledge_Sea_II" class="wikilink"
title="Knowledge Sea II">Knowledge Sea II</a>,
<a href="AnnotatEd" class="wikilink" title="AnnotatEd">AnnotatEd</a>)\n\*
comprehension - reviewing examples, watching demos
(<a href="WebEx" class="wikilink" title="WebEx">WebEx</a>,
<a href="WADEIn" class="wikilink" title="WADEIn">WADEIn</a> demo
mode)\n\* application - answering quiz questions
(<a href="QuizPACK" class="wikilink" title="QuizPACK">QuizPACK</a>,
<a href="QuizJET" class="wikilink" title="QuizJET">QuizJET</a>,
<a href="WADEIn" class="wikilink" title="WADEIn">WADEIn</a> evaluation
mode)\n\* synthesis - constructing problem solutions
(<a href="SQLKnoT" class="wikilink" title="SQLKnoT">SQLKnoT</a>)\nUpon
receipt of new information about user activity (interaction with a
learning object),
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a> first
verifies the integrity of the reported information (user is registered,
learning object provider is known and learning object exists, etc.).
Then, based on the learning object provider and result of interaction,
it is determined what inference mechanism to use and what [Bloom's
level](http://www.officeport.com/edu/blooms.htm) to affect.
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a> then
looks up the domain concepts for the learning object the user interacted
with and performs the update of the knowledge. Summaries of progress
with learning objects are updated as well. The process of updating user
model is called **evidence propagation** (see figure on the left).  
\n\n<span style="color:red;">New!</span> Recent update to
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a> allows
learning object providers to skip learning object metadata lookup and
report changes in user's knowledge of domain concepts directly.\n\n==
Entry Points and Protocols
==\n<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>
has 3 major entry points:\n# interface for reporting user interaction
with learning objects\n# interface for reporting changes to user
knowledge of concepts in-the-raw
(<span style="color:red;">new</span>)\n# interface for acquiring models
of user knowledge/progress as a whole or in part\n\nTo communicate with
these entry points, a Web-based personalized learning system has to use
a set of standard user modeling protocols known as
<a href="CUMULATE_protocol" class="wikilink"
title="CUMULATE protocols">CUMULATE protocols</a>.\n\n==Publications==\n<onlyinclude>\n\*
Zadorozhny, V.,
<a href="User:myudelson" class="wikilink" title="Yudelson, M.">Yudelson,
M.</a>, and <a href="User:peterb" class="wikilink"
title="Brusilovsky, P.">Brusilovsky, P.</a> (2008) **A Framework for
Performance Evaluation of User Modeling Servers for Web Applications**.
Web Intelligence and Agent Systems 6(2), 175-191.
[DOI](http://dx.doi.org/10.3233/WIA-2008-0136) \n\*
<a href="User:myudelson" class="wikilink" title="Yudelson, M.">Yudelson,
M.</a>, <a href="User:peterb" class="wikilink"
title="Brusilovsky, P.">Brusilovsky, P.</a>, and Zadorozhny, V. (2007)
**A user modeling server for contemporary adaptive hypermedia: An
evaluation of the push approach to evidence propagation**. In Conati,
C., McCoy, K. F., and Paliouras, G. Eds., User Modeling, volume 4511 of
Lecture Notes in Computer Science, pp 27-36. Springer, 2007.
[PDF](http://www.pitt.edu/~mvy3/assets/YudelsonUM2007.pdf)
[DOI](http://dx.doi.org/10.1007/978-3-540-73078-1_6)\n\*
<a href="User:peterb" class="wikilink"
title="Brusilovsky, P.">Brusilovsky, P.</a>,
<a href="User:sergey" class="wikilink"
title="Sosnovsky, S. A.">Sosnovsky, S. A.</a>, and Shcherbinina, O.
(2005). **User Modeling in a Distributed E-Learning Architecture**.
Paper presented at the 10th International Conference on User Modeling
(UM 2005), Edinburgh, Scotland, UK, July 24-29, 2005.
[PDF](http://www2.sis.pitt.edu/%7Epeterb/papers/cumulateUM05.pdf)
[DOI](http://dx.doi.org/10.1007/11527886_50)\n</onlyinclude>\n\n== See
Also ==\n\* <a href="CUMULATE_RDF_Binding" class="wikilink"
title="CUMULATE RDF Binding">CUMULATE RDF Binding</a> - work in progress
on serializing part of
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>'s data
model in
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)\n\*
<a href="CUMULATE_Usage_Logs" class="wikilink"
title="CUMULATE Usage Logs">CUMULATE Usage Logs</a> - part of the
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>'s log
data the downloadable format\n\*
<a href="CUMULATE_user_and_domain_adaptive_user_modeling"
class="wikilink" title="Adaptation">Adaptation</a> of
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>'s
model inference to accommodate student's individual differences as well
as the differences in complexity of problem-solving exercises.\n\*
<a href="Blending_layers_of_CUMULATE&#39;s_user_model" class="wikilink"
title="Blending layers of CUMULATE&#39;s user model">Blending layers of
CUMULATE's user model</a> - a stream of work targeted at combining
layers of
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>'s user
model (e.g. problem-solving and example-browsing levels) to improve
predictive validity of the modeling.\n\n== Contacts
==\n<a href="User:Myudelson" class="wikilink" title=" Michael V. Yudelson">
Michael V. Yudelson</a>
