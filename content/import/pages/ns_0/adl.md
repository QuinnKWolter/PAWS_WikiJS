---
title: "ADL"
source_namespace: "ns_0"
source_filename: "ADL.md"
---

## Description


PAWS participation in ADL is focused in the development of
MasteryGrids system. Mastery Grids is a visual-rich, interactive,
adaptive E-learning platform with integrated functionalities enabling
multi-facet social comparison, open user modeling, and multi-type
learning materials support. It presents and compares user learning
progress and knowledge level (mastery) by colored grids, tracks user
activities and feedbacks dynamically and provides flexible user-centered
navigation across different content levels (e.g. topic, question) and
different content types (e.g. question, example) of learning
materials.
The architecture supporting Mastery Grids fulfills a major
objective, portability, which is the ability to be integrated to other
systems with little set up and modification. The architecture is modular
and includes different software components:

*frontend user-system
interaction interface, the
<a href="Mastery_Grids_Interface" class="wikilink"
title="Mastery Grids Interface">Mastery Grids Interface</a>,

*backend
***Aggregate*** services communicating between the main interface and
user modeling services,

*backend user modeling services,
and

*backend content providing applications.

An overall
architecture of the system can be sen in the next figure.


![](architecture_v1.png "architecture_v1.png")

#### Systems

###### Mastery Grids

[More](/ns_0/masterygrids)

###### Aggregate

[More](/ns_0/aggregate)

#### Learning Content

#### Authoring Tools

###### Content Authoring

This tool provides the interface for teachers to create and index
annotated examples.
[more](/ns_0/contentauthoring)

###### Course Authoring

This tool provides the interface for teachers to
create courses for Mastery Grids.
[more](/ns_0/courseauthoring)

###### Group Authoring

This tool provides the interface for teachers to
define groups of students who can access the course.
[more](/ns_0/groupauthoring)

#### Resources

Software sources and documentation is in GitHub. The
Mastery Grids Interface, backend Aggregate and documentation can be
found
[here](https://github.com/PAWSLabUniversityOfPittsburgh/MasteryGrids).
User model services can be found in
[here](https://github.com/PAWSLabUniversityOfPittsburgh/AggregateUMServices).

#### Publications

*Loboda, T., Guerra, J., Hosseini, R., and
Brusilovsky, P. (2014) Mastery Grids: An Open Source Social Educational
Progress Visualization. In: S. de Freitas, C. Rensing, P. J. Muñoz
Merino and T. Ley (eds.) Proceedings of 9th European Conference on
Technology Enhanced Learning (EC-TEL 2014), Graz, Austria, September
16-19, 2014 (Best paper award).
