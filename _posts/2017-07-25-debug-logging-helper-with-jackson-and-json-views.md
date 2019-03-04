---
layout: post
title: "Debug Logging Helper with Jackson and JSON Views"
date: 2017-07-25 12:00:00 +0100
tags: [Java, JSON]
---

During development I sometimes find it handy to put debug logging statements in
my code that output whole object structures as JSON strings to see what an
object looks like at certain points in the code execution. Of course I could use
the debugger to inspect those objects, but at times I find using the console for
debug output more convenient. Also, using the debugger is not possible if it's
necessary to reproduce a problem that only occurs in an environment different
from your debugger equipped IDE, like inside a docker container.

So, in order to make outputting an object as easy as possible, I create a method
that uses the Jackson library to generate a JSON representation for any object
that it's given:

```java
package com.anothernode.example;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public final class LoggingHelper {

  private static Logger logger =
      LoggerFactory.getLogger(LoggingHelper.class);

  public static String getJsonRepresentation(Object object) {
    ObjectWriter writer = new ObjectMapper()
        .writer()
        .withDefaultPrettyPrinter();
    String representation = "JSON representation of ["
        + object.getClass().getSimpleName()
        + "] object:\n";
    try {
      representation += writer.writeValueAsString(object);
    } catch (JsonProcessingException e) {
      logger.error("Creating JSON representation for an object failed");
    }
    return representation;
  }
}

```

Not very exciting, I guess. The problem with this is though, that there might be
data in the object that is not suitable for printing it out to a console, like
in my case up to a few megabyte large files represented as Base64 encoded
strings that would render the output virtually useless by cluttering the console
or log file with huge amounts of garbage in terms of human readability.

In order to still make use of the helper method, what's needed is a way to
exclude fields of objects from getting included in the JSON string
representation. The easiest, least invasive and most elegant way I found to do
this is using [JSON Views](http://wiki.fasterxml.com/JacksonJsonViews) and
that's what I found interesting enough to take a note about here.

In the simplest case, where you are not using JSON Views already in your
project, you only have to take a few easy steps to exclude fields from the
generated JSON representations. First, you need to add a marker class like this
one to your project:

```java
package com.anothernode.example.json;

public class View {

  private View() {}

  public static interface ExcludedFromLogging {}

}
```

With the marker in place you can then mark fields with it in any domain classes
you might want to output:

```java
package com.anothernode.example.domain;

class Foo {

  @JsonView(View.ExcludedFromLogging.class)
  private String bar;

  private String baz;

  [...]
}
```

Now all that's left to do is changing the `ObjectWriter` creation in the
`LoggingHelper.getJsonRepresentation(Object object)` method like this:

```java
public static String getJsonRepresentation(Object object) {
  ObjectWriter writer = new ObjectMapper()
      .writerWithView(Object.class)
      .withDefaultPrettyPrinter();
  [...]
}
```

Henceforth the field `Foo.bar` will not show up in any JSON representation of
`Foo` generated with the `LoggingHelper.getJsonRepresentation(Object object)`
method.

This approach exploits the fact that the JSON Views API has a default view that
includes everything that is _not_ part of any explicitly defined view. We use
that default view by giving `Object.class` as an parameter into the
`writerWithView()` method.

So by adding the field `Foo.bar` to the view `ExcludedFromLogging`, we
effectively blacklist it from the default view. If you are using JSON Views
already for something different in the project, you possibly might not be able
to use the default view as described here. That's because every field that is
part of any view would be excluded from the default view, which might not be
what you want.

But of course in this situation it would still be possible to flip this around
and use an `IncludedInLogging` view instead. This `IncludedInLogging.class`
Would then have to be passed to `writerWithView()` instead of `Object.class`.
This means probably a bit more work though because every field that should be
included in the JSON representation would then have to be white listed by
marking it with the `IncludedInLogging` view.

JSON Views are surely also very useful for many other use cases and they seem to
be [well supported by
Spring](https://spring.io/blog/2014/12/02/latest-jackson-integration-improvements-in-spring),
too.
