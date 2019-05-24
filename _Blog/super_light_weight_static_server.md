---
layout: blog
title: Super Lightweight Static Web Server
img: flaskFiles/logo.png
summary: A quick and dirty python script to serve up it's current directory as a webserver through Flask
---

# Background

There have been a couple of times when I wanted to just quickly pull up a directory as a web site and check that I had the files laid out correctly before pushing them to the main server.

I have had to do this so often, that part of setting up a new machine for me is to install a web server [IIS](https://www.howtogeek.com/112455/how-to-install-iis-8-on-windows-8/){:target="_blank"} when on Windows, and with [Apache2](https://www.linode.com/docs/web-servers/lamp/install-lamp-stack-on-ubuntu-16-04/){:target="_blank"} or [Nginx](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-16-04){:target="_blank"} when on Linux.

However, this doesn't usually work well for anyone trying to help me on a project temporarily.

I recently learned about the Python [Flask](http://flask.pocoo.org/){:target="_blank"} module that can act as a droplet server with little to no configuration.

Shout out to [Adam Sommer](https://codepen.io/asommer70/post/serving-a-static-directory-with-flask){:target="_blank"} for the initial proof of concept - what I have presented below is a slightly improved version from his post.

# Setup
* Install Flask
  
  `pip install flask`

* Download the source
* Put it in the root of your website (next to index.html)
* Run `python3 quick_flask.py` (may also work with Python2 still, but untested)
* Open browser to http://localhost:5000 (or whatever the address the output gives you)

* Code:

<link rel="stylesheet" href="/css/highlight/styles/darcula.css">
<script src="/css/highlight/highlight.pack.js"></script>
<script>hljs.initHighlightingOnLoad();</script>
<div>
<pre>
<code id="codeTarget" class="python">
</code>
</pre>

<script>
    var target = document.getElementById("codeTarget");

// use JS encode URI to html escape the code.

target.innerHTML = escape_html(`{% include_relative flaskFiles/quick_flask.py %}`);

</script>

</div>



(Download: <a href="flaskFiles/quick_flask.py" download>Click Here</a>)