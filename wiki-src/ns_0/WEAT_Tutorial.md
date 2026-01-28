The **Worked Example Authoring Tool (WEAT)** is an innovative tool
designed to facilitate the creation of worked examples for programming
education through a *human-AI collaboration* approach. By integrating
ChatGPT, WEAT assists instructors in generating line-by-line
explanations for code examples in Java and Python. Instructors can
provide the code and problem statement, and WEAT uses ChatGPT to
generate explanations for each line of code. These explanations can then
be reviewed, edited, and added into the worked examples, streamlining
the process of creating educational programming materials.\n\nThis tool
consists of three important pages:\n\n

\n

<li>

**Sources**, a source is a
<a href="PCEX" class="wikilink" title="PCEX">PCEX</a> example or
challenge; which has a title, problem description, and line-by-line
annotated source code.

</li>

\n

<li>

**Activities**, an activity is a bundle of multiple sources either as an
example or challenge.

</li>

\n

<li>

**Hub**, is where all publicly available activities are listed which can
be searched by title, used, or embedded within your tool (through
iframe).

</li>

\n

</ol>

\n\nAfter opening the [<u>PCEX Authoring
Tool</u>](http://adapt2.sis.pitt.edu/pcex-authoring/) ([Video
Tutorial](https://youtu.be/IOfA0Ql3Zq0)), you will land on the *Hub*
page. Click **Login**, provide your account credentials and login into
the tool. Then you will be redirected back to the *Hub*
page.\n\n<img src="weat_image8.png" title="weat_image8.png" width="768"
alt="weat_image8.png" />\n\nFig 1) PCEX Authoring Tool: Hub
Page.\n\n<span id="sources"></span>\n= Sources =\n\nIn the *Hub* page,
click on the navbar, then click on "Sources" to navigate to *Sources*
page.\n\n<img src="weat_image21.png" title="weat_image21.png" width="768"
alt="weat_image21.png" />\n\nFig 2) PCEX Authoring Tool: Hub Page - when
user is logged in.\n\nThis page contains the list of sources you have
created. Click "**New Source**" to create a new
source.\n\n<img src="weat_image18.png" title="weat_image18.png" width="768"
alt="weat_image18.png" />\n\nFig 3) PCEX Authoring Tool: List of defined
sources.\n\nA source has a title, problem description, and line-by-line
annotated source code. Problem description can have multilines. Each
line in the source code can be annotated either by providing
explanations for it and/or marked as blank
line.\n\n<img src="weat_image23.png" title="weat_image23.png" width="768"
alt="weat_image23.png" />\n\nFig 4) PCEX Authoring Tool: Creating a
source (e.g: Hello World!).\n\nIn a PCEX challenge, a blank line creates
a parson-style problem that can be filled by the student with available
distractors (check Figure 5). A distractor can be defined in the
"**Distractors**" section when creating or editing a
source.\n\n<img src="weat_image1.png" title="weat_image1.png" width="768"
alt="weat_image1.png" />\n\nFig 5) PCEX Authoring Tool: A PCEX challenge
preview.\n\n<img src="weat_image25.png" title="weat_image25.png" width="768"
alt="weat_image25.png" />\n\nFig 6) PCEX Authoring Tool: Define
distractors (bottom section) for blank lines.\n\nExplanations for
important lines of code can be generated using the *gpt-3.5-turbo*
model. Clicking on the "**Generate Explanations**" button will generate
explanations using the default prompt. Newly generated explanations will
be appended to the line and are distinguished with orange border color
(check Figure 7).\n\nNext to the "**Generate Explanations**" button,
there is the
<img src="weat_image9.png" title="weat_image9.png" width="48"
height="40" alt="weat_image9.png" />history and
<img src="weat_image6.png" title="weat_image6.png" width="44"
height="40" alt="weat_image6.png" /> custom prompt toggle buttons.
Clicking on the
<img src="weat_image9.png" title="weat_image9.png" width="48"
height="40" alt="weat_image9.png" /> button will show the previously
generated explanations (check Figure 7) for this source. While clicking
on the <img src="weat_image6.png" title="weat_image6.png" width="44"
height="40" alt="weat_image6.png" /> provide the ability to customize
the ChatGPT prompt (check Figure 7).\n\nAs described in the user
interface, these explanations can be dragged by the bars into the
Annotations panel to be used/added to the currently selected line (check
Figure 8). By default, previously generated explanations for the
currently selected line are shown; click the "**show all lines**" to
show all generated explanations. In the history panel click on another
date/time to load explanations specific to that generation
session.\n\n<img src="weat_image26.jpg" title="weat_image26.jpg" width="768"
alt="weat_image26.jpg" />\n\nFig 7) Source Editor: ChatGPT
Generated-Explanations
(History).\n\n<img src="weat_image22.png" title="weat_image22.png" width="768"
alt="weat_image22.png" />\n\nFig 8) Source Editor: Dragging previously
generated explanations from history into the Annotations panel.\n\nIn
Figure 7, the ChatGPT prompt can be viewed. This is the default prompt
used by the tool when "**Generate Explanations**" is clicked. If by any
reason, it requires any change, you can change the color-marked
sections. After customizing the prompt, click "**Generate
Explanations**" to generate the explanations.\n\nIn the Annotations
panel, explanations can be dragged by the bars. Drag and drop an
explanation on another explanation to change their order, or hold
"**alt**" key while dropping to append/merge them together, or drop the
explanation on to the red trash can area to remove it (you will be asked
to confirm this action since it is
irreversible).\n\n<img src="weat_image20.png" title="weat_image20.png" width="768"
alt="weat_image20.png" />\n\nFig 9) Source Editor: Drag explanations to
reorder, merge or remove.\n\nIn case you want to merge, cut, copy, or
delete multiple explanations, click on the
<img src="weat_image12.png" title="weat_image12.png" width="33"
height="30" alt="weat_image12.png" /> button to see more actions. Select
explanations by clicking either the "**Select**" (to start the
selection, then click on
the<img src="weat_image15.png" title="weat_image15.png" width="22"
height="20" alt="weat_image15.png" />checkboxes next to explanations to
select), or "**Select all**" to select all the explanations. Then you
can cut, copy, and delete the selected
explanations.\n\n<img src="weat_image19.png" title="weat_image19.png" width="768"
alt="weat_image19.png" />\n\nFig 10) Source Editor: Annotations panel
more actions.\n\n<span id="activities"></span>\n= Activities =\n\nThis
page contains the list of activities you have created. Click "**New
Activity**" to create a new
activity.\n\n<img src="weat_image7.png" title="weat_image7.png" width="768"
alt="weat_image7.png" />\n\nFig 11) PCEX Authoring Tool: List of defined
activities.\n\nAn activity contains one or more sources, either as an
example or challenge.\n\nAfter creating/updating a source or activity,
click the preview button to ensure the activity is processed (/cached)
and can be previewed by students
later.\n\n<img src="weat_image16.png" title="weat_image16.png" width="768"
alt="weat_image16.png" />\n\nFig 12) PCEX Authoring Tool: Creating an
activity(e.g: HelloWorld!).\n\n<span id="hub"></span>\n= Hub =\n\nThis
page lists all publicly shared activities by different authors. You can
click on the title to preview the activity, or click the open-in-new-tab
icon next to the title to open it in a new tab (this url can be embedded
in an iframe within your
tools)\n\n<img src="weat_image8.png" title="weat_image8.png" width="768"
alt="weat_image8.png" />\n\nFig 13) PCEX Authoring Tool: Hub
Page.\n\n<img src="weat_image4.png" title="weat_image4.png" width="768"
alt="weat_image4.png" />\n\nFig 14) PCEX Authoring Tool: Activity
Preview.\n\n<span id="icons-and-symbols"></span>\n= Icons and Symbols
=\n\nThe following icons are used within this tool, and you need to
familiarize yourself with them.\n\n{\|\n\|
<img src="weat_image2.png" title="weat_image2.png" width="49"
height="48" alt="weat_image2.png" />\n\| In the source editor, this
question mark marks the lines that have at least one
explanation.\n\|-\n\|
<img src="weat_image14.png" title="weat_image14.png" width="54"
height="47" alt="weat_image14.png" />\n\| In the source editors, this
blue-empty square marks the lines that are marked as blank.\n\|-\n\|
<img src="weat_image11.png" title="weat_image11.png" width="54"
height="51" alt="weat_image11.png" />\n\| In the source editors, this
symbol marks the lines that are marked as blank and also have at least
one explanation.\n\|-\n\|
<img src="weat_image3.png" title="weat_image3.png" width="48"
height="45" alt="weat_image3.png" />\n\| In the source editor, this
symbol can be used to drag explanations for reordering, or
merging.\n\|-\n\|
<img src="weat_image10.png" title="weat_image10.png" width="49"
height="44" alt="weat_image10.png" />\n\| Clicking on this icon in the
activities and sources listings will toggle the item's archiving
status.\n\|-\n\|
<img src="weat_image13.png" title="weat_image13.png" width="43"
height="37" alt="weat_image13.png" />\n\| Clicking on this icon in the
activities and sources listings will preview the item.\n\|-\n\|
<img src="weat_image17.png" title="weat_image17.png" width="44"
height="45" alt="weat_image17.png" />\n\| Clicking on this icon in the
activities listing will toggle the item's publicity status (in the Hub
page).\n\|}
