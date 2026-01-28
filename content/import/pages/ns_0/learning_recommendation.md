---
title: "Learning Recommendation"
source_namespace: "ns_0"
source_filename: "Learning_Recommendation.md"
---

In this section we explain some of the recommender approaches that has
been developed and used in Mastery Grids.

#### ProActive Recommendation

These recommender systems require no trigger. They are represented
in Mastery Grids interface as stars on the topic and learning resources.
The size of star shows the importance (weight) of recommended material.
Two recommender systems has been implemented in this setting: Adaptive
Sequencing, and Probabilistic Outspread approaches.
Adaptive sequencing
is a greedy sequencing approach aimed at maximizing each student’s level
of knowledge and activities. The learning material are ranked by
balancing the knowledge level of each student in the prerequisite
concepts of the learning material with the knowledge that can be gained
from the outcome concepts.
The probabilistic outspread approach aims to
select the learning material that increases the probability of the
student solving all of the quizzes in the course. It uses FAST as its
underlying probabilistic model of student's knowledge and performance.


<img src="../../media/images/other/StarRecommendation.png" title="StarRecommendation.png"
width="325" height="650" alt="StarRecommendation.png" />

#### ReActive Recommendation

These recommendations occur only when student fails
in solving a question correctly in Mastery Grids. The student is going
to be suggested some examples that can help the student acquire the
skills needed to solve the original
question.

<img src="../../media/images/other/Reactive_rec.jpg" title="Reactive_rec.jpg" width="700"
height="600" alt="Reactive_rec.jpg" />


#### Recommendations inside Examples

The goal of this work was to extend WebEx with more
advanced knowledge-based link annotation that could guide users to the
most appropriate lines by showing how much knowledge about the concepts
presented in each line the user already mastered. The new functionality
was made feasible by two intelligent technologies: the ability to
automatically identify programming concepts associated with each line of
code using concept parser and dynamic student model that maintains the
current level of student knowledge for each concept. Using the current
level of knowledge for concepts associated with each line, we can
calculate how much knowledge associated with each line is already known
to the learner. We expected that visualizing this dynamically (i.e.,
displaying the amount of knowledge as a visual cue next to the line)
could help users to select most important lines. We also wanted to
directly recommend most important lines to explore to the
user.

<img src="../../media/images/other/ANS_example.jpg" title="ANS_example.jpg" width="600"
height="500" alt="ANS_example.jpg" />

#### Publications

*
Hosseini, R., Brusilovsky, P., and Guerra, J. (2013) Knowledge
Maximizer: Concept-based Adaptive Problem Sequencing for Exam
Preparation. In: Proceedings of the 16th International Conference on
Artificial Intelligence in Education (AIED 2013), Memphis, USA, pp.
848-851.
([paper](https://d-scholarship.pitt.edu/secure/26271/4/AIED2013-camera-ready-Knowledge_maximizer_.pdf))
([poster](http://www.slideshare.net/RoyaHosseini1/aied-2013))
*
Brusilovsky, P. (2014) Addictive Links: Engaging Students through
Adaptive Navigation Support and Open Social Student Modeling (Keynote
talk). In: Proceedings of WWW 2014 Workshop on Web-based Education
Technologies, Seoul, Korea, April 8, 2014.
([presentation](http://www.slideshare.net/pbrusilovsky/addictive-links-keynote-talk-at-www-2014-workshop))
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
([paper](https://d-scholarship.pitt.edu/secure/26266/1/camera_ready.pdf))([presentation](http://www.slideshare.net/RoyaHosseini1/ectel-2015)).
