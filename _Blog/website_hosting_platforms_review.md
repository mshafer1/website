---
layout: blog
title: "Website Hosting: A review of different options"
summary: "So you want to make a website. What type of hosting options is best for you?"
date: 2020-08-27 21:00:00 -0500
---

<style>
h3 {
    color: #F05F40;
}
</style>

## Disclaimer

All technologies and hosting platforms mentioned here have been used personally by either me or my wife. 
These are not sponsored mentions and are based upon my own experience with the hosting platform.

## Skip to End

If you just want a comparison table, <a href="#high-level-comparison">click here</a> to skip to the end.

## Background

I first started writing when I needed a way to store and publish information for fellow members in my local 4-H club (Aerospace and robotics). At this time, I had a Google account, and was aware that Google had a way to make websites, so that project was posted there.

## By time-line

### c. 2008: Google Sites

At this point, I was just beginning to try to host and share data via the web. Google Sites gave me basic templates that made it easy to put my articles and documents on the web and share them.

One important feature was that this was at no cost - I used a sites.google.com/site/... URL for each of these sites, and did not have to pay for hosting or for a domain name.

(more on this later)

### c. 2013: Google Drive

I'm not going to go into much detail here, as the technology has been officially shut down.

Around this time, I was interested in doing web development with interactive pages. Google Drive allowed me to host the html and JavaScript pages and (if the files were shared world-readable), load in a web browser using a Google drive share URL with a few tweaks.

Note: I received notification from Google that they were shutting down this option, but I have noticed that they do still render html files - but since URL is very complicated, I've moved on.

### c. 2014: CENG 250 - Web Development

Then came the semester that I took the Into to Web Development course at Harding University, giving me a formal introduction to HTML, JavaScript, PHP, and SQL (specifically MySQL).

### Summer 2014: Hosting24

Over the spring semester I had been working with the Harding Academy FRC team as a programming mentor. I had realized that we had been building design patterns and architectures that were beneficial in programming the robot, and that the lead programming I was working with would be graduating the next year. 

So, during that summer, I set out to write down what we had been learning and building in an easy to share method.

Here is where I purchased my first domain name (frclabviewtutorials.com), and here I wrote my first serious website (more than 3 pages, custom built menu, styling, mobile-responsive, etc.)

I chose Hosting24 when I did this because:

* They supported PHP
* They let me use a custom domain at no extra cost (for that matter, if I purchased the domain through them, it was effectively free with the hosting)
* They offered an option to setup SSL (or http<b>s</b>)
{: .checked_list}

The cost was $24/month - or (and I went this rout) $240/year (slightly cheaper)

### 2014-2016: More Hosting24

Over the next couple of years, when I had a project that was best suited to a website, or when asked to make a website. I started to learn a rule of them.

First question:
> Do you want to have pictures, text, and/or videos and convey information? Or do you want to have the user be able to enter data and have the page react.
> 
> ...
> 
> Text, pictures, and videos. - OK, I suggest you checkout Google Sites, or WordPress, or Tumblr - they make creating such sites easy, and you don't really need me.

On the rare occasion that they actually wanted user accounts, interactive, was probably going to need a database, I would take on the project and develop it in PHP and host it on Hosting24.

### 2016: Birth of ahkgen.com - learning about Git-hub Pages (GH-Pages)

In 2016, I got the idea that I could built a website to generate AutoHotkey code for common use cases (string replacement, typing a Unicode symbol, and opening a program/bringing to front).

I built what was the original prototype of what is now ahkgen.com in PHP with an HTML and JS front-end, then decided that I wanted to publish the tool, but I wasn't sure I wanted to pay for any more hosting for the PHP.

After some internet research, I learned that if your website is static (html, JavaScript, and CSS files) and checked into a GitHub repository, you can host your website for free (with a custom domain) via [GH-Pages](https://pages.github.com/).

With this newfound knowledge, I set to work translating my PHP code to generate the result page int JavaScript and launched [ahkgen.com](www.ahkgen.com)

Note: This makes <em>hosting</em> not cost anything on public repositories. I still have to purchase a domain name, and I connect the two up via a [CNAME record](https://en.wikipedia.org/wiki/CNAME_record).

### 2016-2019: Migration to GH-Pages with Jekyll

After building [ahkgen.com](www.ahkgen.com), I realized that the majority of my other sites were only using PHP for a server side include (not the official version of the technology) - and Jekyll ([the templating language powering GH-Pages](https://docs.github.com/en/github/working-with-github-pages/setting-up-a-github-pages-site-with-jekyll)) provided that ability in the static pages I could check into GitHub.

Over these next few years, I migrated past projects (most notably [frclabviewtutorials.com](www.frclabviewtutorials.com)) from Hosting24 to GH-Pages sites. Even [this blog](https://github.com/mshafer1/website) is hosted on GH-Pages

Note: by this point, the projects I had undertaken that needed databases, were dead, so those sites were just archived and shut down.

### 2017: Wedding photo up-loader - Self hosting

Throughout most of this, I've had a server setup in my living room running Apache2, and IIS on my Windows machine for dev testing. In preparation for our wedding in 2017, I built (using examples and PHP) a site that allowed visitors to upload image files. I setup the server so these were stored on a thumb drive, and during the wedding - told anyone I saw taking pictures on their phone, to just upload them there. (a few used this option).

Since then, I have used the fact that I have this server setup to do testing and throw up quick one-pages (like a web ui for my [sunrise alarm clock](/Projects/SunriseAlarmClock.html) or a stats sheet for my D&amp;D character).

### 2017: Exposure to Wix.com

Mikayla also setup a site for our wedding - it was the go to spot to RSVP and for directions to the venue and similar.

She built it using Wix - and let me play with it a little (add some details, copy the color scheme for the photo up-loader)

Wix offered:
* Free hosting of text/images
* Easy to use
* Template for a scrolling information page
* yoursite.wix.com domain (full custom domain is available via paid plans)
{: .checked_list}
(and probably more, this is just what we used)

### c. 2018: Rebirth of Google Sites

In the years since I've started coding my own websites, Google Sites has undergone a complete rebuild. This became apparent when the First Robotics team ([#6321](https://www.rouserobotics.com/)) that I was working with now chose it as their hosting platform for their team site. - While I was not heavily involved in the build of the site, I did wind up interacting with the interface as I helped them get a domain name hooked up and saw that it was the modernized tool I would want for a simple and easy website builder.

### 2019: Exposure to [Tumblr](https://www.tumblr.com/)

Mikayla and I run a D&amp;D group (well, she runs it, I play and help make sure we have food planned), and she chose [tumblr.com](https://www.tumblr.com/) to host the adventure log with session recaps and the various maps and other illustrations she's made. She's had me help her customize the html in the template she's using a little bit, but if you're not doing something weird (like - menu cross-linking two sites like we were), their standard templates should have you covered.

[Tumblr](https://www.tumblr.com/) offers:
* Password protection - useful if you want specific people (say, friends or family) to have access to the contents
* Drag and drop interface
* Lots of templates
* Mobile responsiveness
* yoursite.tumblr.com URL (mostly custom domain -I think they do offer true custom domains, on a paid teir)
{: .checked_list}
(and probably more, but that's what I can say after messing with it to help with the cross-linking)

### 2019: Moving beyond static sites again - the birth of [passagepredictor.com](passagepredictor.com)

This summer, I had an idea for a project that I thought would be widely adopted (this has yet to happen, but the learning experience has been good, and I have a reasonable amount of use out of it).

But to do this, I was going to need:
* User accounts
* A database
* A hosting platform that let's me run these (i.e. Not a static site)

And most importantly
* Build it in Python - for automated testing

(I had hacked together testing frameworks for my earlier PHP projects, but I knew a lot more about how good testing is done, and that I needed a language that supported unit testing to do this)

So, I learned [Django](https://www.djangoproject.com/) (at least enough to get this project working).

That took care of the user accounts, database, and building it in Python (yes, I built tests on my model and view-model as I went).

But (at least at that time), Hosting24 did not support Python hosting, so I asked a few colleagues for recommendations, and spent some time Googling. In the end, I went with [DigitalOcean](https://m.do.co/c/e62a2722d8d4) for a couple of reasons:
1. Price point (at $5/month for my server + $1/month for weekly backups, this was one of the cheapest I had suggested)
1. Referral program - I was able to try it for free for my first month (and let my colleague that referred me get a month of hosting free). After trying it, I liked the interface and knew it solved all of my current needs
1. Documentation - They have [a lot of documentation](https://www.digitalocean.com/community/tutorials/how-to-serve-django-applications-with-uwsgi-and-nginx-on-ubuntu-16-04) on their Community, and during my trial when I ran into an issue and posted on their Questions board - I got a quick (like 24 hr) response from actual employees that resolved my issue.
1. Being a Virtual Private Server (VPS) - I have full control, and was able to setup deployment flows from my source repo and setup an email system (so password reset emails would actually go out).

## High Level Comparison

|                                                                      | Google Drive | Tumblr  | Google Sites | Wix.Com | WordPress | GH-Pages | Hosting24 | Self Hosting | Digital Ocean |
| -------------------------------------------------------------------- | ------------ | ------- | ------------ | ------- | --------- | -------- | --------- | ------------ | ------------- |
| Active                                                               | ×            |         |              |         |           |          |           |              |               |
| Easy to use (for non-programmers)                                    |              | ✓       | ✓           | ✓       | ✓         |          |           |              |               |
| Hosts Pictures, text, and/or videos                                  |              | ✓       |  ✓          | ✓       | ✓         | ✓        | ✓         | ✓            | ✓             |
| Templates for lots of different types of sites                       |              | ✓       |  ✓          | ✓       | ✓         | ✓        |           |              |               |
| Plug-ins for adding functionality (built into platform)              |              |         |              |         | ✓         | ✓        |           |              |               |
| Free custom domain (e.g. yoursite.host.com) (for connecting to site) |              | ✓       |  ✓          | ✓       | ✓         | ✓        | ✓         |              |               |
| Free full custom domain (e.g. yoursite.com) (for connecting to site) |              |         |              |         |           | ✓        | ✓         | ✓            | ✓             |
| Highly customizable (without coding)                                 |              | ✓       |  ✓          | ✓       | ✓         |          |           |              |               |
| Even more customizable (requires coding)                             |              | ✓       |              |         | ✓         | ✓        | ✓         | ✓            | ✓             |
| Allows for user accounts                                             |              |         |              |         | ✓         |          | ✓         | ✓            | ✓             |
| High up time guarantee                                               |              | ✓       |  ✓          | ✓       | ✓         | ✓        | ✓         |              | ✓             |
| Customizable back-end (database, logging, doing server side scripts) |              |         |              |         |           |          | ✓         | ✓            | ✓             |
{: .table}
