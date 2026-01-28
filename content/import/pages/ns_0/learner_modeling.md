---
title: "Learner Modeling"
source_namespace: "ns_0"
source_filename: "Learner_Modeling.md"
---

## CUMULATE


###### Introduction

CUMULATE (Centralized User Modeling Architecture
for TEaching) is a central user modeling server
designed to provide
user modeling functionality to a student-adaptive educational system. It
collects evidence (events) about student learning from multiple servers
that interact with the student. It stores students' activities and
infers their learning characteristics, which are the basis for an
individual adaptation to them. ... External and internal inference
agents process the flow of events and update the values in the inference
model of the server. Each inference agent is responsible for maintaining
a specific property in the inference model, such as the current
motivation level of the student or the student's current level of
knowledge for each course topic.
[==&gt; more](/ns_0/cumulate)

###### Publications

<onlyinclude>
* Zadorozhny, V.,
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


#### Asymptotic Assessment of User Knowledge

Asymptotic knowledge
assessment is CUMULATE's legacy user modeling algorithm for computing
user knowledge with respect to problem-solving. This is the current main
learner model actively deployed in our educational systems. A more
advanced one has been proposed to create a parameterizable version of
this algorithm.
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="==&gt; more">==&gt; more</a>

#### Feature-Aware Student Knowledge Tracing (FAST)

###### Introduction

Feature-Aware Student
knowledge Tracing (FAST) is a novel, efficient student model created by
PAWs lab and Pearson with the state-of-the-art predictive performance.
It allows general, flexible features into [Knowledge
Tracing](http://liris.cnrs.fr/~pchampin/2014/m2iade-ia2/_static/893CorbettAnderson1995.pdf),
which is the most popular student model. For the first time it unifies
existed specially designed student models based on Knowledge Tracing
framework with integrated advantages. We demonstrate FAST’s flexibility
with examples of feature sets that are relevant to a wide audience: we
haved uses features in FAST to model (i) multiple subskills, (ii)
temporal Item Response Theory, and (iii) expert knowledge. Compared with
Knowledge Tracing, (1) it improves up to 25% in classification
performance, (2) it generates more interpretable, consistent parameters,
and (3) it is 300 times faster. In a [follow-up
study](http://adenu.ia.uned.es/workshops/pale2014/pale2014_proceedings_vol1181.pdf#page=9),
we compared FAST to the best paper model (a single-purpose model) of the
same year with favorable results while FAST is designed as a
general-purpose model. The [main
paper](http://educationaldatamining.org/EDM2014/uploads/procs2014/long%20papers/84_EDM-2014-Full.pdf)
was nominated for the Best Paper Award in a top-tier conference in 2014.
Both the main and the follow-up papers were cited by top researchers in
the field from Carnegie Mellon University, Stanford, Cornell, ETH Zurich
(etc.) with in total 34 citations since 2014 (till 04/2016).
<a href="Feature-Aware_Student_knowledge_Tracing_(FAST)"
class="wikilink" title="==&gt; more">==&gt; more</a>

###### Publications

* Gonzalez-Brenes, J. P., Huang, Y., and Brusilovsky, P. (2013)
FAST: Feature-Aware Student Knowledge Tracing. In: Proceedings of NIPS
2013 Workshop on Data Driven Education, Lake Tahoe, NV, December 10,
2013,
([paper](http://d-scholarship.pitt.edu/20353/))
*González-Brenes, J.
P., Huang, Y., and Brusilovsky, P. (2014) General Features in Knowledge
Tracing to Model Multiple Subskills, Temporal Item Response Theory, and
Expert Knowledge. In: J. Stamper, Z. Pardos, M. Mavrikis and B. M.
McLaren (eds.) Proceedings of the 7th International Conference on
Educational Data Mining (EDM 2014), London, UK, July 4-7, 2014, pp.
84-91. (First two authors contributed equally. Nominated for Best Paper
Award)
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
Sahebi, S., Huang, Y., and Brusilovsky, P. (2014) Parameterized
Exercises in Java Programming: Using Knowledge Structure for Performance
Prediction. In: Proceedings of The second Workshop on AI-supported
Education for Computer Science (AIEDCS) at 12th International Conference
on Intelligent Tutoring Systems ITS 2014, Honolulu, Hawaii, June 6 2014.
([paper](http://d-scholarship.pitt.edu/21915/))([presentation](http://www.slideshare.net/chagh/parameterized-exercises-in-java-programming-using-knowledge-structure-for-performance-prediction))
*
Huang, Y., González-Brenes, J. P., and Brusilovsky, P. (2015) The FAST
toolkit for Unsupervised Learning of HMMs with Features. In: The Machine
Learning Open Source Software workshop at the 32nd International
Conference on Machine Learning (ICML-MLOSS 2015), Lille, France July 10,
2015.
([paper](http://d-scholarship.pitt.edu/26043/)[code](http://mloss.org/software/view/609/))
*
Huang, Y., González-Brenes, J. P., Kumar, R., Brusilovsky, P. (2015) A
Framework for Multifaceted Evaluation of Student Models. In: Proceedings
of the 8th International Conference on Educational Data Mining (EDM
2015), Madrid, Spain, pp. 203-210.
([paper](http://www.educationaldatamining.org/EDM2015/uploads/papers/paper_164.pdf))
([presentation](http://www.slideshare.net/huangyun/2015edm-a-framework-for-multifaceted-evaluation-of-student-models-polygon))

#### Dynamic Knowledge Modeling in Textbook-Based Learning

###### Introduction

Various e-learning systems that provide electronic
textbooks are gathering data on large numbers of student reading
interactions. This data can potentially be used to model student
knowledge acquisition. However, reading activity is often overlooked in
canonical student modeling. Prior studies modeling learning from reading
either estimate student knowledge at the end of all reading activities,
or use quiz performance data with expert-crafted knowledge components
(KCs). In this work, we demonstrate that the dynamic modeling of student
knowledge is feasible and that automatic text analysis can be applied to
save expert effort. We propose a data-driven approach for dynamic
student modeling in textbook-based learning. We formulate the problem of
modeling learning from reading as a reading- time prediction problem,
reconstruct existing popular student models (such as Knowledge Tracing)
and explore two automatic text analysis approaches (bag-of-words-based
and latent semantic-based) to build the KC model. We evaluate the
proposed framework using a dataset collected from a Human-Computer
Interaction course. Results show that our approach for reading modeling
is plausible; the pro- posed Knowledge Tracing-based student model
reliably outperforms baselines and the latent semantic-based approach
can be a promising way to construct a KC model. Serving as the first
step to model dynamic knowledge in textbook- based learning, our
framework can be applied to a broader context of open-corpus
personalized learning.
<a href="Dynamic_Knowledge_Modeling_in_Textbook-Based_Learning"
class="wikilink" title="==&gt; more">==&gt; more</a>

###### Publications

* Huang, Yun, Michael Yudelson, Shuguang Han, Daqing He, and Peter
Brusilovsky. "A Framework for Dynamic Knowledge Modeling in
Textbook-Based Learning." In Proceedings of the 2016 Conference on User
Modeling Adaptation and Personalization, pp. 141-150. ACM, 2016.
([paper](http://columbus.exp.sis.pitt.edu/yunhuang/papers/UMAP16.pdf))
([presentation](http://www.slideshare.net/huangyun/umap16-a-framework-for-dynamic-knowledge-modeling-in-textbookbased-learning))

#### Multifaceted Evaluation of Learner Models

We have proposed two
state-of-the-art frameworks for evaluating student models in a
data-driven manner for practitioners: the Polygon framework, and the
Learner Effort-Outcomes Paradigm. We also explored challenges of using
observational data to answer research question such as determine the
importance of example usage.

###### Polygon framework

Latent
variable models, such as the popular Knowledge Tracing method, are often
used to enable adaptive tutoring systems to personalize education.
However, finding optimal model parameters is usually a difficult
non-convex optimization problem when considering latent variable models.
Prior work has reported that latent variable models obtained from
educational data vary in their predictive performance, plausibility, and
consistency. Unfortunately, there are still no unified quantitative
measurements of these properties. This paper suggests a general unified
framework (that we call Polygon) for multifaceted evaluation of student
models. The framework takes all three dimensions mentioned above into
consideration and offers novel metrics for the quantitative comparison
of different student models. These properties affect the effectiveness
of the tutoring experience in a way that traditional predictive
performance metrics fall short. The present work demonstrates our
methodology of comparing Knowledge Tracing with a recent model called
<a href="Feature-Aware_Student_knowledge_Tracing_(FAST)"
class="wikilink"
title="Feature-Aware Student knowledge Tracing (FAST)">Feature-Aware
Student knowledge Tracing (FAST)</a> on datasets from different tutoring
systems. Our analysis suggests that FAST generally improves on Knowledge
Tracing along all dimensions
studied.

<img src="../../media/images/other/Polygon.jpg" title="Polygon.jpg" width="800" height="1600"
alt="Polygon.jpg" />

###### Learner Effort-Outcomes Paradigm (Leopard)

Classification evaluation metrics are often used to evaluate
adaptive tutoring systems— programs that teach and adapt to humans.
Unfortunately, it is not clear how intuitive these metrics are for
practitioners with little machine learning background. Moreover, our
experiments suggest that existing convention for evaluating tutoring
systems may lead to suboptimal decisions. We propose the Learner
Effort-Outcomes Paradigm (Leopard), a new framework to evaluate adaptive
tutoring. We introduce Teal and White, novel automatic metrics that
apply Leopard and quantify the amount of effort required to achieve a
learning outcome. Our experiments suggest that our metrics are a better
alternative for evaluating adaptive
tutoring.

<img src="Leopard.png" title="Leopard.png" width="500" height="300"
alt="Leopard.png" />

###### Publications

* Huang, Y.,
González-Brenes, J. P., Kumar, R., Brusilovsky, P. (2015) A Framework
for Multifaceted Evaluation of Student Models. In: Proceedings of the
8th International Conference on Educational Data Mining (EDM 2015),
Madrid, Spain, pp. 203-210.
([paper](http://www.educationaldatamining.org/EDM2015/uploads/papers/paper_164.pdf))
([presentation](http://www.slideshare.net/huangyun/2015edm-a-framework-for-multifaceted-evaluation-of-student-models-polygon))
*
Huang, Y., González-Brenes, J. P., Brusilovsky, P. (2015) Challenges of
Using Observational Data to Determine the Importance of Example Usage.
In: Proceedings of the 17th International Conference on Artificial
Intelligence in Education (AIED 2015), Madrid, Spain, pp. 633-637.
([paper](http://d-scholarship.pitt.edu/26056/))
* Gonzalez-Brenes, J.
P., Huang, Y. (2014) The White Method: Towards Automatic Evaluation
Metrics for Adaptive Tutoring Systems. In: Proceedings of NIPS 2014
Workshop on Human Propelled Machine Learning, Montreal, Canada, December
13, 2014 ([paper](http://d-scholarship.pitt.edu/26061/))
*
Gonzalez-Brenes, J. P., Huang, Y. (2015) Your model is predictive— but
is it useful? Theoretical and Empirical Considerations of a New Paradigm
for Adaptive Tutoring Evaluation. In: Proceedings of the 8th
International Conference on Educational Data Mining (EDM 2015), Madrid,
Spain, pp. 187-194. ([paper](http://d-scholarship.pitt.edu/26046/)
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

#### Hierarchical Integration Skill Modeling

###### Introduction

This work explores
the problem of modeling student knowledge in complex learning activities
where multiple skills are required at the same time, such as in the
programming domain. In such cases, it is not clear how the evidence of
student performance translates to individual skills. As a result,
traditional approaches to knowledge modeling, such as Knowledge Tracing
(KT), which traces students’ knowledge of each decomposed individual
skill, might fall short. We argue that skill combinations might carry
extra specific knowledge, and mastery should be asserted only when a
student can fluently apply skills in combination with other skills in
different contexts. We propose a data-driven framework to model skill
combination patterns for tracing students’ deeper knowledge. We
automatically identify significant skill combinations from data and
construct a conjunctive knowledge model with a hierarchical skill
representation based on a Bayesian Network. We also propose a novel
evaluation framework primarily focuses on the knowledge inference
quality, since we argue that traditional prediction metrics no longer
suffice to differentiate between shallow and deep knowledge modeling.
Our experiments on datasets collected from two programming learning
systems show that proposed model significantly increases mastery
inference accuracy and tends to more reasonably distribute students’
efforts comparing with traditional KT models and its nonhierarchical
counterparts. Our work serves as a first step towards building skill
application context sensitive model for modeling students’ deep, robust
learning.

###### Publications

* Huang, Y., Guerra-Hollstein, J.,
and Brusilovsky, P. Modeling Skill Combination Patterns for Deeper
Knowledge Tracing. In: The 6th Intl. Workshop on Personalization
Approaches in Learning Environments (PALE 2016) in the 24th Conf. on
User Modeling, Adaptation and Personalization (UMAP 2016).
([paper](http://ceur-ws.org/Vol-1618/PALE4.pdf))

#### Content Model Reduction for Better Learner Models

###### Introduction

When
modeling student knowledge and predicting student performance, adaptive
educational systems frequently rely on content models that connect
learning content (i.e., problems) with its underlying domain knowledge
(i.e., knowledge components, KCs) required to complete it. In some
domains, such as programming, the number of KCs associated with advanced
learning contents is quite large. It complicates modeling due to
increasing noise and decreases efficiency. We argue that the efficiency
of modeling and prediction in such domains could be improved without the
loss of quality by reducing problems content models to a subset of most
important KCs. To prove this hypothesis, we evaluate several KC
reduction methods varying reduction size by assessing the prediction
performance of Knowledge Tracing and Performance Factor Analysis. The
results show that the predictive performance using reduced content
models can be significantly better than using original one, with extra
benefits of reducing time and space.

###### Publications

* Huang,
Y., Xu, Y., and Brusilovsky, P. (2014) Doing More with Less: Student
Modeling and Performance Prediction with Reduced Content Models. In: V.
Dimitrova, et al. (eds.) Proceedings of 22nd Conference on User
Modeling, Adaptation and Personalization (UMAP 2014), Aalborg, Denmark,
July 7-11, 2014, Springer Verlag, pp. 338-349.
([presentation](http://www.slideshare.net/pbrusilovsky/umap-v1)[paper](http://link.springer.com/chapter/10.1007%2F978-3-319-08786-3_30))


#### Graph Analysis of Learner Models

###### Introduction

This work
explores the feasibility of a graph-based approach to model student
knowledge in the domain of programming. The key idea of this approach is
that programming concepts are truly learned not in isolation, but rather
in combination with other concepts. Following this idea, we represent a
student model as a graph where links are gradually added when the
student's ability to work with connected pairs of concepts in the same
context is confirmed. We also hypothesize that with this graph-based
approach a number of traditional graph metrics could be used to better
measure student knowledge than using more traditional scalar models of
student knowledge. To collect some early evidence in favor of this idea,
we used data from several classroom studies to correlate graph metrics
with various performance and motivation metrics.

###### Publications

* Guerra, J., Huang, Y., Hosseini, R., & Brusilovsky, P. (2015,
June). Graph Analysis of Student Model Networks. In Proceedings of the
Second International Workshop on Graph-Based Educational Data Mining
(GEDM 2015). CEUR-WS.
([paper](https://d-scholarship.pitt.edu/secure/25933/1/graph_analysis.pdf))
([presentation](http://www.slideshare.net/mallium/graph-analysis-of-student-model-networks))
