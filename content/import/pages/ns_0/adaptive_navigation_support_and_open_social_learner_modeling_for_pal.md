---
title: "Adaptive Navigation Support and Open Social Learner Modeling for PAL"
source_namespace: "ns_0"
source_filename: "Adaptive_Navigation_Support_and_Open_Social_Learner_Modeling_for_PAL.md"
---

## Overview



The goal of this project is to leverage the power of
<a href="open_social_learner_modeling" class="wikilink"
title="open social learner modeling">open social learner modeling</a>
and <a href="adaptive_navigation_support" class="wikilink"
title="adaptive navigation support">adaptive navigation support</a> in
the context of the envisioned Personalized Assistant for Learning (PAL).
The project is supported by the [Advanced Distributed Learning
Initiative](http://adlnet.gov) contract W911QY13C0032. This is a joint
project with [Learning + Technology](http://cs.aalto.fi/en/research/)
research group at Aalto University. The LeTech group at Aalto University
focuses on developing several kinds of [smart learning content for Java
and Python programming](http://acos.cs.hut.fi/) that are compatible with
the project architecture
[Aggregate](/ns_0/aggregate).

The
project focuses on both exploration and implementation of adaptive
navigation support and open social learner modeling and pursues three
directions of work:

* Exploring open social learner modeling
interface for diverse learning content
* Enhancing algorithms for
personalized guidance using knowledge-based and social approaches
*
Developing architectural solutions and authoring tools to support open
social learner modeling

We have prepared fliers for quickly getting
to know our systems:
* For researchers or system developers
(designers), please check
[here](/ns_0/MediaMGFlierpdf).
*
For teachers or educators, please check the flier for your interested
domain: <a href="Media:MasteryGridsFlierJava.pdf" class="wikilink"
title="Java">Java</a>,
<a href="Media:MasteryGridsFlierPythonNew.pdf" class="wikilink"
title="Python">Python</a>, or
<a href="Media:MasteryGridsFlierSQL.pdf" class="wikilink"
title="SQL">SQL</a>.

#### Open Social Learner Model Interface: Mastery Grids

{\|
\|valign="top" \| ![**100**\|Mastery Grids
Interface](Mg_1.png "100|Mastery Grids Interface")
\|valign="top" \|
<a href="Mastery_Grids_Interface" class="wikilink"
title="Mastery Grids">Mastery Grids</a> is a flexible portal to access
multiple types of learning content through a personalized interface
based on Open Social Learner Modeling (OSLM)
<a href="Mastery_Grids_Interface" class="wikilink"
title="Mastery Grids Interface">Mastery Grids Interface</a>. It offers a
multi-facet social comparison, open learner modeling, and adaptive
navigation support to help students access multiple kinds of smart
learning content. With Mastery Grids, instructors could re-use one of
the existing installations (see below) or create their own installations
by organizing their courses info a sequence of topics and selecting most
relevant smart content items of multiple types for each topic. There is
a drag-and-drop authoring system to support instructors in creating
their own courses.

Mastery Grids is based on communication-based
personalization infrastructure ADAPT2 (formerly Knowledge Tree) and
supported by adaptive social learning framework
[Aggregate](/ns_0/aggregate).
ADAPT2 supports smart content invocation with single sign-on, extensive
data collection, and student modeling. Aggregate adds several kinds of
open student modeling, social comparison, and recommendation. In detail,
Mastery Grids presents and compares user learning progress and knowledge
level using colored grids, tracks user activities with learning content,
and provides flexible user-centered navigation across different content
levels (e.g. topic, question) and different content types (e.g. problem,
example)

* <a href="Mastery_Grids_Interface" class="wikilink"
title="More about Mastery Grids interface">More about Mastery Grids
interface</a>
* [YouTube demo of Mastery Grids
interface](https://www.youtube.com/watch?v=76YLR2VY2QE)
* [An
interactive demo of Mastery Grids
interface](http://adapt2.sis.pitt.edu/um-vis-adl/index.html?usr=adl01&grp=ADL&sid=test&cid=13&data-top-n-grp=5&def-val-rep-lvl-id=p&def-val-res-id=AVG&ui-tbar-rep-lvl-vis=0&ui-tbar-topic-size-vis=0)
\|}

==
Architecture: Aggregate==
{\|
\|valign="top" \| ![**100**\|Aggregate
Architecture](arch_v2.png "100|Aggregate Architecture")
\|valign="top"
\| We developed an adaptive social learning architecture
[Aggregate](/ns_0/aggregate) to
support Mastery Grids interface.
[Aggregate](/ns_0/aggregate) is
an extension of our original
[ADAPT2](/ns_0/adapt2)
architecture. On the top of
[ADAPT2](/ns_0/adapt2) ,
[Aggregate](/ns_0/aggregate)
architecture supports several kinds of open student modeling, social
comparison, content brokering, and recommendation services. The
architecture fulfills a major objective, portability, which is the
ability to be integrated to other systems with little set up and
modification. The architecture is modular and includes different
software components.

*
<a href="ADAPT2" class="wikilink" title=" More about ADAPT2"> More about
ADAPT2</a>
*
<a href="Aggregate" class="wikilink" title=" More about Aggregate"> More
about Aggregate</a>
\|}

#### Learner Modeling

{\|
\|valign="top"
\|
![**100**\|CUMULATE](../../media/images/other/CUMULATE.evidence_propagation.png)
\|valign="center"
\| We have developed
[CUMULATE](/ns_0/cumulate), a
centralized user modeling server built for the
[ADAPT2](/ns_0/adapt2)
architecture, to provide user modeling support for adaptive educational
hypermedia (AEH) systems. CUMULATE allows flexible learner models to
infer learner knowledge. Mastery Grids's architecture is supported by
CUMULATE and thus it also supports flexible learner models. The
explanation of the communication between the interface and learner model
can be found in
[Aggregate](/ns_0/aggregate). We
have proposed and implemented different learner models over past years,
including
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="asymptotic assessment of user knowledge">asymptotic assessment of
user knowledge</a> which is the main one currently deployed in our
systems, and <a href="Feature-Aware_Student_knowledge_Tracing_(FAST)"
class="wikilink"
title="Feature-Aware Student knowledge Tracing (FAST)">Feature-Aware
Student knowledge Tracing (FAST)</a> which is our new learner model
proposed in 2014 with state-of-the-art predictive performance. We have
also explored different aspects to improve learner modeling, including
reducing the content model, better evaluation for practitioners and
applying network (graph) analysis.

*
<a href="Learner_Modeling" class="wikilink"
title="More about Learner Modeling">More about Learner Modeling</a>
*
<a href="CUMULATE" class="wikilink" title="More about CUMULATE">More
about CUMULATE</a>
*
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="More about asymptotic assessment of user knowledge">More about
asymptotic assessment of user knowledge</a>
*
<a href="Feature-Aware_Student_knowledge_Tracing_(FAST)"
class="wikilink"
title="More about Feature-Aware Student knowledge Tracing (FAST)">More
about Feature-Aware Student knowledge Tracing (FAST)</a>
\|}

#### Recommendation

{\|
\|valign="top" \|
![**100**\|Personalization](../../media/images/other/StarRecommendation.png)
\|valign="top"
\| There are multiple personalization approaches, that are developed and
researched in our system. In the form of recommendations, we have
various methods in different levels for recommending learning material
to students. Two major approached for recommending resources are
reactive and proactive recommendations. In the reactive approach, the
recommender system activates in reaction to the student's activity, e.g.
if the student fails in solving a quiz, the reactive recommender system
recommends related examples to this student to help her understand the
skills required to solve that quiz. The pro-active recommender system,
proactively suggests learning materials to the students.
<a href="Learning_Recommendation" class="wikilink"
title="==&gt; more">==&gt; more</a>


\|}

#### Educational Data Mining

{\|
\|valign="top" \| ![**100**\|Educational Data
Mining](TensorFactorization.png "100|Educational Data Mining")
\|valign="top"
\| In this part of the project, we aim to make sense of data from
Mastery Grids system, including logs of student attempts. The goal in
this part includes understanding students' learning patterns and its
relationship with students' behavioral traits, predicting students'
performance, modeling student knowledge, and discovering the content
model. These tasks eventually help us in providing a better service to
both instructors and students.
<a href="Educational_Data_Mining" class="wikilink"
title="==&gt; more">==&gt; more</a>


\|}

#### Smart Content

{\|
\|valign="top" \| ![**100**\|Smart Content (Animated
Examples)](AnimatedExamples.jpg "100|Smart Content (Animated Examples)")
\|valign="top"
\| Mastery Grids supports and provides multiple types of learning
materials. It has been applied in three domains (Java, SQL, and Python)
as a supplementary E-learning system for undergraduate and graduate
level programming and database classes since 2013. We have developed
different content applications (e.g.,
[QuizJET](/ns_0/quizjet),
[QuizPET](/ns_0/quizpet),
[WebEx](/ns_0/webex)) and authoring
tools (e.g., <a href="Content_Authoring_Tools" class="wikilink"
title="Content Authoring Tools">Content Authoring Tools</a>,
<a href="Course_Authoring_Tool" class="wikilink"
title="Course Authoring Tool">Course Authoring Tool</a>,
<a href="Group_Authoring_Tool" class="wikilink"
title="Group Authoring Tool">Group Authoring Tool</a>) for accessing and
authoring such contents. In each learning domain, courses are organized
by topics and different types of learning contents are arranged under
each topic. Learning contents contain problems (quizzes), parson
problems, annotated examples, and animated examples collected from
experienced course teachers, textbooks or domain experts.
<a href="Smart_Content" class="wikilink" title="==&gt; more">==&gt;
more</a>
\|}

#### Authoring Tools

{\|
\|valign="top" \|
![**100**\|Annotated Example Content
Authoring](ExampleAuthoringModify.jpg "100|Annotated Example Content Authoring")
\|valign="top"
\| We have developed four major types of authoring tools for the
project: 1) Content Authoring Tools for creating different kinds of
smart learning content, 2) Course Authoring Tool for creating adaptive
courses that use the content, 3) Group Authoring Tool for managing users
and groups, as well as 4) the portal to access different authoring
tools.

* <a href="Authoring_Tools" class="wikilink"
title="More about Authoring Tools">More about Authoring Tools</a>
*
<a href="Content_Authoring_Tools" class="wikilink"
title="More about Content Authoring Tools">More about Content Authoring
Tools</a>
* <a href="Course_Authoring_Tool" class="wikilink"
title="More about Course Authoring Tool">More about Course Authoring
Tool</a>
* <a href="Group_Authoring_Tool" class="wikilink"
title="More about Group Authoring Tool">More about Group Authoring
Tool</a>
* <a href="Authoring_Tool_Portal" class="wikilink"
title="More about Authoring Tool Portal">More about Authoring Tool
Portal</a>
\|}

#### Open Source

Software sources and
documentations are in GitHub [PAWSLabUniversityOfPittsburgh
organization](https://github.com/PAWSLabUniversityOfPittsburgh), and
[acos-server organization](https://github.com/acos-server/).
* The
Mastery Grids Interface, back-end Aggregate and documentation can be
found
[here](https://github.com/PAWSLabUniversityOfPittsburgh/mastery-grids).

* User model services can be found in
[here](https://github.com/PAWSLabUniversityOfPittsburgh/AggregateUMServices).
*
QuizJET Interface, Authoring Tool, Content Brokering and documentations
can be found
[here](https://github.com/PAWSLabUniversityOfPittsburgh/quizjet).
*
QuizPET Interface, Authoring Tool, Content Brokering and documentations
can be found
[here](https://github.com/PAWSLabUniversityOfPittsburgh/quizpet).
*
Parson Problem Authoring Tool can be found
[here](https://github.com/acos-server/acos-jsparsons-generator).
*
Annotated Examples Interface, Authoring Tool, Content Brokering and
documentations can be found
[here](https://github.com/PAWSLabUniversityOfPittsburgh/annotated-examples).
*
Animated Examples Authoring Tool can be found
[here](https://github.com/acos-server/acos-jsvee-transpiler-python).
*
Videos User Interface, Authoring Tool, Content Brokering and
documentations can be found
[here](https://github.com/PAWSLabUniversityOfPittsburgh/educvideos)

#### Publications

* Gonzalez-Brenes, J. P., Huang, Y., and Brusilovsky,
P. (2013) FAST: Feature-Aware Student Knowledge Tracing. In: Proceedings
of NIPS 2013 Workshop on Data Driven Education, Lake Tahoe, NV, December
10, 2013, ([paper](http://d-scholarship.pitt.edu/20353/))
* Hosseini,
R. and Brusilovsky, P. (2013) JavaParser: A Fine-Grain Concept Indexing
Tool for Java Problems. In: Proceedings of The First Workshop on
AI-supported Education for Computer Science (AIEDCS) at the 16th Annual
Conference on Artificial Intelligence in Education, AIED 2013, Memphis,
TN, USA, July 13, 2013, pp. 60-63.
([paper](https://d-scholarship.pitt.edu/secure/26270/1/AIED2013-workshop-camera_ready_version.pdf))
([presentation](http://www.slideshare.net/RoyaHosseini1/java-parser-a-fine-grained-indexing-tool-and-its-application))
*
Hosseini, R., Brusilovsky, P., and Guerra, J. (2013) Knowledge
Maximizer: Concept-based Adaptive Problem Sequencing for Exam
Preparation. In: Proceedings of the 16th International Conference on
Artificial Intelligence in Education (AIED 2013), Memphis, USA, pp.
848-851.
([paper](https://d-scholarship.pitt.edu/secure/26271/4/AIED2013-camera-ready-Knowledge_maximizer_.pdf))
([poster](http://www.slideshare.net/RoyaHosseini1/aied-2013))
*
Brusilovsky, P., Baishya, D., Hosseini, R., Guerra, J., and Liang, M.
(2013) KnowledgeZoom for Java: A Concept-Based Exam Study Tool with a
Zoomable Open Student Model. In: Proceedings of 2013 IEEE 13th
International Conference on Advanced Learning Technologies, Beijing,
China, July 15-18, 2013, pp. 275-279.
([paper](http://dx.doi.org/10.1109/ICALT.2013.86))
([presentation](http://www.slideshare.net/RoyaHosseini1/kowledge-zoom-michelle-48735584))
*
Brusilovsky, P. (2014) Addictive Links: Engaging Students through
Adaptive Navigation Support and Open Social Student Modeling (Keynote
talk). In: Proceedings of WWW 2014 Workshop on Web-based Education
Technologies, Seoul, Korea, April 8, 2014.
([presentation](http://www.slideshare.net/pbrusilovsky/addictive-links-keynote-talk-at-www-2014-workshop))
*
Huang, Y., Xu, Y., and Brusilovsky, P. (2014) Doing More with Less:
Student Modeling and Performance Prediction with Reduced Content Models.
In: V. Dimitrova, et al. (eds.) Proceedings of 22nd Conference on User
Modeling, Adaptation and Personalization (UMAP 2014), Aalborg, Denmark,
July 7-11, 2014, Springer Verlag, pp. 338-349.
([presentation](http://www.slideshare.net/pbrusilovsky/umap-v1)[paper](http://link.springer.com/chapter/10.1007%2F978-3-319-08786-3_30))
*
Hosseini, R. and Brusilovsky, P. (2014) Example-Based Problem Solving
Support Using concept Analysis of Programming Content. In: S.
Trausan-Matu, K. Boyer, M. Crosby and K. Panourgia (eds.) Proceedings of
12th International Conference on Intelligent Tutoring Systems (ITS
2014), Honolulu, HI, USA, June 5-9, 2014, Springer International
Publishing, pp. 683-685.
([paper](https://d-scholarship.pitt.edu/secure/26268/1/CameraReady_ITS2014_paper.pdf))
([presentation](http://www.slideshare.net/RoyaHosseini1/presentation-48735557))
*
Hosseini, R., Vihavainen, A., and Brusilovsky, P. (2014) Exploring
Problem Solving Paths in a Java Programming Course. In: Proceedings of
Psychology of Programming Interest Group Annual Conference, PPIG 2014,
Brighton, UK, June 25-27, 2014, pp. 65-76.
([paper](https://d-scholarship.pitt.edu/secure/26272/1/PPIG_2014_camera_ready.pdf))
([presentation](http://www.slideshare.net/RoyaHosseini1/ppig2014-problem-solvingpaths))
*
Huang, Y., González-Brenes, J. P., and Brusilovsky, P. (2014) General
Features in Knowledge Tracing to Model Multiple Subskills, Temporal Item
Response Theory, and Expert Knowledge. In: J. Stamper, Z. Pardos, M.
Mavrikis and B. M. McLaren (eds.) Proceedings of the 7th International
Conference on Educational Data Mining (EDM 2014), London, UK, July 4-7,
2014, pp. 84-91. (First two authors contributed equally. Nominated for
Best Paper Award)
([presentation](http://www.slideshare.net/huangyun/fast-presentation-48711687)[paper](http://educationaldatamining.org/EDM2014/uploads/procs2014/long%20papers/84_EDM-2014-Full.pdf)[tutorial](http://www.slideshare.net/huangyun/2015edm-featureaware-student-knowledge-tracing-tutorial)
[code](http://ml-smores.github.io/fast/))
* Khajah, M. M., Huang, Y.,
González-Brenes, J. P., Mozer, M. C., and Brusilovsky, P. (2014)
Integrating Knowledge Tracing and Item Response Theory: A Tale of Two
Frameworks. In: I. Cantador, M. Chi, R. Farzan and R. Jäschke (eds.)
Proceedings of Workshop on Personalization Approaches in Learning
Environments (PALE 2014) at the 22th International Conference on User
Modeling, Adaptation, and Personalization, UMAP 2014, Aalborg, Denmark,
July 11, 2014, CEUR, pp. 7-12. (First three authors contributed equally)
([presentation](http://www.slideshare.net/huangyun/pale-public-slideshare)[paper](http://ceur-ws.org/Vol-1181/pale2014_paper_01.pdf)).
*
Yudelson, M., Hosseini, R., Vihavainen, A., and Brusilovsky, P. (2014)
Investigating Automated Student Modeling in a Java MOOC. In: J. Stamper,
Z. Pardos, M. Mavrikis and B. M. McLaren (eds.) Proceedings of the 7th
International Conference on Educational Data Mining (EDM 2014), London,
UK, July 4-7, 2014, pp. 261-264.
([paper](https://d-scholarship.pitt.edu/secure/26273/1/EDM2014YudelsonHVB_camready.pdf))
([presentation](http://www.slideshare.net/RoyaHosseini1/edm2014-investigating-automated-student-modeling-in-a-java-mooc))
*
Sahebi, S., Huang, Y., and Brusilovsky, P. (2014) Parameterized
Exercises in Java Programming: Using Knowledge Structure for Performance
Prediction. In: Proceedings of The second Workshop on AI-supported
Education for Computer Science (AIEDCS) at 12th International Conference
on Intelligent Tutoring Systems ITS 2014, Honolulu, Hawaii, June 6 2014.
([paper](http://d-scholarship.pitt.edu/21915/))([presentation](http://www.slideshare.net/chagh/parameterized-exercises-in-java-programming-using-knowledge-structure-for-performance-prediction))
*
Sahebi, S., Huang, Y., and Brusilovsky, P. (2014) Predicting Student
Performance in Solving Parameterized Exercises. In: S. Trausan-Matu, K.
Boyer, M. Crosby and K. Panourgia (eds.) Proceedings of 12th
International Conference on Intelligent Tutoring Systems (ITS 2014),
Honolulu, HI, USA, June 5-9, 2014, Springer International Publishing,
pp. 496-503, ([paper](http://d-scholarship.pitt.edu/21916/))
([presentation](http://www.slideshare.net/chagh/its14-pitttemplate))
*
Guerra, J., Sahebi, S., Lin, Y.-R., and Brusilovsky, P. (2014) The
Problem Solving Genome: Analyzing Sequential Patterns of Student Work
with Parameterized Exercises. In: J. Stamper, Z. Pardos, M. Mavrikis and
B. M. McLaren (eds.) Proceedings of the 7th International Conference on
Educational Data Mining (EDM 2014), London, UK, July 4-7, 2014, pp.
153-160
([presentation](http://www.slideshare.net/huangyun/guerra-the-problemsolvinggenome)[paper](http://educationaldatamining.org/EDM2014/uploads/procs2014/long%20papers/153_EDM-2014-Full.pdf))

* Loboda, T., Guerra, J., Hosseini, R., and Brusilovsky, P. (2014)
Mastery Grids: An Open Source Social Educational Progress Visualization.
In: S. de Freitas, C. Rensing, P. J. Muñoz Merino and T. Ley (eds.)
Proceedings of 9th European Conference on Technology Enhanced Learning
(EC-TEL 2014), Graz, Austria, September 16-19, 2014 (Best paper award).
([paper](http://link.springer.com/chapter/10.1007%2F978-3-319-11200-8_18#page-1))
([presentation](http://www.slideshare.net/pbrusilovsky/ectel2014-mg))
*
Brusilovsky, P., Edwards, S., Kumar, A., Malmi, L., Benotti, L., Buck,
D., Ihantola, P., Prince, R., Sirkiä, T., Sosnovsky, S., Urquiza, J.,
Vihavainen, A., and Wollowski, M. (2014) Increasing Adoption of Smart
Learning Content for Computer Science Education. In: Proceedings of
Proceedings of the Working Group Reports of the 2014 on Innovation &
Technology in Computer Science Education Conference, Uppsala, Sweden,
ACM, pp. 31-57. ([paper](http://dx.doi.org/10.1145/2713609.2713611))
*
Gonzalez-Brenes, J. P., Huang, Y. (2014) The White Method: Towards
Automatic Evaluation Metrics for Adaptive Tutoring Systems. In:
Proceedings of NIPS 2014 Workshop on Human Propelled Machine Learning,
Montreal, Canada, December 13, 2014
([paper](http://d-scholarship.pitt.edu/26061/))
* Huang, Y.,
González-Brenes, J. P., and Brusilovsky, P. (2015) The FAST toolkit for
Unsupervised Learning of HMMs with Features. In: The Machine Learning
Open Source Software workshop at the 32nd International Conference on
Machine Learning (ICML-MLOSS 2015), Lille, France July 10, 2015.
([paper](http://d-scholarship.pitt.edu/26043/)[code](http://mloss.org/software/view/609/))
*
Huang, Y., González-Brenes, J. P., Kumar, R., Brusilovsky, P. (2015) A
Framework for Multifaceted Evaluation of Student Models. In: Proceedings
of the 8th International Conference on Educational Data Mining (EDM
2015), Madrid, Spain, pp. 203-210.
([paper](http://www.educationaldatamining.org/EDM2015/uploads/papers/paper_164.pdf))
([presentation](http://www.slideshare.net/huangyun/2015edm-a-framework-for-multifaceted-evaluation-of-student-models-polygon))
*
Huang, Y., González-Brenes, J. P., Brusilovsky, P. (2015) Challenges of
Using Observational Data to Determine the Importance of Example Usage.
In: Proceedings of the 17th International Conference on Artificial
Intelligence in Education (AIED 2015), Madrid, Spain, pp. 633-637.
([paper](http://d-scholarship.pitt.edu/26056/))
* Gonzalez-Brenes, J.
P., Huang, Y. (2015) Your model is predictive— but is it useful?
Theoretical and Empirical Considerations of a New Paradigm for Adaptive
Tutoring Evaluation. In: Proceedings of the 8th International Conference
on Educational Data Mining (EDM 2015), Madrid, Spain, pp. 187-194.
([paper](http://d-scholarship.pitt.edu/26046/)
[presentation](http://www.slideshare.net/huangyun/2015-edm-leopard-for-adaptive-tutoring-evaluation))
*
Gonzalez-Brenes, J. P., Huang, Y. The Leopard Framework: Towards
understanding educational technology interventions with a Pareto
Efficiency Perspective. In: The ICML 2015 Workshop on Machine Learning
for Education (ICML 2015), Lille, France, 2015.
([paper](https://dsp.rice.edu/sites/dsp.rice.edu/files/leopard_evaluation(1).pdf))
*
Gonzalez-Brenes, J. P., Huang, Y. Using Data from Real and Simulated
Learners to Evaluate Adaptive Tutoring Systems. In: 2nd AIED Workshop on
Simulated Learners at the 17th Intl. Conf. on Artificial Intelligence in
Education (AIED 2015), Madrid, Spain, 2015.
([paper](http://ceur-ws.org/Vol-1432/sl_pap4.pdf))
* Brusilovsky, P.,
Somyurek, S., Guerra, J., Hosseini, R., and Zadorozhny, V. (2015) The
Value of Social: Comparing Open Student Modeling and Open Social Student
Modeling. In: F. Ricci, K. Bontcheva, O. Conlan and S. Lawless (eds.)
Proceedings of 23nd Conference on User Modeling, Adaptation and
Personalization (UMAP 2015), Dublin, Ireland, , June 29 - July 3, 2015,
Springer Verlag, pp. 44-55
([paper](https://www.researchgate.net/publication/280805929_The_Value_of_Social_Comparing_Open_Student_Modeling_and_Open_Social_Student_Modeling)
[presentation](http://www.slideshare.net/pbrusilovsky/umap2015-mg))
*
Guerra, J., Huang, Y., Hosseini, R., & Brusilovsky, P. (2015, June).
Graph Analysis of Student Model Networks. In Proceedings of the Second
International Workshop on Graph-Based Educational Data Mining (GEDM
2015). CEUR-WS.
([paper](https://d-scholarship.pitt.edu/secure/25933/1/graph_analysis.pdf))
([presentation](http://www.slideshare.net/mallium/graph-analysis-of-student-model-networks))
*
Guerra, J., Huang, Y., Hosseini, R., & Brusilovsky, P. Exploring the
Effects of Open Social Student Model Beyond Social Comparison. In ISLG
2015 Fourth Workshop on Intelligent Support for Learning in Groups (p.
19).
([paper](https://d-scholarship.pitt.edu/secure/25931/1/islg_pap4.pdf))
([poster](http://www.slideshare.net/mallium/exploring-the-effects-of-open-social-student-model-beyond-social-comparison))
*
Hosseini, R., Hsiao, I.-H., Guerra, J., Brusilovsky, P. (2015) Off the
Beaten Path: The Impact of Adaptive Content Sequencing on Student
Navigation in an Open Social Student Modeling Interface. In: Proceedings
of the 17th International Conference on Artificial Intelligence in
Education (AIED 2015), Madrid, Spain, pp. 624-628.
([paper](https://d-scholarship.pitt.edu/secure/25938/1/paper_183.pdf))
([poster](http://www.slideshare.net/RoyaHosseini1/aied-2015-poster-off-the-beaten-path-the-impact-of-adaptive-content-sequencing-on-student-navigation-in-an-open-social-student-modeling-interface))
*
Hosseini, R., Hsiao, I.-H., Guerra, J., Brusilovsky, P. (2015) What
Should I Do Next? Adaptive Sequencing in the Context of Open Social
Student Modeling. Proceedings of 10th European Conference on Technology
Enhanced Learning (EC-TEL 2015), Toledo, Spain, September 15-18, 2015,
pp. 155-168.
([paper](http://d-scholarship.pitt.edu/26266/1/camera_ready.pdf))([presentation](http://www.slideshare.net/RoyaHosseini1/ectel-2015)).
*
Somyürek, S. & Brusilovsky, P. (2015). Impact of Open Social Student
Modeling on Self-Assessment of Performance. Proceedings of World
Conference on E-Learning in Corporate, Government, Healthcare, and
Higher Education 2009 (E-Learn 2015). Kona, Hawaii, United States,
October 19-22, 2015
* Hosseini, R., Sirkiä, T., Guerra, J.,
Brusilovsky, P., Malmi, L. (2016) Animated Examples as Practice Content
in a Java Programming Course. Proceedings of the 47th ACM technical
symposium on Computer Science Education (SIGCSE), Memphis, Tennessee,
March 2-5, 2016.
([paper](http://d-scholarship.pitt.edu/28928/1/sigcse2016.pdf))
([presentation](http://www.slideshare.net/RoyaHosseini1/sigcse-2016))
*
Guerra, J., Hosseini, R., Somyurek, S., and Brusilovsky, P. (2016) An
Intelligent Interface for Learning Content: Combining an Open Learner
Model and Social Comparison to Support Self-Regulated Learning and
Engagement. In: Proceedings of Proceedings of the 21st International
Conference on Intelligent User Interfaces (IUI '16), Sonoma, California,
USA, ACM, pp. 152-163.
([paper](https://d-scholarship.pitt.edu/secure/27083/1/sigcse2016.pdf))
([presentation](http://www.slideshare.net/RoyaHosseini1/sigcse-2016))
*
Brusilovsky, P., Somyurek, S., Guerra, J., Hosseini, R., Zadorozhny, V.,
and Durlach, P. (2016) The Value of Social: Comparing Open Student
Modeling and Open Social Student Modeling. IEEE Transactions on Emerging
Topics in Computing 4 (3), 450-461.
([paper](https://www.computer.org/csdl/trans/ec/2016/03/07359179.pdf))
