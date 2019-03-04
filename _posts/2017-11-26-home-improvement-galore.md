---
layout: post
title:  "$HOME Improvement Galore"
date:   2017-11-26 12:00:00 +0100
categories: jekyll update
---

To distract myself from the sometimes slightly dull things that just need to be
done in life, I recently embarked on an exciting quest to advance my basic tools
configuration foundation. Some of the things I discovered during that journey
are appealing and satisfying enough for me to be worthy of being recorded here.

I started tracking a subset of my configuration files in a private git
repository a while ago, but recently became dissatisfied with my simplistic
approach to the matter. For every host I use I created a directory in the
repository and used symbolic links to hook the configuration files (or dotfiles)
into place.

The symbolic links approach is fine and common practice as I know now (well, it
is a pretty obvious thing to do, isn't it), but I had a considerable amount of
duplication going on that became increasingly itchy. This was because, like I
said, I had a directory for every host and each contained a Vim configuration, a
git configuration and so on.

Determined to remedy this mess I started snooping around and quickly came ashore
a great [compilation of articles and tools](https://dotfiles.github.io) about
dotfile management. The one article listed there that I found particularly
inspiring was [the one by Anish
Athalye](http://www.anishathalye.com/2014/08/03/managing-your-dotfiles/), where
he explains:

> Most likely, as a developer, you will keep using and improving your dotfiles
> for your entire career. Your dotfiles will most likely be the longest project
> you ever work on. For this reason, it is worthwhile to organize your dotfiles
> project in a disciplined manner for maintainability and extensibility.

If this isn't a great motivation to clear the decks for action, I don't know
what could be. I was motivated anyway, but it was a welcome reinsurance that I'm
spending my time sensibly. Besides that, my three main takeaways from that
article are:

1. The stance that it's great to share your configuration files, but not so
   great to just fork other people's configurations and use them as is, like a
   tool. Instead dotfiles should be carefully forged to perfectly reflect your
   individual preferences.
2. The basic idea to add local (as in per host) customization to the generic
   configuration files, which solves the duplication problem. I'll come back to
   this in a bit.
3. The insight that, as always, there's no need to reinvent the wheel. There are
   already great tools for dotfiles management available.

One of these tools, [Dotbot](https://github.com/anishathalye/dotbot), authored
by Athalye, is among the most popular ones, judging by it's GitHub stars. He
mentions a whole bunch of other tools, too. One of them is
[Homesick](https://github.com/technicalpickles/homesick), which I ended up
using, just because it was the first one I had a closer look at and
spontaneously liked it so much that I just stuck with it. A third interesting
option seems to be [RCM](https://github.com/thoughtbot/rcm).

Homesick is a Ruby gem and it acts by and large as a front end for git. It also
makes the process of creating the symbolic links to hook the configuration files
in the repository (called a _castle_ in Homesick's terminology) into the
according places in your home directory very convenient. The README explains
everything you need to know in order to use it as concisely and comprehensibly
as it gets, so no need to repeat anything of it here.

One particular feature of Homesick is the `.homesickrc` file. You can put any
valid Ruby code there and then execute it with `homesick rc`. This mechanism is
for situations that demand a slightly more sophisticated take than bluntly
creating symbolic links. I use this for the kind of local customization I
mentioned in item two of the list further up. For example, my generic
`.gitconfig` contains this bit that I adopted from Athalye's article:

```ini
[include]
  path = ~/.gitconfig_local
```

I also placed a file called `.gitconfig_macos` next to the `.homesickrc` in my
_castle_. It has the following content, which tells git to use the macOS key
chain for storing credentials:

```ini
[credential]
  helper = osxkeychain
```

When I'm on a Linux machine though, I obviously don't want git to be silly and
try to use the macOS key chain. I want my generic `.gitconfig` to be OS
agnostic. But how do I load the OS specific stuff then? That's where aforesaid
`.homesickrc` comes into play! It contains a bit like this:

```ruby
require 'os'

if OS.mac?
  gitconfig_macos = Dir.getwd + "/.gitconfig_macos"
  gitconfig_local = Dir.home + "/.gitconfig_local"
  FileUtils.cp(gitconfig_macos, gitconfig_local)
end
```

With this in place, I can run `homesick rc` on any machine where I pulled my
_castle_ and rest assured that my git configuration will only be customized for
macOS if I am actually on a macOS host. Neat!

Another thing I do with this mechanism is installing `vim-plug`, but only if
it's not already there, to ensure that the `homesick rc` command is
non-destructive:

```ruby
vim_plug_path = Dir.home + "/.vim/autoload/plug.vim"
unless File.exist?(vim_plug_path)
  curl = "curl -fLo " + vim_plug_path + " --create-dirs"
  url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  cmd = curl + " " + url
  system(cmd)
end
```

And I use a similar mechanism to customize my [fish
shell](https://fishshell.com) configuration in an OS specific way:

```bash
set workDir (dirname (status -f))
switch (uname)
  case Darwin
    source $workDir"/config.macos.fish"
  case Linux
    source $workDir"/config.linux.fish"
end
```

On a side note, speaking of fish: in the course of my home improvement journey I
started using [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish) with the
[bobthefish theme](https://github.com/oh-my-fish/theme-bobthefish). To make
`bobthefish` look as great as it's supposed to, you need a so called powerline
enabled font. I spent some time trying a bouquet of those fonts until I stumbled
across the [Hack font](http://sourcefoundry.org/hack/) and immediately knew the
search was over. Since I use it as my terminal font my terminal looks so
gorgeous that I wonder how I could ever have lived without it.

I aim at keeping my [dotfile repository aka
castle](https://github.com/anothernode/dotfiles) minimal, tidy and
self-explanatory. There's not that much in it so far, but for sure I'll add bits
and pieces to it over the next 30+ years and I feel like I have a solid
foundation for that now. 😌
