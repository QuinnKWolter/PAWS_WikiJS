---
title: "Open Corpus Personalized Learning"
source_namespace: "ns_0"
source_filename: "Open_Corpus_Personalized_Learning.md"
---

Goal: This project challenges the assumption that adaptive hypermedia
systems require expensive knowledge engineering for domain and content
modeling. It replaces carefully-crafted domain model with
automatically-created domain models, lowering the cost of developing
adaptive educational hypermedia software while also providing a wider
range of instructional paths through the content. Adaptive educational
hypermedia is known for its ability to improve learning outcomes and
engagement maximizing educational opportunity for learners with
different levels of knowledge. The development of this more automatic,
open-corpus approach to adaptive educational hypermedia will increase
the volume and the variety of resources available for meaningful online
learning, especially for individuals learning on their own. Automatic
knowledge indexing of educational content makes the system easy to
maintain and update over time. These new open corpus user modeling
techniques automatically adapt user models and personalized guidance to
new materials as they are acquired. The ability to automatically
organize, index, and adaptively recommend distributed educational
content without the need of manual processing by system developers,
enables new material to be integrated dynamically and with minimal
effort in response to student needs.

This project merges research on
text analysis, human learning, and personalization to enable open corpus
personalized learning. It develops its models of the domain and human
learning from an initial set of well-organized, manually selected
materials. Automatic text analysis creates an ensemble of domain models
with different characteristics. Each individual model may be flawed or
incomplete, however, collectively they provide comprehensive coverage of
the topic from several perspectives, thus reducing the manual effort
required to create adaptive educational hypermedia. Multiple
perspectives also give the system more flexibility in how to guide each
student. These domain models are used as a foundation for building and
maintaining dynamic models of user knowledge. The ensemble of domain and
user models is used to deliver reactive and proactive adaptive guidance
in an open corpus context. The growth of a person's knowledge is
inferred by observing learner behavior and obtaining occasional
feedback. This exploratory research opens the way to open corpus
personalized learning. The domain modeling, user modeling, and
personalization techniques developed in this research will be evaluated
using a multi-layer framework that includes assessment by subject
experts, performance prediction, cross-validation, and user
studies.

==The Project Team==



Image:Peter.jpg\|**<a href="User:Peterb" class="wikilink" title=" Peter Brusilovsky"> Peter
Brusilovsky</a>**
Director
Image:Daqing_He.png\|**[Daqing
He](http://www.pitt.edu/~dah44/)**
Co-director
Image:Yun_Acadamic.png\|[Yun
Huang](http://columbus.exp.sis.pitt.edu/yunhuang/index.htm)
Image:shuguang.png\|[Shuguang
Han](http://www.pitt.edu/~shh69/)
Image:rui.png\|[Rui
Meng](http://memray.me/)
Image:Sanqiang.png\|[Sanqiang
Zhao](http://pitt.edu/~sanqiang)
Image:Jordan.jpeg\|[Jordan
Barria-Pineda](http://pitt.edu/~jab464)
Image:Avatar.jpg\|[Hung
Chau](http://pitt.edu/~hkc6)
Image:k.thaker.png\|[Khushboo
Thaker](http://kthaker.com)





==Education Content Linking==
{\|
\|valign="top" \|
<a href="Image:Content-linking.png" class="wikilink"
title="thumb|left|100|Concepts Backbone connecting Educational Systems">thumb|left|<strong>100</strong>|Concepts
Backbone connecting Educational Systems</a>
\|valign="center"
\|
Digitization has brought a significant change to the educational
sector in the past ten years, making digital textbooks a convenient and
popular resource for learning. Starting as merely a digital copy of
paper textbooks, digital textbooks gradually integrated a number of
innovative and advanced functionality. Rapid digitization also
remarkably increased the volume of open learning resources, which have
grown very popular, providing learners with great opportunities to
expand their learning. Moreover, these new digital learning resources
could be combined with the traditional learning process. For example, a
learner may come across the concept of \`\`Indexing*while reading a
textbook on \`\`Information Retrieval*. This triggers her to engage
extra online materials on \`\`Indexing*to learn the state-of-the-art
practical methods or research trends.

The goal of the project is to
address this challenge by providing links to related content at
different textbook materials. In this project, we would like to use
concepts as a backbone for connecting different education materials.
This is a challenging task since textbooks and online materials are
written by different authors, for different audiences, and frequently
use different terms/words to express the same concepts. Furthermore,
many domains lack formal domain models or ontologies, where all domain
concepts are listed and organized. Therefore, the association of terms
and concepts, and the representation of concepts should be automatically
discovered and constructed.

To address these challenges, our work
applies distributed neural representations, which demonstrated an
ability to solve the term-mismatch problem by transferring the
representation of terms to an N-dimension continuous vector (also called
embedding). The expectation is that terms or words which share the same
semantic meaning will be nearer in this N-dimensional continuous vector
space.
\|}


==Knowledge Extraction==
{\|
\|valign="top" \|
<a href="Image:Knowledge-linking-Illustration.png" class="wikilink"
title="thumb|left|100|Dynamic Linking Textbooks">thumb|left|<strong>100</strong>|Dynamic
Linking Textbooks</a>
\|valign="center" \|
The Internet has
dramatically increased both the volume and variety of online educational
resources, such as online textbooks, online courses, and tutorials. The
development of modern search techniques has further promoted the quick
access of these resources. However, most of these educational resources
are not well-structured, which imposed an important challenge -- readers
without sufficient background knowledge may be difficult to understand
its content. To achieve the goal of recommending*the right content''
that matches individuals' knowledge levels, the first critical step is
to provide a better organization for educational resources. The project
visions two important components when organizing educational resources:
(1) knowledge concept extraction; and (2) concept hierarchy extraction.
Traditional solutions for these two problems heavily rely on experts'
manual efforts which are time-consuming and unscalable.

Our goal for
knowledge extraction is to provide a scalable solution for the above two
problems. We pilot our study with extracting knowledge structures from
textbooks since they provide a comprehensive list of concepts and are
often used as major educational resources in schools, colleges and
universities. In addition, textbooks are also equipped with structural
information such as table of contents and glossaries, which are very
helpful in identifying concepts and their relationships.


However,
the automated extraction of knowledge concepts. Accurately extracting
knowledge concepts from educational content is a challenge since the
miss of a large-scale knowledge concept labels for building reliable
machine learning algorithms. Considering the high time cost for
expert-based labeling, we explore an alternative crowdsourcing-based,
with restricted quality control, approach. That is, we distribute our
knowledge concept labeling work to massive crowdsourcing workers, and
further aggregate the obtained labels based on well-developed quality
control methods in crowdsourcing. So far, we have built our annotation
system and conducted several pilot studies. In the future, we would like
to conduct a live experiment to examine the validity of this
approach.
\|}

#### Learner Modeling

{\|
\|valign="top" \|
![**100**\|Dynamic Knowledge Modeling in Textbook
Reading](ReadingLearningProcess.png "100|Dynamic Knowledge Modeling in Textbook Reading")
\|valign="center"
\| We have recently proposed a data-driven framework for
<a href="Dynamic_Knowledge_Modeling_in_Textbook-Based_Learning"
class="wikilink"
title=" dynamic knowledge modeling in textbook-based learning"> dynamic
knowledge modeling in textbook-based learning</a> (UMAP 2016). We
formulated the problem of modeling learning from reading as a
reading-time prediction problem, reconstructed existing popular student
models (such as Knowledge Tracing) and explored two automatic text
analysis approaches (bag-of-words-based and latent semantic-based) to
build the KC model. This framework can be applied to a broader context
of open-corpus personalized learning, empowering learners with the
ability to access the right reading content at the right moment, despite
the huge volume of online educational content. We are also working on
applying <a href="Feature-Aware_Student_knowledge_Tracing_(FAST)"
class="wikilink"
title="Feature-Aware Student knowledge Tracing (FAST)">Feature-Aware
Student knowledge Tracing (FAST)</a> which is our new learner model
proposed in 2014 with state-of-the-art predictive performance into
textbook-based learning environment.

Over past years, our lab has
developed
[CUMULATE](/ns_0/cumulate), a
centralized user modeling server built for the
[ADAPT2](/ns_0/adapt2)
architecture, to provide user modeling support for adaptive educational
hypermedia (AEH) systems. We have proposed and implemented different
learner models , including
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="asymptotic assessment of user knowledge">asymptotic assessment of
user knowledge</a>. We have explored different aspects to improve
learner modeling, including reducing the content model, better
evaluation for practitioners and applying network (graph)
analysis.

*
<a href="Dynamic_Knowledge_Modeling_in_Textbook-Based_Learning"
class="wikilink"
title="More about dynamic knowledge modeling in textbook-based learning">More
about dynamic knowledge modeling in textbook-based learning</a>
*
<a href="Learner_Modeling" class="wikilink"
title="More about learner modeling">More about learner modeling</a>
*
<a href="Feature-Aware_Student_knowledge_Tracing_(FAST)"
class="wikilink"
title="More about Feature-Aware Student knowledge Tracing (FAST)">More
about Feature-Aware Student knowledge Tracing (FAST)</a>
*
<a href="CUMULATE" class="wikilink" title="More about CUMULATE">More
about CUMULATE</a>
*
<a href="CUMULATE_asymptotic_knowledge_assessment" class="wikilink"
title="More about asymptotic assessment of user knowledge">More about
asymptotic assessment of user knowledge</a>
\|}

==The Experimental
Platform==

In order to support students' learning in the classroom
environment, we have implemented a web platform for students to access
class materials including textbooks, research publications, web
tutorials, etc. More importantly, the system automatically records
users' reading behaviors in order to be able to build their student
models based on this data. By now, the reading system is able to render
material in two formats:
* Image-based
* HTML-based (not tested yet
in classroom studies)
We plan to support pdf document rendering
soon.

![The experimental Reading
System.](ReadingSystem_122016.jpg "The experimental Reading System.")

The
reading system is basically formed by 2 main parts:
* The reader
itself (see right side of the figure)
* The student reading data
section (see left side of the figure)

In the student reading data
section, the users can have access to two information sources. The first
one is a sunburst hierarchical visualization tool (see upper section)
that allows them to know their progress in the reading of the contents
that are associated with the course using a color scale encoding from
red (non-read) to green (totally read). The former version of this
visualization tool is called <a href="ReadingCircle" class="wikilink"
title="ReadingCircle">ReadingCircle</a>.
The second one (see lower
section) is the hierarchical index of the group, where each section
The
system is created for including learning material following a
hierarchical structure in a similar way as books are structured
(chapter, subchapter, section, etc.). In addition to this, the system
allows the inclusion of multiple choice questions at the end of each
section with the aim of test the acquired knowledge of the
students.

==Publications==
* Huang, Yun and Yudelson, Michael and
Han, Shuguang and He, Daqing and Brusilovsky, Peter. "A Framework for
Dynamic Knowledge Modeling in Textbook-Based Learning." In Proceedings
of the 2016 Conference on User Modeling Adaptation and Personalization,
pp. 141-150. ACM, 2016
([paper](http://d-scholarship.pitt.edu/28248/)).
* Meng, Rui and Han,
Shuguang and Huang, Yun and He, Daqing and Brusilovsky, Peter.
"Knowledge-based Content Linking for Online Textbooks." In Proceeding of
the 2016 IEEE/WIC/ACM International Conference on Web Intelligence, pp.
13-16. IEEE Computer Society, 2016.
([paper](http://d-scholarship.pitt.edu/30486/1/wi16-knowledge-linking.pdf)).
*
Meng, R., Zhao, S., Han, S., He, D., Brusilovsky, P., and Chi, Y. (2017)
Deep Keyphrase Generation. In: Proceedings of ACL2017, Annual Meeting of
the Association for Computational Linguistics, Vancouver, Canada, July
30-August 4, 2017 pp. 582-592.
* Labutov, I., Huang, Y., Brusilovsky,
P., and He, D. (2017) Semi-Supervised Techniques for Mining Learning
Outcomes and Prerequisites. In: Proceedings of the 23rd ACM SIGKDD
International Conference on Knowledge Discovery and Data Mining,
Halifax, NS, Canada, ACM, pp. 907-915.
* Thaker, K., Huang, Y.,
Brusilovsky, P., and He, D. (2018) Dynamic Knowledge Modeling with
Heterogeneous Activities for Adaptive Textbooks. In: Proceedings of the
11th International Conference on Educational Data Mining, Buffalo, USA,
July 15-18, 2018, pp. 592-595.
[paper](http://educationaldatamining.org/files/conferences/EDM2018/papers/EDM2018_paper_199.pdf)
*
Thaker, K. M., Brusilovsky, P., and He, D. (2018) Concept Enhanced
Content Representation for Linking Educational Resources. In:
Proceedings of 2018 IEEE/WIC/ACM International Conference on Web
Intelligence (WI), Santiago, Chile, December 3-6, 2018, IEEE, pp.
413-420.
* Barria-Pineda, J., Brusilovsky, P., and He, D. (2019)
Reading Mirror: Social Navigation and Social Comparison for Electronic
Textbooks. In: Proceedings of First Workshop on Intelligent Textbooks at
20th International Conference on Artificial Intelligence in Education
(AIED 2019), Chicago, USA, June 25, 2019, CEUR, pp. 30-37.
* Thaker,
K., Brusilovsky, P., and He, D. (2019) Student Modeling with Automatic
Knowledge Component Extraction for Adaptive Textbooks. In: Proceedings
of First Workshop on Intelligent Textbooks at 20th International
Conference on Artificial Intelligence in Education (AIED 2019), Chicago,
USA, June 25, 2019, CEUR, pp. 95-102.
* Thaker, K., Zhang, L., He, D.,
and Brusilovsky, P. (2020) Recommending Remedial Readings Using
Student’s Knowledge State. In: Proceedings of 13th International
Conference on Educational Data Mining, July 10-13, 2020, pp.
233-244.
* Yuan, X., Wang, T., Meng, R., Thaker, K., Brusilovsky, P.,
He, D., and Trischler, A. (2020) One Size Does Not Fit All: Generating
and Evaluating Variable Number of Keyphrases. In: D. Jurafsky, J. Chai,
N. Schluter and J. R. Tetreault (eds.) Proceedings of the 58th Annual
Meeting of the Association for Computational Linguistics, Online, July
5-10, 2020, Association for Computational Linguistics, pp.
7961-7975.
* Chau, H., Labutov, I., Thaker, K., He, D., and
Brusilovsky, P. (2021) Automatic Concept Extraction for Domain and
Student Modeling in Adaptive Textbooks. International Journal of
Artificial Intelligence in Education 31 (4), 820–846.
* Wang, M.,
Chau, H., Thaker, K., Brusilovsky, P., and He, D. (2022) Knowledge
Annotation for Intelligent Textbooks. Technology, Knowledge and
Learning, in press.
