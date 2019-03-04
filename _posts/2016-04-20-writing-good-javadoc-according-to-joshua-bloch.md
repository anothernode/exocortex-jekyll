---
layout: post
title: "Writing Good Javadoc According to Joshua Bloch"
date: 2016-04-20 12:00:00 +0100
tags: [Java]
---

In one of the items of his canonical book *Effective Java* Joshua Bloch
describes what's necessary to keep in mind in order to write meaningful Javadoc
comments.

It's quite detailed, so whenever I want to write some Javadoc I find myself
searching and skimming the appropriate item (it's *Item 44: Write doc comments
for all exposed API elements*) to refresh my porous memory. After doing this a
couple of times it became too annoying. So, for my future reference, I decided
to compile a very brief and condensed summary of the aspects expressed there
that matter most to me. Maybe it can be useful for others, too. But it's by no
means meant to substitute a careful reading of Bloch's original text.

The first and golden rule is: Write a doc comment for *every* exported element.
No exceptions, no excuses! And remember that you are writing those Javadoc
comments not just for yourself but also for your present and future fellow
programmers. So try to be nice to them. They will be full of eternal gratitude
if one of your Javadoc comments ever helps them to get their job done.

The following recommendations apply to all types of doc comments.

* **When using HTML meta characters that are not inside a
  `{@code}` tag already, they must be surrounded with a `{@literal}` tag**. It
  has the same effect, but without rendering the content with a monospaced font.
* **Take care that the doc comment looks good in the source and as rendered
  documentation.** If that's really not achievable, readability in the rendered
  version is more important.
* **The first sentence of a doc comment represents the summary description.** It
  has to stand on its own describing the functionality of the respective
  element. **No two members of a class or interface may have the same summary
  description.** Pay particular attention to this rule when documenting
  overloaded methods or constructors. The summary description should usually not
  be a grammatically full sentence.
  * Instead, for a class, interface or field the summary description should be a
    **noun phrase describing what's represented by the field or an instance of
    the class or interface**.
  * And for a method or constructor, the summary description should be a **verb
    phrase describing the action it performs**.

When writing doc comments for methods, the following aspects are important to
keep in mind.

* A methods doc comment should **describe its contract with the caller**. This
  contract is about *what* the method does, not *how* it does it.
* The comment should **enumerate the method's pre- and postconditions and
  describe its side effects**.
* There should be **a `@param` tag for every parameter, a `@throws` tag for
  every exception thrown, and `@return` tag for the return type**, if it's not
  `void`.
* By convention the word 'this' in an instance method's doc comment refers to
  the object the method is invoked on.

Here's an [example from Google's Guava
library](https://github.com/google/guava/blob/80dad6bf149f9b8d66e4db4436034cf6b7018398/guava/src/com/google/common/io/Files.java)
that nicely illustrates most of the above:

<!-- markdownlint-disable MD013 -->

```java
/**
 * Reads all of the lines from a file. The lines do not include line-termination characters, but
 * do include other leading and trailing whitespace.
 *
 * <p>This method returns a mutable {@code List}. For an {@code ImmutableList}, use
 * {@code Files.asCharSource(file, charset).readLines()}.
 *
 * @param file the file to read from
 * @param charset the charset used to decode the input stream; see {@link StandardCharsets} for
 *     helpful predefined constants
 * @return a mutable {@link List} containing all the lines
 * @throws IOException if an I/O error occurs
 */
public static List<String> readLines(File file, Charset charset) throws IOException {
  [...]
}
```

<!-- markdwonlint-enable MD013 -->

And here are a few more things to keep in mind:

* Don't forget to document all type parameters when writing a comment for a
  generic type or method.
* The comment for an enum type should contain documentation of the type, the
  constants and the public methods.
* An annotation type's comment should document the type itself and all of it's
  members.
