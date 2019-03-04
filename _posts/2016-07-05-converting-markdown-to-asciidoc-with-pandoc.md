---
layout: post
title:  "Converting Markdown to AsciiDoc with Pandoc"
date:   2016-07-05 12:00:00 +0100
categories: jekyll update
---

I use Pandoc to convert Markdown to AsciiDoc like this:

```sh
pandoc -s --columns=80 --atx-headers -t asciidoc -o out.adoc in.md
```

Or, in long form:

```sh
pandoc --standalone --columns=80 --atx-headers --to=asciidoc --output=out.adoc in.md
```

There is no need to specify the input format because it [defaults to
Markdown](http://pandoc.org/getting-started.html), more specifically to Pandoc's
Markdown flavor.

`-s` or `--standalone` tells `pandoc` to produce a standalone file as output.

I set the columns to 80 explicitly, even though the `pandoc` man page claims
that that's the default. But if I don't do it, the paragraphs are in fact
wrapped after column 72. I'm sure there is a good explanation for this, but I do
not know it.

`--atx-headers` uses `=` signs to mark headers instead of underlining them.
