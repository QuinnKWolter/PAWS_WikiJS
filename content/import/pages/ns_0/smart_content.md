---
title: "Smart Content"
source_namespace: "ns_0"
source_filename: "Smart_Content.md"
---

Mastery Grids supports and provides multiple types of learning
materials. It has been applied in three domains (Java, SQL, and Python)
as a supplementary E-learning system for undergraduate and graduate
level programming and database classes since 2013. In each learning
domain, courses are organized by topics and different types of learning
contents are arranged under each topic. Learning contents contain
semantics, problems, parson problems, annotated examples, and animated
examples. This sections reviews all these content types.

While
Mastery Grids interface can support any kind of content, we try to focus
on "smart learning content" that interactively engages student, collects
interaction data, and provides various kinds of feedback. For a
discussion and definition of smart learning content, see the following
ITiCSE Working Group Report:

Brusilovsky, P., Edwards, S., Kumar, A.,
Malmi, L., Benotti, L., Buck, D., Ihantola, P., Prince, R., Sirkiä, T.,
Sosnovsky, S., Urquiza, J., Vihavainen, A., and Wollowski, M. (2014)
[Increasing Adoption of Smart Learning Content for Computer Science
Education](https://www.researchgate.net/publication/273380880_Increasing_Adoption_of_Smart_Learning_Content_for_Computer_Science_Education).
In: Proceedings of the Working Group Reports of the 2014 on Innovation &
Technology in Computer Science Education Conference, Uppsala, Sweden,
ACM, pp. 31-57.


#### Code-Tracing Problems for Java and Python

We have developed a content application
[QuizJET](/ns_0/quizjet) providing
problems to learn Java Programming. Here are two problems for Java. The
left one shows a problem with a single class asking the value of a
variable in a piece of code. The right one shows a problem with multiple
classes asking the console output of a piece of code. Correctness is
accessed by the content application and students can attempt multiple
times with different instantiations of the variables in the problem.
Similarly, we have developed a content application
[QuizPET](/ns_0/quizpet) providing
the same type of problems to learn Python Programming.

New problems
for [QuizJET](/ns_0/quizjet) and
[QuizPET](/ns_0/quizpet) could be
easily created with <a href="QuizJET_Authoring_System" class="wikilink"
title="QuizJET Authoring System">QuizJET Authoring System</a> tool and
<a href="QuizPET_Authoring_System" class="wikilink"
title="QuizPET Authoring System">QuizPET Authoring System</a>.

<img src="../../media/images/other/Problems.jpg" title="Problems.jpg" width="650" height="1300"
alt="Problems.jpg" />

#### SQL Problems

For learning SQL, we have
developed a content application
[SQLKnoT](/ns_0/sqlknot) providing
another type of problem. Students are asked to write a complete query to
achieve a task in each problem. Here is a problem for SQL.


<img src="Problems_Sql.jpg" title="Problems_Sql.jpg" width="500"
height="750" alt="Problems_Sql.jpg" />

#### Parson Problems for Python

Here is a parson problems for Python. In such problems, students are
asked to drag different fragments of a code to construct a complete code
in order to achieve a task. Some examples of created parson problems can
be found [here](http://acos.cs.hut.fi/) under "Installed content
packages" (e.g. jsparsons-python tab).

New parson problems can be
created by <a href="Parson_Problem_Authoring_System" class="wikilink"
title="Parson Problem Authoring System">Parson Problem Authoring
System</a>.

<img src="../../media/images/other/ParsonProblems.jpg" title="ParsonProblems.jpg" width="750"
height="1000" alt="ParsonProblems.jpg" />

#### Annotated Examples for Java, Python, and SQL

We have developed a content application
[WebEx](/ns_0/webex) providing
annotated examples. Students can click on the left side box to learn
about each line’s related concepts. We has a large collection of WebEx
examples for Java, Python, SQL, C, and other programming languages. New
WebEx examples could be created with
<a href="Annotated_Example_Authoring_System" class="wikilink"
title="Annotated Example Authoring System">Annotated Example Authoring
System</a>.

Since 2016, we switched to a more advanced system
[PCEX](/ns_0/pcex) for presenting
annotated worked code examples for Python and Java. WebEx is still being
used to present SQL code examples.
[PCEX](/ns_0/pcex) has its own
authoring system
[WEAT](/ns_0/weat).

Below, you can
see an annotated WebEx code examples for Python. It is presented using
[JSWebEx](/ns_0/jswebex) is a
newer Javascript interface that replaces the old server-side WebEx
interface, but using the same large collection of examples developed for
WebEx.


<img src="jswebex.png" title="jswebex.png" width="650" height="800"
alt="jswebex.png" />

#### Animated Examples for Python and Java

We
have created a large number of animated program execution examples for
Python, Java, and SQL. In such examples, the line-by-line execution of a
piece of code is visualized by animations.

Here is an animated
example for Python. More animated examples created for Python can be
found [here](http://acos.cs.hut.fi/) under "Installed content packages"
(e.g. jsvee-python tab).

New animated example can be created by
<a href="Animated_Example_Authoring_System" class="wikilink"
title="Animated Example Authoring System">Animated Example Authoring
System</a>.

<img src="../../media/images/other/AnimatedExamples.jpg" title="AnimatedExamples.jpg" width="750"
height="1000" alt="AnimatedExamples.jpg" />

#### Animated Examples for SQL

We developed a collection of animated examples for SQL using
Flash. More animated examples created for SQL can be found
[here](http://columbus.exp.sis.pitt.edu/sql_ae_demo/). Unfortunately,
these examples can't be executed in modern browsers
anymore.

<img src="../../media/images/other/AnimatedExamplesSQL.jpg" title="AnimatedExamplesSQL.jpg"
width="750" height="1000" alt="AnimatedExamplesSQL.jpg" />

#### Videos

We have created applications for collecting, editing, authoring
videos. The related codes can be found in
[Github](https://github.com/PAWSLabUniversityOfPittsburgh/educvideos).
