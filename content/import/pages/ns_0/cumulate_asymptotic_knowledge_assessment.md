---
title: "CUMULATE asymptotic knowledge assessment"
source_namespace: "ns_0"
source_filename: "CUMULATE_asymptotic_knowledge_assessment.md"
---

<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="Asymptotic knowledge assessment">Asymptotic knowledge
assessment</a> is
[CUMULATE](/ns_0/cumulate)'s
legacy user modeling algorithm for computing user knowledge with respect
to problem-solving.

=Computation=
The formula below is used to
update the knowledge levels of concepts (*c*) addressed in a problem
(*p*). This formula reflects the following principles.
* there are
several domain concepts (knowledge items, rules, productions) involved
in solving a problem; the knowledge of each of them is updated
proportionally to the others
* knowledge is updated only upon correct
user answers, there is no penalty for errors
* solving a problem
correctly multiple times will result in diminishing update (growth) of
the knowledge level of the concepts as the number of successes
grows
![](CUMULATE_asymptotic_knowledge_assessment.png "CUMULATE_asymptotic_knowledge_assessment.png"),
where
* *Ko* - is the starting level of knowledge (here we always
start from 0)
* *res* - result of user action (0 -error, 1 - correct);

* *Wc,p* - is a weight of concept *c* in problem *p*
* Σ*Wc,p* - is
the sum of weights of all concepts in problem *p*
*
*<sub>succ</sub>att<sub>p</sub>* - is a number of successful solutions
to problem p prior to current attempt

=Examples=
Below is a graph of
concept's knowledge level growth vs. number of successful attempts to
apply it. Every time the concept is applied correctly in a new problem.
Every time the concept is the only concept of the problem. Namely, the
*Wc,p*/Σ*Wc,p* ratio is equal to
1.


![](CUMULATE_asymptotic_knowledge_assessment_-_knowledge_growth.png "CUMULATE_asymptotic_knowledge_assessment_-_knowledge_growth.png")

(\[<http://chart.apis.google.com/chart?cht=lxy&chs=300x215&chd=t:0,10,20,30,40,50,60,70,80,90,100%7C0,42,56,72,79,83,85,87,88,90,92&chco=24588E&chxt=x,y&chxl=1>:\|0\|.2\|.4\|.6\|.8\|1\|0:\|0\|1\|2\|3\|4\|5\|6\|7\|8\|9\|10&chm=o,24588E,0,-1,10&chg=10,20&chtt=Growth+of+knowledge+level+vs.\|number+of+successful+attempts
alternatively\] via [Google Chart
API](http://code.google.com/apis/chart/))

=Criticism=
The major
drawback of the above
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="asymptotic knowledge assessment">asymptotic knowledge
assessment</a> algorithm is that it is intended to be used as
*one-fits-all* method not suitable for parametrization. Namely:
* the
initial knowledge level (*Ko*) can only start from 0
* the speed of
knowledge growth cannot be adjusted (e.g. slow for hard concepts, fast
for easy concepts)
* problem repetition penalty is not adjustable as
well
As a result modeling is done in the same way for all users solving
all problems. No special attention is given to individual user
differences and individual problem complexity.

One of the ways to
overcome these shortcomings is an attempt to create a
<a href="CUMULATE_parametrized_asymptotic_knowledge_assessment"
class="wikilink" title="parameterizable">parameterizable</a> version of
this algorithm.

= Contacts
=
<a href="User:Myudelson" class="wikilink" title=" Michael V. Yudelson">
Michael V. Yudelson</a>
