This stream of work is aimed at improving
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>'s
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="legacy">legacy</a> *one-fits-all* algorithm for modeling user's
problem-solving activity and creating a context-sensitive user modeling
algorithm adaptable/adaptive to individual users' cognitive abilities as
well as to individual problem complexities.\n\nA new
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink" title="parametrized">parametrized</a> user modeling
algorithm has been devised. A set of studies is set up to evaluate the
new algorithm as well as its adaptability/adaptivity.\n\n==Study
1==\nThis study involves retrospective comparative evaluation of the
<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>'s
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="legacy">legacy</a> and
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink" title="parametrized">parametrized</a> user modeling
algorithms. The evaluation is done using
<a href="CUMULATE_Usage_Logs#Database_Management_6_Course_Dataset"
class="wikilink" title="usage logs">usage logs</a> collected from 6
Database Management courses offered during Fall 2007 and Spring 2008
semesters at the [University of Pittsburgh](http://www.pitt.edu),
[National College of Ireland](http://www.ncirl.ie), and [Dublin City
University](http://www.dcu.ie). Each course had roughly the same
structure and an identical set of problems served by
<a href="SQLKnoT" class="wikilink" title="SQLKnoT">SQLKnoT</a>
system.\n\n=== Scenario ===\nWe were comparing
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="legacy">legacy</a> CUMULATE algorithm and 3 versions of
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink" title="parametrized">parametrized</a> algorithm. The
versions differed in the parameters used for user modeling.\n\* First,
was an attempt to shadow the
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="legacy">legacy</a> algorithm by *guessing* the best parameters
for modeling, without discriminating individual user and problem
differences.\n\* The second version, did not discriminate users/problems
as well. However, the parameters were obtained by fitting one global
user parameter and one global problem parameter signature and then using
them for the modeling.\n\* The third version of the
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink" title="parametrized">parametrized</a> algorithm worked
with a set of user specific parameters and problem specific parameter
signatures for the modeling.\n\n=== Procedures
===\n[Accuracy](http://en.wikipedia.org/wiki/Accuracy) and
[SSE](http://en.wikipedia.org/wiki/Sum_of_squared_error) (sum of squared
error) were used as the metrics of comparison. They were computed
overall for each of the 6 semester logs and 4 versions of
algorithms.\n\nIn the case of
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="legacy CUMULATE">legacy CUMULATE</a> and
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink" title="parametrized CUMULATE">parametrized CUMULATE</a>-best-guess
algorithms, the data was taken as it. The globally parametrized, and
individually paramatrized CUMULATE algorithms were supplied with the
pre-fit global/individual user/problem-specific parameters. The data of
only one of the early courses was used to obtain the parameters. Data of
all 6 was used to compute parametrized models. Refer to the table below
for details and basic log statistics statistics.\n\n{\|
border="1"\n!Semester\n!School\n!Level\n!Procedures\n!Users\n!Datapoints\n!Attempts
per user\n!Problems per
user\n\|-\n\|Fall'07\n\|[Pitt](http://www.pitt.edu)\n\|Und.\n\|Obtain
global/individual user/problem-specific parameters  
Compute C<sub>L</sub>, C<sub>p:bg</sub>, C<sub>p:glob</sub>,
C<sub>p:ind</sub>\n\|27\n\|4224\n\|156.44\n\|29.96\n\|-\n\|Fall'07\n\|[Pitt](http://www.pitt.edu)\n\|Grad.\n\|Compute
C<sub>L</sub>, C<sub>p:bg</sub>, C<sub>p:glob</sub>,
C<sub>p:ind/glob</sub>\n\|20\n\|1233\n\|61.65\n\|29.95\n\|-\n\|Spring'08\n\|[Pitt](http://www.pitt.edu)\n\|Und.\n\|Compute
C<sub>L</sub>, C<sub>p:bg</sub>, C<sub>p:glob</sub>,
C<sub>p:ind/glob</sub>\n\|15\n\|458\n\|26.94\n\|16.35\n\|-\n\|Spring'08\n\|[NCI](http://www.ncirl.ie)\n\|Und.\n\|Compute
C<sub>L</sub>, C<sub>p:bg</sub>, C<sub>p:glob</sub>,
C<sub>p:ind/glob</sub>\n\|17\n\|216\n\|12.71\n\|6.59\n\|-\n\|Spring'08\n\|[NCI](http://www.ncirl.ie)\n\|Und.\n\|Compute
C<sub>L</sub>, C<sub>p:bg</sub>, C<sub>p:glob</sub>,
C<sub>p:ind/glob</sub>\n\|18\n\|142\n\|7.89\n\|4.00\n\|-\n\|Spring'08\n\|[DCU](http://www.dcu.ie)\n\|Und.\n\|Compute
C<sub>L</sub>, C<sub>p:bg</sub>, C<sub>p:glob</sub>,
C<sub>p:ind/glob</sub>\n\|52\n\|4574\n\|81.68\n\|22.82\n\|}\nC<sub>L</sub> -
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="legacy CUMULATE">legacy CUMULATE</a>'s algorithm,
C<sub>p:bg</sub> -
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink" title="parametrized CUMULATE">parametrized CUMULATE</a>'s
algorithm with guessed global parameters, C<sub>p:glob</sub>-
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink" title="parametrized CUMULATE">parametrized CUMULATE</a>'s
algorithm fit global user/problem parameters, C<sub>p:ind</sub> -
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink" title="parametrized CUMULATE">parametrized CUMULATE</a>'s
algorithm with individual user/problem parameters,
C<sub>p:ind/glob</sub> -
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink" title="parametrized CUMULATE">parametrized CUMULATE</a>'s
algorithm with individual problem parameters, and global user
parameter\n\n=== Results ===\nAs we can see from the figures below,
neither guessed not globally-fit parameters in a new
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink" title="parametrized">parametrized</a> algorithm give it
an edge. Individual problem-specific parameters, however, do give it an
advantage. In majority of the cases this advantage is significant (with
exception to the only graduate level course offered at
[Pitt](http://www.pitt.edu) in Fall 2007
semester)\n{\|\n\|\n![](CUMULATE_legacy_vs_parameterized_-_sql_6_semester_dataset_-_accuracy.png "CUMULATE_legacy_vs_parameterized_-_sql_6_semester_dataset_-_accuracy.png")\n  
(\[<http://chart.apis.google.com/chart?cht=lxy&chs=300x240&chd=t:-1%7C61,32,63,65%7C-1%7C39,39,44,46%7C-1%7C40,40,45,54%7C-1%7C50,50,50,65%7C-1%7C66,66,66,75%7C-1%7C47,42,55,57&chco=24588E,4C9B46,F3A030,CF1E2B,78387B,7C807F&chxt=x,y&chxl=1>:\|.3\|.4\|.5\|.6\|.7\|.8\|0:\|Cl\|Cp:bg\|Cp:al\|Cp:ea/al&chxp=1,30,40,50,60,70,80\|&chds=30,80&chxr=1,30,80,10&chm=o,24588E,0,-1,10\|o,4C9B46,1,-1,10\|o,F3A030,2,-1,10\|o,CF1E2B,3,-1,10\|o,78387B,4,-1,10\|o,7C807F,5,-1,10&chg=-1,10&chdl=Pitt+08-1+U\|Pitt+08-1+G\|Pitt+08-2+U\|NCI+08-2+U\|NCI+08-2+U\|DCU+08-2+U&chdlp=r&chtt=Algorithm+prediction+accuracy\|for+different+semesters
alternatively\] via [Google Chart
API](http://code.google.com/apis/chart/))\n\|\n![](CUMULATE_legacy_vs_parameterized_-_sql_6_semester_dataset_-_SSE.png "CUMULATE_legacy_vs_parameterized_-_sql_6_semester_dataset_-_SSE.png")\n  
(\[<http://chart.apis.google.com/chart?cht=lxy&chs=300x240&chd=t:-1%7C33,67,28,28%7C-1%7C57,61,46,46%7C-1%7C59,60,45,42%7C-1%7C50,50,36,30%7C-1%7C34,34,24,21%7C-1%7C46,58,33,35&chco=24588E,4C9B46,F3A030,CF1E2B,78387B,7C807F&chxt=x,y&chxl=1>:\|.2\|.3\|.4\|.5\|.6\|.7\|0:\|Cl\|Cp:bg\|Cp:al\|Cp:ea/al&chxp=1,20,30,40,50,60,70\|&chds=20,70&chxr=1,20,70,10&chm=o,24588E,0,-1,10\|o,4C9B46,1,-1,10\|o,F3A030,2,-1,10\|o,CF1E2B,3,-1,10\|o,78387B,4,-1,10\|o,7C807F,5,-1,10&chg=-1,10&chdl=Pitt+08-1+U\|Pitt+08-1+G\|Pitt+08-2+U\|NCI+08-2+U\|NCI+08-2+U\|DCU+08-2+U&chdlp=r&chtt=Algorithm+SSE\|for+different+semesters
alternatively\] via [Google Chart
API](http://code.google.com/apis/chart/))\n\n\|}\n\n=== Publication
===\nThe results were presented during the [i-fest
2009](http://www.i-fest.pitt.edu/) poster competition at the [School of
Information Sciences](http://www.ischool.pitt.edu/), [University of
Pittsburgh](http://www.pitt.edu/) and got the second place in the PhD
track. Poster can be accessed
[here](http://www.pitt.edu/~mvy3/assets/i-fest%202009%20yudelson.pdf).\n\n===
Addendum ===\n\nMATLAB code used for computation can be downloaded <a
href="Media:Cumulate_legacy_vs_user_n_domain_adaptive_study1_matlab.src.zip"
class="wikilink" title="here">here</a>.\n\n<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>
log data for the 6 Database Management Courses can be accessed
<a href="CUMULATE_Usage_Logs#Database_Management_6_Course_Dataset"
class="wikilink" title="here">here</a>\n\n= Contacts
=\n<a href="User:Myudelson" class="wikilink"
title="Michael V. Yudelson">Michael V. Yudelson</a>
