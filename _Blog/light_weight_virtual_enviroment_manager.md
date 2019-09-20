---
layout: blog
title: Lightweight Python Virtual Env Manager
img: workon_files/virtualenv.jpeg
summary: A utility script for managing virtual env's
---

# Background

Python Developers, ever wanted an easier way to create or activate multiple different virtual environments?
This is something that has plagued me for sometime.

One option that has been developed and works ok is [Anaconda](https://www.anaconda.com/distribution/){:target="_blank"}, but that does not work well with internal Pip packages or install packages from source.

An alternative I came across a couple of months ago in a [tutorial on setting up Django](https://www.digitalocean.com/community/tutorials/how-to-serve-django-applications-with-uwsgi-and-nginx-on-ubuntu-16-04){:target="_blank"} written by [DigitalOcean](https://m.do.co/c/e62a2722d8d4){:target="_blank"}, has you setup a test repo and a production repo and create an alias `workon` that takes a parameter for activating the correct virtual environment.

Why not make `workon` able to make a venv?

## Setup

To make coding this easier, I put a file named `workon.bat` in a directory that I have added to my PATH variable (in my case, `c:\bin` - a place where I store similar utilities), this makes typing `workon` on the command line call this script.

## Overview

At a high level, the script should:

* accept an argument
    
    if none is provided, print useage information and exit
    
    else, store that name


* Check if there is a folder locally by that name
    
    if so, call `%1\scripts\activate` to activate the venv

* Check if there is one in a "global" folder (which I made a config variable at the top of the script)
    if so, call `%_envs_root%\%1\scripts\activate` to activate it.

* If it does not exist in either location, then we need to create it. 

  I've opted to have it prompt (Y/n) to ask for local vs global, aftwards it makes the venv, and activates it and exits.

## Code

<link rel="stylesheet" href="/css/highlight/styles/darcula.css">
<script src="/css/highlight/highlight.pack.js"></script>
<script>hljs.initHighlightingOnLoad();</script>
<div>
<pre>
<code id="codeTarget" class="cmd">
</code>
</pre>

<script>
    var target = document.getElementById("codeTarget");

// use JS encode URI to html escape the code.

target.innerHTML = escape_html(String.raw`{% include_relative workon_files/workon.bat %}`);

</script>

</div>


(Download: <a href="workon_files/workon.bat" download>Click Here</a>)