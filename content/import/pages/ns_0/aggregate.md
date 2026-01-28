---
title: "Aggregate"
source_namespace: "ns_0"
source_filename: "Aggregate.md"
---

![Aggregate Architecture](../../media/images/other/Arch_v2.png)

We
developed an adaptive social learning architecture Aggregate to support
<a href="Mastery_Grids_Interface" class="wikilink"
title="Mastery Grids Interface">Mastery Grids Interface</a>. We design
this architecture to integrate content from diverse sources. The
explanation of the procedures and links to associated resources are
given below.

* <a href="Mastery_Grids_Interface" class="wikilink"
title="Mastery Grids Interface">Mastery Grids Interface</a> receives all
the information to display (this is course structure, links to content
and progress levels of the learner and the group of learners) from
services hosted in Aggregate (a in the diagram). This information is
passed in JSON format.

* To let Mastery Grids know the level of
progress of the learners in the topics and the content, Aggregates call
services from a User Model (UM in the figure). See point b) in the
figure. These services are documented in [User State
Protocol](https://github.com/PAWSLabUniversityOfPittsburgh/mastery-grids/blob/master/documentation/User_State_protocol.pdf)

*
The figure shows several different Content apps (QuizJet, QuizPet,
Webex, etc.). Each of these applications are integrated in 2 ways:
**
The content application needs to log information of the learner activity
within the content to the User Model (letter c in the diagram).
Currently, the content applications are using our ADAPT2
<a href="CUMULATE_protocol" class="wikilink"
title="CUMULATE protocol">CUMULATE protocol</a>.
** The content
application provides a service to list all the available content. This
service implement the [content brokering
specification](https://github.com/PAWSLabUniversityOfPittsburgh/mastery-grids/blob/master/documentation/Content_Brokering_API_2016_01_21.pdf),
which defines a JSON-format protocol to allow external applications to
discover content. Both Aggregate and the User Model use the content
brokering to register new content.

Several content application and
their respective content brokering are implemented in [ACOS
server](http://acos.cs.hut.fi/).


#### Associated resources

*
[Mastery Grids
repository](https://github.com/PAWSLabUniversityOfPittsburgh/mastery-grids)
(contains aggregate, mastery grids interface, documentation and course
authoring tool)
* [User State Services
repository](https://github.com/PAWSLabUniversityOfPittsburgh/AggregateUMServices)
*
<a href="CUMULATE" class="wikilink"
title="user modeling specification">user modeling specification</a>

#### Content application resources

*
<a href="Smart_Content" class="wikilink" title="Smart content">Smart
content</a> : provides an explanation of content applications
* [ACOS
server](http://acos.cs.hut.fi) : provides details of ACOS
infrastructure, content and protocols
* [QuizJet
repository](https://github.com/PAWSLabUniversityOfPittsburgh/quizjet)
*
[QuizPet
repository](https://github.com/PAWSLabUniversityOfPittsburgh/quizpet)
*
[Annotated Examples (Webex)
repository](https://github.com/PAWSLabUniversityOfPittsburgh/annotated-examples)
*
[Educational Videos
repository](https://github.com/PAWSLabUniversityOfPittsburgh/educational-videos)
