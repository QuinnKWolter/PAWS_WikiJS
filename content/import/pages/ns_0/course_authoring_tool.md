---
title: "Course Authoring Tool"
source_namespace: "ns_0"
source_filename: "Course_Authoring_Tool.md"
---

Course authoring tool is an intuitive, highly integrated application for
teaching material aggregation and editing. It allows the user to form
the structure of a course, browse and select the activities from the
resource pool and fill in the structure with appropriate examples and
quizzes. The architecture supporting course authoring tool has a good
support on multiple resource repositories, which is extremely convenient
for future extending.

It contains software components as
follows:
* Front-end user-system interaction interface, the tool’s
interface
* Back-end communication APIs
* Back-end aggregates
*
Back-end content providing applications (content brokering)

The
interface of the course authoring tool uses color cues and drag
interaction methods to ease the process of editing.
Communication APIs
provides the program interface for the JavaScript to use AJAX, which
will allow the user to perform all the operations in one webpage.
The
content providing applications are the main access for course authoring
tool to list out the available content for the user.

Here is the
interface for Course List
Panel:

<img src="../../media/images/other/CourseAuthoringCourseList.jpg"
title="CourseAuthoringCourseList.jpg" width="750" height="1400"
alt="CourseAuthoringCourseList.jpg" />


Here is the interface for
Course Info Panel:

<img src="../../media/images/other/CourseAuthoringCourseInfo.jpg"
title="CourseAuthoringCourseInfo.jpg" width="750" height="1400"
alt="CourseAuthoringCourseInfo.jpg" />

#### Resources

* Source
codes are available in GitHub in
[here](https://github.com/PAWSLabUniversityOfPittsburgh/mastery-grids/tree/master/course-authoring).
*
<a href="Media:CourseAuthoringManualV3.pdf" class="wikilink"
title="Course Authoring Tool Manual">Course Authoring Tool Manual</a>
