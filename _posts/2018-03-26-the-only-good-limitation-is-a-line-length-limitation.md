---
layout: post
title: "The Only Good Limitation Is a Line Length Limitation"
date: 2018-03-26 12:00:00 +0100
tags: [Code Style]
---

There is an issue that might seem somewhat moot and negligible to many at first
glance, but that keeps reoccurring and bothering me in my software developer
life. The issue is line length limitations in code and by collating my thoughts
on the topic I'll try and come up with a convincing argument that they matter
indeed more than some might think.

Let's take a brief discussion on Stack Overflow to get started. It was elicited
in the comments to a [question about how to set the maximum line length for
Python code in
PyCharm](https://stackoverflow.com/questions/17319422/how-do-i-set-the-maximum-line-length-in-pycharm).
One user rightfully raised the mildly indicting question why JetBrains decided
to set the default position for hard wraps in PyCharm to 120 characters, even
though PEP8 unambiguously instructs to limit "[all lines to a maximum of 79
characters](https://www.python.org/dev/peps/pep-0008/#maximum-line-length)".

In response, others argued that this part of PEP8 would be deprecated today,
dating back to a time where it was the norm to work on terminals with a physical
limitation of 80 characters that could be displayed on a line. I have heard this
or similar arguments from fellow developers often enough and I have seen team
mates (who were way more capable than I am in many respects), committing lines
of code with well over 200 characters without wrapping. It seems to me that
there is a wide spread belief that narrow, or even any line length limitations
in coding style guides would be a relic of the ancient past, totally obsolete in
today's world of wide high resolution displays. It might be clear by now that I
ardently disagree.

There is a good practical argument in defense of the PEP8 style line length
limitation. As some point out in the aforementioned Stack Overflow comment
thread, in a project that adheres to the 79 character limit, you can easily view
up to three files next to each other on today's displays, which can be very
handy. Similarly, side-by-side views offered by `diff` tools become much less
readable if dealing with code files where long lines force you to scroll
horizontally in order to absorb the whole content. Along the same lines, IDEs
like PyCharm or Visual Studio Code are equipped with a wealth of tool views that
provide insights into different aspects of a project. Or if you prefer the
minimalist ways of coding in Vim or Emacs, you can still make much better use of
the horizontal screen space by, for example, having API docs side by side with
your code. The bottom line is, that if, and only if you don't need all your
screen space to fit code with excessive line lengths on it, you can make far
better use of that screen real estate in one or the other way.

While this practical objection to the abolishment of a rather narrow line length
limitation is valid and important in itself, in my opinion, the stance deeming
those limitations deprecated is a fallacy that actually points to a deeper
issue. Namely a lack of appreciation what exactly coding style and readability
are about at their core: programming as a _human_ activity.

So, the more profound argument why line limitations are still very relevant and
important is a purely aesthetic one and as such conceptually entirely
independent of any changes in display technology whatsoever. I don't intend to
deny that their is some degree of reciprocity between the presented content and
the medium it is presented in. But conceptually, they are strictly distinct.

Aesthetics is, among other things, about proportions; and while the task of
determining "aesthetic" proportions is probably not an exact science, those
proportions aren't arbitrary either.

[The Zen of Python](https://www.python.org/dev/peps/pep-0020/) states that

> Beautiful is better than ugly.

and

> Readability counts.

The reason why the aesthetic aspect of Python code is so prominently featured
(and even enforced by the language to some degree by using indentation as part
of the syntax) [is the insight, that code is being read more often than it is
being
written](https://www.python.org/dev/peps/pep-0008/#a-foolish-consistency-is-the-hobgoblin-of-little-minds).
Code that merely "works" is not enough, because coding is not just about telling
the machine what to do, but also about communicating to other human beings what
the code is supposed to instruct the machine to do. This is not a new idea, of
course. For example, it was expressed in Donald E. Knuths concept of [literate
programming](https://en.wikipedia.org/wiki/Literate_programming). Or in Gerald
Weinbergs 1971 classic [The Psychology of Computer
Programming](https://leanpub.com/thepsychologyofcomputerprogramming) (_emphasis
added by me_):

> A programmer would not really be a programmer who did not at some time
> consider his program as an aesthetic object. This part is not quite
> symmetrical; that part is clumsy and doesn't flow in an appropriate manner;
> **the whole thing does not look proper on the page**. To be sure, it is
> fashionable among programmers to be rough and tough and pragmatic, but deep
> down each programmer knows it is not enough for a program just to work–it has
> to be "right" in other ways. [...] **[We] shall see that the correlation
> between the esthetic and the pragmatic value of a program is not
> accidental—the more pleasing to the eye and mind, the more likely to be
> correct.** Or, put more poetically, "Beauty is truth, truth beauty."

In [Clean
Code](https://books.google.de/books/about/Clean_Code.html?id=hjEFCAAAQBAJ),
Robert C. Martin ("Uncle Bob") describes how the content of a source file should
be structured:

> Think of a well-written newspaper article. You read it vertically. At the top
> you expect a headline that will tell you what the story is about and allows
> you to decide whether it is something you want to read. The first paragraph
> gives you a synopsis of the whole story, hiding all the details while giving
> you the broad-brush concepts. As you continue downward, the details increase
> until you have all the dates, names, quotes, claims, and other minutia.
>
> We would like a source file to be like a newspaper article. The name should be
> simple but explanatory. The name, by itself, should be sufficient to tell us
> whether we are in the right module or not. The topmost parts of the source
> file should provide the high-level concepts and algorithms. Detail should
> increase as we move downward, until at the end we find the lowest level
> functions and details in the source file.

Incidentally this newspaper analogy also tells us something about code
formatting. Newspaper articles are being typeset in pretty narrow columns, even
though the paper they are printed on would allow for far wider lines of text.
Similarly, book pages are printed in what's called "portrait orientation" in
printer software settings and not in "landscape orientation". The reason is
simple: _because that way the content is pleasant and easy to be absorbed by the
information processing apparatus that is constituted by the combination of the
human eye and mind!_

In terms of "human language"[^human-language] text you can easily verify this
claim by opening a long Wikipedia article in a browser in full screen mode on a
wide display and then switching to the "Reader View" that modern browsers like
Firefox or Safari offer. You'll notice that they'll render the text in a
relatively narrow column instead of the full width layout Wikipedia uses for
Desktop browsers by default.

Line length limitations are really about aesthetic proportions, not about what a
display can or cannot physically do. And the parameters of those aesthetic
proportions are primarily determined by the human perception of the content, not
by the medium the content is presented in. Therefore, what constitutes well
formatted code does not change much, whether it's presented on a 1980s terminal,
an HD or 4K display or on a piece of paper.

Of course I'm not arguing that every code ever written should never exceed 80
characters per line. 100 or 120 characters or even wider lines might work for
you and your team. I'm merely trying to say that this issue has relevance and
does often not get recognized enough. Then again, yeah, okay, let's be honest,
truly beautiful code does not exceed 80 characters per line. 😏

[^human-language]: I'm putting "human language" in quotes, because "programming
    languages" are, of course, no less "human" than any other language, but I'm
    lacking a better term.
