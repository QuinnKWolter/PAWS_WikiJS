\n\nThis work is focused on mutual influence of heterogeneous user
activity types (reading texts, viewing examples, and solving problems)
on user's knowledge of some educational domain. Ordinarily
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>'s
considers them separately by classifying them to modeling tiers or
levels, each corresponding to a level of
\[<http://www.officeport.com/edu/blooms.htm>\| Bloom's taxonomy\] of
intellectual behavior. Great part of this work is devoted on cross-tier
user modeling. Namely, how user activity can (positively) influence on
another/other layer(s).\n\n== Study 1 ==\nIn this study we have
inspected the influence of the comprehension layer of
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>'s user
model (viewing examples) on the application layer (solving problems).
Our approach was to create "blends" of problem-solving tier of the user
model and weighted (from 0 to 1, with .1 step) example viewing tier Our
hypotheses were that:\n\* Using example browsing activity when modeling
problem solving improves model accuracy\n\* Different users benefit from
different “blends” of user model levels\nIn addition we wanted to se
if\n\* There is a single optimal blend for all users, and. or\n\*
Classes of users benefitting from different model blends can be
determined\n\n=== Data ===\nWe were using previously collected student
<a href="CUMULATE_Usage_Logs#Database_Management_6_Course_Dataset"
class="wikilink" title="usage logs">usage logs</a> collected from 4
Database Management courses offered during Fall 2007 and Spring 2008
semesters at the [University of Pittsburgh](http://www.pitt.edu) and
[Dublin City University](http://www.dcu.ie). Each course had roughly the
same structure, an identical set of 48 problems served by
<a href="SQLKnoT" class="wikilink" title="SQLKnoT">SQLKnoT</a> system,
and an identical set of 64 examples served by
<a href="WebEx" class="wikilink" title="WebEx">WebEx</a> system. Basic
usage statistics are given in the table below.\n\n{\|
border="1"\n!School\n!Semester\n!Level\n!No. of users\n!Avg. problem
attempts\n!Avg. example views\n!Avg. distinct problems\n!Avg. distinct
examples\n\|- \n\| U. of Pitt\n\| Fall 2007\n\| U\*\n\| 27\n\|
156.40\n\| 189.00\n\| 29.96\n\| 32.07\n\|- \n\| U. of Pitt\n\| Fall
2007\n\| G\n\| 20\n\| 61.70\n\| 104.70\n\| 29.95\n\| 29.10\n\|- \n\| U.
of Pitt\n\| Spring 2008\n\| U\n\| 15\n\| 26.94\n\| 46.65\n\| 16.35\n\|
10.29\n\|- \n\| DCU\n\| Spring 2008\n\| U\n\| 52\n\| 81.68\n\|
257.25\n\| 22.82\n\| 38.63\n\|}\n\* U – undergraduate, G –
graduate\n\n=== Procedures ===\nOut of 114 users who took the class 56
were chosen. The criteria was that the user had to cover at least 33% of
problems (15/48) and at least 33% of examples (15/64). For each of the
qualified users 11 user models were computed: with 0% to 100% of example
browsing activity "blended" to the problem solving (by % here we mean
numerical weighting not item filtering).\n\n=== Metrics ===\n\*
[Accuracy](http://en.wikipedia.org/wiki/Accuracy) was used to measure
the resulting user model quality\n\* For every user - the "best blend" -
blended model (with 10% or more of example activity added) having the
highest accuracy; if there is more than one such model, the smallest %
of the blend is taken\n\* For each user - number of "best blends" -
number of blended models (with 10% blend of example activity or more),
where the accuracy is the highest\n\n=== Results
===\n![**100**\|Examples of blend effect on user model
accuracy](Blending_layers_of_CUMULATE's_user_model._Study_1.users.png "100|Examples of blend effect on user model accuracy")\n![**100**\|Distribution
of number of users for different "best"
blends](Blending_layers_of_CUMULATE's_user_model._Study_1.histogram.png "100|Distribution of number of users for different "best" blends")\n\*
While looking at users' individual preferences, the best user blend
seems to be superior to the 0%-blend: t = -5.38, p-value\<.001\n\*
Comparison of uniform blends for all users to a 0%-blends, shows that
40% and 50% blends were significantly better than 0%-blend: t = -for
both 2.05, p-value = .023\n\* User separation into groups by the number
of best blends yielded the following results\n\*\*
<span style="color:grey;">***Low***. 1 best blend only, 2 users. No
further investigation performed.</span>\n\*\* ***Medium***. 2-4 best
blends. 22 users. Here 90% blend had the highest significant edge over
0% blend: p-value = .037\n\*\* ***High**''. 5-9 best blends. 17 users.
This group follows the global trend with 40% and 50% blends having best
significant edge over 0% blend: p-value = .049\n\*\*
<span style="color:grey;">***No difference**''. 10 best blends (all
blended models have same accuracy). 15 users. No further investigation
performed.</span>\n\n=== Publication ===\nYudelson, M., Sosnovsky, A.
(2009). Retrospective evaluation of blended user modeling for adaptive
educational systems. In: Weibelzahl, S., Masthoff., J., Paramythis, A.,
van Velsen, L. (Eds.) [6th Workshop on User-Centred Design and
Evaluation of Adaptive Systems
(UCDEAS)](http://www.easy-hub.org/hub/workshops/umap2009/index.html),
pp. 34-43. June 26, 2009. Trento, Italy. (<a
href="Media:UMAP09.UCDEAS.Yudelson.Retrosp._Eval._Blended_UM_For_AES.pdf"
class="wikilink" title="slides">slides</a>)\n\n=== Addendum ===\nMATLAB
code used for computation can be downloaded <a
href="Media:CUMULATE_blending_user_model_layers_study1_umap09_ucdeas_matlab.src.tgz"
class="wikilink" title="here">here</a>.\n\n<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>
log data for the 6 Database Management Courses can be accessed
<a href="CUMULATE_Usage_Logs#Database_Management_6_Course_Dataset"
class="wikilink" title="here">here</a>\n\n= Contacts
=\n<a href="User:Myudelson" class="wikilink"
title="Michael V. Yudelson">Michael V. Yudelson</a>
