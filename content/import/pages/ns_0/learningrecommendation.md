---
title: "LearningRecommendation"
source_namespace: "ns_0"
source_filename: "LearningRecommendation.md"
---

In this section we explain some of the recommender approaches that has
been developed and used in Mastery Grids.

#### ProActive Recommendations

These recommender systems require no trigger. They
are represented in Mastery Grids interface as stars on the topic and
learning resources. The size of star shows the importance (weight) of
recommended material. Two recommender systems has been implemented in
this setting: Adaptive Sequencing, and Probabilistic Outspread
approaches.
Adaptive sequencing is a greedy sequencing approach aimed
at maximizing each student’s level of knowledge and activities. The
learning material are ranked by balancing the knowledge level of each
student in the prerequisite concepts of the learning material with the
knowledge that can be gained from the outcome concepts.
The
probabilistic outspread approach aims to select the learning material
that increases the probability of the student solving all of the quizzes
in the course. It uses FAST as its underlying probabilistic model of
student's knowledge and performance.

#### ReActive Recommendations

These recommendations occur only when student fails in solving a
question correctly in Mastery Grids. The student is going to be
suggested some examples that can help the student acquire the skills
needed to solve the original question.

The following images show
example line recommendation and learning resource recommendation in
Mastery Grids.

Example line
recommendation:

<img src="../../media/images/other/ExampleLineRecommendation.png"
title="ExampleLineRecommendation.png" width="325" height="650"
alt="ExampleLineRecommendation.png" />


Learning Resource
Recommendation:


<img src="../../media/images/other/StarRecommendation.png" title="StarRecommendation.png"
width="325" height="650" alt="StarRecommendation.png" />
