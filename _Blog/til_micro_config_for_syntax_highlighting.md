---
layout: blog
title: "TIL: How to set Micro text editor to apply a filetype for a particular file."
summary: >
    Turns out it's pretty easy to tell Micro text editor to treat a particular file as yaml (or other syntax)
date: 2026-01-17 8:00:00 -0500
---

# Background

In the world of Linux, the battle of which text editor to use is probably only rivaled by which distro to use.
Micro is one text editor that I use because I appreciate the syntax highlighting and some of the "more familiar" key bindings (like, save is ctrl-s).

# How to tell Micro to treat the current file as a format

Micro does (by default) examine the filename that you are editing to determine a default syntax scheme; so, if the filename ends with ".json" (for example), it will apply a json based syntax highlighting. However, I frequently find myself editing files that don't have an extension but adhere to a schema. One example of this is my `/etc/ansible/hosts` file which I use the `yaml` layout in (Ansible supports a few different formats in this file, I use yaml so I can have indentation for grouping and comments).

Today I looked up how to tell Micro "hey, this file is yaml" so that it would syntax highlight correctly and know to have "ctrl /" comment/uncomment the line with the correct syntax (in yaml, prepend the line with a `#`). 

What I was looking for boils down to:

> To set the file type,:
> - Press Ctrl-E to activate the command bar
> - Enter the command `set filetype yaml` (or replace `yaml` with whatever the desired type is)
> - Press the enter key
> 
> \- [The Micro documentation][1]

# TIL: How to set the filetype permanently

Since I searched how to do this online, my search results also suggested that I could set it permanently by specifying the filetype in my config file:

`~/.config/micro/settings.json`
```json
{
    "/etc/ansible/hosts": {
        "filetype": "yaml"
    }
}
```

[reference][2]

**NOTE**: 
> Which `~/` should I edit if I need to `sudo ` to edit the file?

I found that I had to put this in `root`'s `.config` folder for it to take effect when I use `sudo micro /etc/ansible/hosts`


[1]: https://github.com/zyedidia/micro/blob/master/runtime/help/options.md "Micro documentation"
[2]: https://github.com/zyedidia/micro/issues/2080 "GitHub issue asking this question"
