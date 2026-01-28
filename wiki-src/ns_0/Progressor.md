## Overview

\n\nA large number of educational resources is now made available on the
Web to support both regular classroom learning and online learning.
However, the abundance of available content produced at least two
problems: how to help students to find the most appropriate resources
and how to engage them into using these resources and benefit from them.
Personalized and social learning has been suggested as potential ways to
address these problems. Progressor attempts to combine the ideas of
personalized and social learning to help students find the\nmost
relevant resources in a large collection of parameterized
self-assessment questions for programming.\n\nProgressor is a
collaboration work between [University of
Jena](http://fusion.cs.uni-jena.de/professur) and [University of
Pittsburgh](http://adapt2.sis.pitt.edu/wiki). The core research goal of
the project is to utilize the success of self-assessment programming
language learning tool,
<a href="QuizJET" class="wikilink" title="QuizJET">QuizJET</a>, with
rich-interaction interface derived from
[IntrospectiveViews](http://www.minerva-portals.de/research/introspective-views)
and provide a better personalized visual access to programming language
problems. The research investigates open social student model; how
social guidance affects self-assessment programming language learning;
motivational effects on the progress of educational content; privacy and
data sharing and so on.\n\nWe are excited about what we've learnt from
this project, we are now extending our approaches to a larger collection
of learning objects for cross content navigation and verify its
capability of supporting social visualization for personalized
E-Learning, please refer to
[Progressor+](http://adapt2.sis.pitt.edu/wiki/ProgressorPlus)\n\n==
Features ==\n\* **Learner Analytics**: question attempts, successful
rates, overall progress etc.\n\* **Privacy management**: requests for
accessing peers' models.\n\* **Interactivity**: interacting with the
content, peers etc. from the visualization; allowing the user to feel in
control.\n\***Identity**: captures all the information belonging to the
student and displays it in a unique model, allowing easy
comparisons.\n\* **Exposure**: model thumbnails preview. We found that
students had more persistent interactions with the system while they had
higher visibilities.\n\* **Guidance**: implicit social guidance;
(explicit social guidance is under investigation now)\n\*
**Recommendation**: top 3 performers\n\* **Scalability**: we design a
set of
<a href="#Apply_protocols_the_social_visualization" class="wikilink"
title="protocols">protocols</a> for reusing student progress data in
various visualizations.\n\n== Apply protocols the social
visualization==\n\nWe design the following protocols allows requesting
user or group progress in JSON format. The protocol follows
[REpresentational State Transfer(REST)
architecture](http://en.wikipedia.org/wiki/Representational_state_transfer)
and is an extension of [CUMULATE
protocol](http://adapt2.sis.pitt.edu/wiki/CUMULATE_protocol). It
provides the applicability for applying it to other social
visualizations, such as
[Progressor+](http://adapt2.sis.pitt.edu/wiki/ProgressorPlus).\n\n**The
URL format for requesting particular user from a group with all his/her
activities:**\n

    \nhttp://adapt2.sis.pitt.edu/ktact/json/user/<the user login>/<the group name>\n\nExample:\nhttp://adapt2.sis.pitt.edu/ktact/json/user/shoha99/IS172011Spring\n

\n\n\* **id** – **question rdfid**, this is the unique identifier for
accessing the parameterized
[QuizJET](http://adapt2.sis.pitt.edu/wiki/QuizJET) question.\n\* **res**
– **total number of correct tries**, this number indicates the
successful attempts on this pattern of question.\n\* **attempt** –
**total number of tries**, this number represents how many times the
student has tried on this pattern of question.\n\n

    \n...\n   {\n      "id":"jVariables1",\n      "res":"6",\n      "attempt":"9"\n   },\n   {\n      "id":"jVariables2",\n      "res":"2",\n      "attempt":"3"\n   },\n...\n

\n\n\n**The URL format for requesting all students activities by
group:**\n

    \nhttp://adapt2.sis.pitt.edu/ktact/json/group/<the group name>\n\nExample:\nhttp://adapt2.sis.pitt.edu/ktact/json/group/IS172011Spring\n

\n\n\* **id** – **student login**, this specifies the student's
login.\n\* **name** – **student name'', this displays the student's
name.\n\***res**–**student average progress**, this number represents
the student's average progress across topics.\n\***topics**–**id**,
topic names;**res''', topic average progress.\n\n

    \n{\n      "id":"shoha99",\n      "name":"Hsiao, Sharon (I-Han)",\n      "res":"0.126",\n      "topics":[\n         {\n            "id":"Variables",\n            "res":"0.8"\n         },\n        {\n            "id":"Objects",\n            "res":"0.2"\n         },\n        ...\n},\n{\n      "id":"xxxx",\n      "name":"lastName, firstName ",\n      "res":"0.107",\n      "topics":[\n         {\n            "id":"Variables",\n            "res":"0.00"\n         },\n         {\n            "id":"Objects",\n            "res":"0.2"\n         },\n         ...\n}\n...\n

\n\n<a href="#top" class="wikilink" title="^top">^top</a>\n\n==
Screenshots ==\n\n

\nImage:Progressor.png\|Your personalized Progressor
view\nImage:ProgressorAccessQuiz.png\|Accessing to the quizzes or other
educational material\nImage:ProgressorComparing.png\|Comparing your own
model with another or class on average\n

\n\n==Publications==\n<onlyinclude>\n\* Bakalov, F.,
<a href="User:shoha99" class="wikilink" title=" Hsiao, I-H."> Hsiao,
I-H.</a>,
<a href="User:peterb" class="wikilink" title=" Brusilovsky, P.">
Brusilovsky, P.</a>, and König-Ries, B. (2011) **Visualizing Student
Models for Social Learning with Parallel IntrospectiveViews.** In:
Proceedings of Workshop on Visual Interfaces to the Social and Semantic
Web at the International Conference on Intelligent User Interfaces (IUI
2011), Stanford University, Palo Alto, California, US, February 13,
2011\n\*
<a href="User:shoha99" class="wikilink" title=" Hsiao, I-H."> Hsiao,
I-H.</a>, Bakalov, F.,
<a href="User:peterb" class="wikilink" title=" Brusilovsky, P.">
Brusilovsky, P.</a>, and König-Ries, B. (2011) **Open Social Student
Modeling: Visualizing Student Models with Parallel IntrospectiveViews.**
Proceedings of 19th International Conference on User Modeling,
Adaptation, and Personalization (UMAP 2011), Girona, Spain, July 11-15,
2011, Springer, pp.171-182
[DOI](http://dx.doi.org/10.1007/978-3-642-22362-4_15)\n\* Bakalov, F.,
<a href="User:shoha99" class="wikilink" title=" Hsiao, I-H."> Hsiao,
I-H.</a>,
<a href="User:peterb" class="wikilink" title=" Brusilovsky, P.">
Brusilovsky, P.</a>, and König-Ries, B. (2011) **Progressor:
Personalized visual access to programming problems**, IEEE Symposium on
Visual Languages and Human-Centric Computing, September 18-22, 2011,
Pittsburgh, PA,
USA\n\*<a href="User:shoha99" class="wikilink" title=" Hsiao, I-H."> Hsiao,
I-H.</a>,
<a href="User:Julio" class="wikilink" title="Guerra, J.">Guerra, J.</a>,
<a href="User:Dparra" class="wikilink" title="Parra, D.">Parra, D.</a>,
Bakalov, F., König-Ries, B., and
<a href="User:peterb" class="wikilink" title=" Brusilovsky, P.">
Brusilovsky, P.</a> (2012) **Comparative Social Visualization for
Personalized E-Learning.** International Working Conference Advanced
Visual Interfaces, AVI 2012, Capri, Italy, May 21-25, 2012\n\*
<a href="User:shoha99" class="wikilink" title=" Hsiao, I-H."> Hsiao,
I-H.</a>, Bakalov, F.,
<a href="User:peterb" class="wikilink" title=" Brusilovsky, P.">
Brusilovsky, P.</a>, and König-Ries, B. (2013) **Open Social Student
Modeling for Personalized E-Learning**. New Review of Hypermedia and
Multimedia, 19(2), 112-131.
[URL](http://www.tandfonline.com/doi/abs/10.1080/13614568.2013.806960?journalCode=tham20#.Uj8u1BZf_G4)\n</onlyinclude>\n\n==Try
Progressor==\nCurrent users Login from [KnowledgTree
portal](http://adapt2.sis.pitt.edu/kt/)\n\nProgressor is currently open
for courses, groups use. If you wish to try out the system individually,
please contact
<a href="User:shoha99" class="wikilink" title="Sharon Hsiao">Sharon
Hsiao</a>\n\nTry mobile Progressor [iphone app
v1.0](http://itunes.apple.com/us/app/open-social-student-modeling/id485009366?mt=8),
we also have droid. (<span style="color:red;">new</span>)\nnote: we are
enhancing the mobile design. make sure you check back later.\n\n==See
Also==\n\*
<a href="QuizJET" class="wikilink" title="QuizJET">QuizJET</a> :
parameterized self-assessment tool for Java programming language.\n\*
[IntrospectiveViews](http://www.minerva-portals.de/research/introspective-views)\n\n==
Contacts
==\n<a href="User:shoha99" class="wikilink" title=" Sharon, I-Han Hsiao">
Sharon, I-Han Hsiao</a>
