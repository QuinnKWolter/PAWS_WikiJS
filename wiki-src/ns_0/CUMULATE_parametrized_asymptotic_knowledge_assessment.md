<a href="CUMULATE" class="wikilink" title="CUMULATE">CUMULATE</a>'s
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink"
title="parameterized asymptotic knowledge assessment">parameterized
asymptotic knowledge assessment</a> algorithm is an attempt to overcome
shortcomings of its
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="non-paramterized">non-paramterized</a> version. Namely,
*one-fits-all* nature, prohibiting parameter tuning for individual
users' abilities and problem complexities.\n\n=Computation=\nThe formula
below is used to update the knowledge levels of concepts (*c*) addressed
in a problem (*p*). This formula reflects the following principles
(identical to the
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="predecessor">predecessor</a> algorithm).\n\* there are several
domain concepts (knowledge items, rules, productions) involved in
solving a problem; the knowledge of each of them is updated
proportionally to the others\n\* knowledge is updated only upon correct
user answers, there is no penalty for errors\n\* solving a problem
correctly multiple times will result in diminishing update (growth) of
the knowledge level of the concepts as the number of successes grows\nin
addition:\n\* the initial level of knowledge, speed of knowledge growth,
and penalty for repetitive (correct) solutions to the problem - are now
adjustable
parameters\n![](CUMULATE_parameterized_asymptotic_knowledge_assessment.png "CUMULATE_parameterized_asymptotic_knowledge_assessment.png"),
where\n\* *Ko* - is the starting level of knowledge, *Ko* ∈ \[0, 1\]\n\*
*res* - result of user action (0 -error, 1 - correct); \n\* *Wc,p* - is
a weight of concept *c* in problem *p*\n\* Σ*Wc,p* - is the sum of
weights of all concepts in problem *p*\n\*
*<sub>succ</sub>att<sub>p</sub>* - is a number of successful solutions
to problem *p* prior to current attempt\n\* *pV* - speed of knowledge
growth parameter, *pV* ∈ \[0, 1\]\n\* *OPP* - over-practicing parameter,
controlling the penalty for repetitively solving one problem
(correctly), *OPP* ∈ \[0, 1\]\n\n=Examples=\n\n==Example 1==\nBelow is a
graph of concept's knowledge level growth and the penalty coefficient
vs. number of successful attempts to apply it in a problem. The lines
denote:\n\* the blue line denotes a successful use of a concept in a new
problem (*pV* = .5)\n\* the green line denotes a penalty coefficient --
1/*(<sub>succ</sub>att<sub>p</sub>*+2)*<sup>OPP</sup>* -- as if it was
the same problem (*OPP* = .25)\n\* the red line *merges* the two graphs
above\n![](CUMULATE_parameterized_asymptotic_knowledge_assessment_-_knowledge_growth_and_penalty.png "CUMULATE_parameterized_asymptotic_knowledge_assessment_-_knowledge_growth_and_penalty.png")\n  
\n([alternatively](http://chart.apis.google.com/chart?cht=lxy&chs=300x240&chd=t:0,10,20,30,40,50,60,70,80,90,100%7C00,50,75,88,94,97,98,99,100,100,100%7C-1%7C-1,100,84,76,71,67,64,61,59,58,56%7C-1%7C00,50,63,66,66,65,63,61,59,58,56&chco=24588E,4C9B46,CF1E2B&chxt=x,y&chxl=1:%7C0%7C.2%7C.4%7C.6%7C.8%7C1%7C0:%7C0%7C1%7C2%7C3%7C4%7C5%7C6%7C7%7C8%7C9%7C10&chm=o,24588E,0,-1,10%7Co,4C9B46,1,-1,10%7Co,CF1E2B,2,-1,10&chg=10,20&chdl=knowledge+level%7Cpenalty+coefficient%7Cresulting+curve&chdlp=b+&chls=1,1,0%7C1,1,0%7C3,6,3&chtt=Knowledge+level+growth+and+change+in+penalty%7Ccoefficient+vs.+number+of+successful+attempts&chdlp=b)
via [Google Chart API](http://code.google.com/apis/chart/))\n\n==Example
2==\nBelow: the speed of problem learning is held constant (*pV* = .5)
while the penalty for practicing the same problem
changes.\n\n![](CUMULATE_parameterized_asymptotic_knowledge_assessment_-_knowledge_growth_for_diff_OPP.png "CUMULATE_parameterized_asymptotic_knowledge_assessment_-_knowledge_growth_for_diff_OPP.png")\n  
\n([alternatively](http://chart.apis.google.com/chart?cht=lxy&chs=300x240&chd=t:0,10,20,30,40,50,60,70,80,90,100%7C0,50,75,87,93,97,98,99,100,100,100%7C-1%7C0,47,71,83,90,94,97,98,98,99,100%7C-1%7C0,42,64,77,85,89,93,95,96,97,98%7C-1%7C0,35,54,66,73,79,83,86,88,90,92%7C-1%7C0,30,45,55,62,67,70,74,76,78,80%7C-1%7C0,25,38,45,51,55,58,61,63,65,66&chco=24588E,4C9B46,F3A030,CF1E2B,78387B,7C807F&chxt=x,y&chxl=1:%7C0%7C.2%7C.4%7C.6%7C.8%7C1%7C0:%7C0%7C1%7C2%7C3%7C4%7C5%7C6%7C7%7C8%7C9%7C10&chm=o,24588E,0,-1,10%7Co,4C9B46,1,-1,10%7Co,F3A030,2,-1,10%7Co,CF1E2B,3,-1,10%7Co,78387B,4,-1,10%7Co,7C807F,5,-1,10&chg=10,20&chdl=OPP=.01%7COPP=.10%7COPP=.25%7COPP=.50%7COPP=.75%7COPP=1.0&chdlp=b&chtt=Knowledge+level+growth+for+different+penalty%7Cparameters+vs.+number+of+successful+attempts)
via [Google Chart API](http://code.google.com/apis/chart/))\n\n==Example
3==\nGraph below shows differences the growth of knowledge while speed
of learning varies. No penalty is
given.\n\n![](CUMULATE_parameterized_asymptotic_knowledge_assessment_-_knowledge_growth_for_diff_pV.png "CUMULATE_parameterized_asymptotic_knowledge_assessment_-_knowledge_growth_for_diff_pV.png")\n  
(\[<http://chart.apis.google.com/chart?cht=lxy&chs=300x240&chd=t:0,10,20,30,40,50,60,70,80,90,100%7C0,1,2,3,4,5,6,7,8,9,10%7C-1%7C0,10,19,27,34,41,47,52,57,61,65%7C-1%7C0,25,44,58,68,76,82,87,90,92,94%7C-1%7C0,50,75,88,94,97,98,99,100,100,100%7C-1%7C0,75,94,98,100,100,100,100,100,100,100%7C-1%7C0,100,100,100,100,100,100,100,100,100,100&chco=24588E,4C9B46,F3A030,CF1E2B,78387B,7C807F&chxt=x,y&chxl=1>:\|0\|.2\|.4\|.6\|.8\|1\|0:\|0\|1\|2\|3\|4\|5\|6\|7\|8\|9\|10&chm=o,24588E,0,-1,10\|o,4C9B46,1,-1,10\|o,F3A030,2,-1,10\|o,CF1E2B,3,-1,10\|o,78387B,4,-1,10\|o,7C807F,5,-1,10&chg=10,20&chdl=pV=.01\|pV=.10\|pV=.25\|pV=.50\|pV=.75\|pV=1.0&chdlp=b&chtt=Knowledge+growth+for+different+problem+learnig\|speeds+vs.+number+of+successful+attempts
alternatively\] via [Google Chart
API](http://code.google.com/apis/chart/))\n\n=Studies=\n\*
<a href="CUMULATE_user_and_domain_adaptive_user_modeling#Study_1"
class="wikilink" title="Study 1">Study 1</a> - comparison of the
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="legacy">legacy</a> and
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink" title="parametrized">parametrized</a> algorithms based
on SQL problem-solving data\n\n= Contacts
=\n<a href="User:Myudelson" class="wikilink" title=" Michael V. Yudelson">
Michael V. Yudelson</a>
