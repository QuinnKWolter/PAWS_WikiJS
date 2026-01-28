---
title: "CUMULATE"
source_namespace: "ns_0"
source_filename: "CUMULATE.md"
---


[CUMULATE](/ns_0/cumulate)
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




<div align="right">

Kobsa, A. (2007) Generic User Modeling Systems In P. Brusilovsky, A.
Kobsa and W. Nejdl (Eds.),
The Adaptive Web. Methods and Strategies of Web Personalization (pp.
136-154). Berlin / Heidelberg: Springer.

</div>



#### Overview

[CUMULATE](/ns_0/cumulate) is
a centralized user modeling server built for the
<a href="ADAPT2" class="wikilink" title="ADAPT2">ADAPT<sup>2</sup></a>
architecture. It is mainly targeted at providing user modeling support
for adaptive educational hypermedia (AEH) systems.
[CUMULATE](/ns_0/cumulate)'s data
model consists of the following.
* users, groups of users, and group
membership links (syndicated from
<a href="Knowledge_Tree" class="wikilink"
title="Knowledge Tree">Knowledge Tree</a>)
* learning objects,
learning object providers (client applications)
* knowledge
components - concepts - grouped in learning domains
* learning object
metadata index - links between learning objects and corresponding
concepts
* user activity log - historical log of all reported user
interaction with learning objects
* assertions about user's knowledge
of concepts (\[concepts'\] knowledge)
* summaries of user's
interaction with learning objects, such as: number of attempts, percent
complete, etc. (\[learning objects'\]
progress)
[CUMULATE](/ns_0/cumulate)
implements several inference mechanisms to produce assertions about
user's knowledge and progress, including the following.
*
time-spent-reading (reading texts via
<a href="Knowledge_Sea_II" class="wikilink"
title="Knowledge Sea II">Knowledge Sea II</a> and
[AnnotatEd](/ns_0/annotated))
*
thresholded averaging (browsing examples via
[WebEx](/ns_0/webex) and exploring
expressions via
[WADEIn](/ns_0/wadein))
*
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="asymptotic assessment of user knowledge">asymptotic assessment of
user knowledge</a> (problem solving via
[QuizPACK](/ns_0/quizpack),
[QuizJET](/ns_0/quizjet), and
[SQLKnoT](/ns_0/sqlknot), which is
the main one deployed in our systems)
*
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink"
title="parametrized asymptotic assessment of user knowledge">parametrized
asymptotic assessment of user knowledge</a>
(<span style="color:maroon;">under development</span>)
* knowledge
tracing (<span style="color:maroon;">under consideration</span>)
*
<a href="Feature-Aware_Student_knowledge_Tracing_(FAST)"
class="wikilink"
title="Feature-Aware Student knowledge Tracing (FAST)">Feature-Aware
Student knowledge Tracing (FAST)</a> (<span style="color:maroon;">under
development</span>)

#### Modeling User's Knowledge

![**100**\|Evindence propagation in
CUMULATE](CUMULATE.evidence_propagation.png "100|Evindence propagation in CUMULATE")
[CUMULATE](/ns_0/cumulate)
models user's knowledge of concepts with respect to the following levels
of [Bloom's taxonomy](http://www.officeport.com/edu/blooms.htm).
*
knowledge - corresponds to reading tutorials or book chapters
(<a href="Knowledge_Sea_II" class="wikilink"
title="Knowledge Sea II">Knowledge Sea II</a>,
[AnnotatEd](/ns_0/annotated))
*
comprehension - reviewing examples, watching demos
([WebEx](/ns_0/webex),
[WADEIn](/ns_0/wadein) demo
mode)
* application - answering quiz questions
([QuizPACK](/ns_0/quizpack),
[QuizJET](/ns_0/quizjet),
[WADEIn](/ns_0/wadein) evaluation
mode)
* synthesis - constructing problem solutions
([SQLKnoT](/ns_0/sqlknot))
Upon
receipt of new information about user activity (interaction with a
learning object),
[CUMULATE](/ns_0/cumulate) first
verifies the integrity of the reported information (user is registered,
learning object provider is known and learning object exists, etc.).
Then, based on the learning object provider and result of interaction,
it is determined what inference mechanism to use and what [Bloom's
level](http://www.officeport.com/edu/blooms.htm) to affect.
[CUMULATE](/ns_0/cumulate) then
looks up the domain concepts for the learning object the user interacted
with and performs the update of the knowledge. Summaries of progress
with learning objects are updated as well. The process of updating user
model is called **evidence propagation** (see figure on the left).


<span style="color:red;">New!</span> Recent update to
[CUMULATE](/ns_0/cumulate) allows
learning object providers to skip learning object metadata lookup and
report changes in user's knowledge of domain concepts directly.

#### Entry Points and Protocols

[CUMULATE](/ns_0/cumulate)
has 3 major entry points:

# interface for reporting user interaction

with learning objects

# interface for reporting changes to user

knowledge of concepts in-the-raw
(<span style="color:red;">new</span>)

# interface for acquiring models

of user knowledge/progress as a whole or in part

To communicate with
these entry points, a Web-based personalized learning system has to use
a set of standard user modeling protocols known as
<a href="CUMULATE_protocol" class="wikilink"
title="CUMULATE protocols">CUMULATE protocols</a>.

==Publications==
<onlyinclude>
*
Zadorozhny, V.,
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
*
<a href="User:peterb" class="wikilink"
title="Brusilovsky, P.">Brusilovsky, P.</a>,
<a href="User:sergey" class="wikilink"
title="Sosnovsky, S. A.">Sosnovsky, S. A.</a>, and Shcherbinina, O.
(2005). **User Modeling in a Distributed E-Learning Architecture**.
Paper presented at the 10th International Conference on User Modeling
(UM 2005), Edinburgh, Scotland, UK, July 24-29, 2005.
[PDF](http://www2.sis.pitt.edu/%7Epeterb/papers/cumulateUM05.pdf)
[DOI](http://dx.doi.org/10.1007/11527886_50)
</onlyinclude>

#### See Also

* <a href="CUMULATE_RDF_Binding" class="wikilink"
title="CUMULATE RDF Binding">CUMULATE RDF Binding</a> - work in progress
on serializing part of
[CUMULATE](/ns_0/cumulate)'s data
model in
[RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)
*
<a href="CUMULATE_Usage_Logs" class="wikilink"
title="CUMULATE Usage Logs">CUMULATE Usage Logs</a> - part of the
[CUMULATE](/ns_0/cumulate)'s log
data the downloadable format
*
<a href="CUMULATE_user_and_domain_adaptive_user_modeling"
class="wikilink" title="Adaptation">Adaptation</a> of
[CUMULATE](/ns_0/cumulate)'s
model inference to accommodate student's individual differences as well
as the differences in complexity of problem-solving exercises.
*
<a href="Blending_layers_of_CUMULATE&#39;s_user_model" class="wikilink"
title="Blending layers of CUMULATE&#39;s user model">Blending layers of
CUMULATE's user model</a> - a stream of work targeted at combining
layers of
[CUMULATE](/ns_0/cumulate)'s user
model (e.g. problem-solving and example-browsing levels) to improve
predictive validity of the modeling.

#### Contacts

<a href="User:Myudelson" class="wikilink" title=" Michael V. Yudelson">
Michael V. Yudelson</a>
