---
title: "Blending layers of CUMULATE's user model"
source_namespace: "ns_0"
source_filename: "Blending_layers_of_CUMULATE's_user_model.md"
---



This work is focused on mutual influence of heterogeneous user
activity types (reading texts, viewing examples, and solving problems)
on user's knowledge of some educational domain. Ordinarily
[CUMULATE](/ns_0/cumulate)'s
considers them separately by classifying them to modeling tiers or
levels, each corresponding to a level of
\[<http://www.officeport.com/edu/blooms.htm>\| Bloom's taxonomy\] of
intellectual behavior. Great part of this work is devoted on cross-tier
user modeling. Namely, how user activity can (positively) influence on
another/other layer(s).

#### Study 1

In this study we have
inspected the influence of the comprehension layer of
[CUMULATE](/ns_0/cumulate)'s user
model (viewing examples) on the application layer (solving problems).
Our approach was to create "blends" of problem-solving tier of the user
model and weighted (from 0 to 1, with .1 step) example viewing tier Our
hypotheses were that:
* Using example browsing activity when modeling
problem solving improves model accuracy
* Different users benefit from
different “blends” of user model levels
In addition we wanted to se
if
* There is a single optimal blend for all users, and. or
*
Classes of users benefitting from different model blends can be
determined

###### Data

We were using previously collected student
<a href="CUMULATE_Usage_Logs#Database_Management_6_Course_Dataset"
class="wikilink" title="usage logs">usage logs</a> collected from 4
Database Management courses offered during Fall 2007 and Spring 2008
semesters at the [University of Pittsburgh](http://www.pitt.edu) and
[Dublin City University](http://www.dcu.ie). Each course had roughly the
same structure, an identical set of 48 problems served by
[SQLKnoT](/ns_0/sqlknot) system,
and an identical set of 64 examples served by
[WebEx](/ns_0/webex) system. Basic
usage statistics are given in the table below.

{\|
border="1"
!School
!Semester
!Level
!No. of users
!Avg. problem
attempts
!Avg. example views
!Avg. distinct problems
!Avg. distinct
examples
\|-
\| U. of Pitt
\| Fall 2007
\| U*
\| 27
\|
156.40
\| 189.00
\| 29.96
\| 32.07
\|-
\| U. of Pitt
\| Fall
2007
\| G
\| 20
\| 61.70
\| 104.70
\| 29.95
\| 29.10
\|-
\| U.
of Pitt
\| Spring 2008
\| U
\| 15
\| 26.94
\| 46.65
\| 16.35
\|
10.29
\|-
\| DCU
\| Spring 2008
\| U
\| 52
\| 81.68
\|
257.25
\| 22.82
\| 38.63
\|}
* U – undergraduate, G –
graduate

###### Procedures

Out of 114 users who took the class 56
were chosen. The criteria was that the user had to cover at least 33% of
problems (15/48) and at least 33% of examples (15/64). For each of the
qualified users 11 user models were computed: with 0% to 100% of example
browsing activity "blended" to the problem solving (by % here we mean
numerical weighting not item filtering).

###### Metrics

*
[Accuracy](http://en.wikipedia.org/wiki/Accuracy) was used to measure
the resulting user model quality
* For every user - the "best blend" -
blended model (with 10% or more of example activity added) having the
highest accuracy; if there is more than one such model, the smallest %
of the blend is taken
* For each user - number of "best blends" -
number of blended models (with 10% blend of example activity or more),
where the accuracy is the highest

###### Results

![**100**\|Examples of blend effect on user model
accuracy](Blending_layers_of_CUMULATE's_user_model._Study_1.users.png "100|Examples of blend effect on user model accuracy")
![**100**\|Distribution
of number of users for different "best"
blends](Blending_layers_of_CUMULATE's_user_model._Study_1.histogram.png "100|Distribution of number of users for different "best" blends")
*
While looking at users' individual preferences, the best user blend
seems to be superior to the 0%-blend: t = -5.38, p-value\<.001
*
Comparison of uniform blends for all users to a 0%-blends, shows that
40% and 50% blends were significantly better than 0%-blend: t = -for
both 2.05, p-value = .023
* User separation into groups by the number
of best blends yielded the following results
**
<span style="color:grey;">***Low***. 1 best blend only, 2 users. No
further investigation performed.</span>
** ***Medium***. 2-4 best
blends. 22 users. Here 90% blend had the highest significant edge over
0% blend: p-value = .037
** ***High**''. 5-9 best blends. 17 users.
This group follows the global trend with 40% and 50% blends having best
significant edge over 0% blend: p-value = .049
**
<span style="color:grey;">***No difference**''. 10 best blends (all
blended models have same accuracy). 15 users. No further investigation
performed.</span>

###### Publication

Yudelson, M., Sosnovsky, A.
(2009). Retrospective evaluation of blended user modeling for adaptive
educational systems. In: Weibelzahl, S., Masthoff., J., Paramythis, A.,
van Velsen, L. (Eds.) [6th Workshop on User-Centred Design and
Evaluation of Adaptive Systems
(UCDEAS)](http://www.easy-hub.org/hub/workshops/umap2009/index.html),
pp. 34-43. June 26, 2009. Trento, Italy. (<a
href="Media:UMAP09.UCDEAS.Yudelson.Retrosp._Eval._Blended_UM_For_AES.pdf"
class="wikilink" title="slides">slides</a>)

###### Addendum

MATLAB
code used for computation can be downloaded <a
href="Media:CUMULATE_blending_user_model_layers_study1_umap09_ucdeas_matlab.src.tgz"
class="wikilink" title="here">here</a>.

[CUMULATE](/ns_0/cumulate)
log data for the 6 Database Management Courses can be accessed
<a href="CUMULATE_Usage_Logs#Database_Management_6_Course_Dataset"
class="wikilink" title="here">here</a>

= Contacts
=
<a href="User:Myudelson" class="wikilink"
title="Michael V. Yudelson">Michael V. Yudelson</a>
