---
layout: blog
title: "Google Drive: A Simple option for hosting high resolution photos for your website"
summary: "Lot's of free hosting website tools drastically decrease the resolution of images you upload to them, but with Google Drive you can get the full resolution version into your site."
date: 2020-05-23 21:00:00 -0500
---

* foo
{:toc}

## Background:

Several years ago, I was just getting started on web development and learned how to host a static web site on Google Drive at no extra cost. This feature has been removed, but Google Drive still lets you upload your full resolution photos (and with a little know-how) you can get your website builder to pull it in.

## Steps:

* Upload your photo to Google Drive

* Make sure anyone can access it <b>by link</b><br/>(this is important, as you don't want to force people viewing your website/blog to log into Google drive and ask you to share the photo with them)

* Get the shareable link<br/>
  (It will look something like this: `https://drive.google.com/file/d/19Srm3BZkMAs1FH_u2GTVerU3MmfxnsdS/view?usp=sharing`)

* Take the long (seemingly random) part out of the middle (between the `file/d/` and the `/view`) - that is the ID of the file.
    In this case: `19Srm3BZkMAs1FH_u2GTVerU3MmfxnsdS`

* Insert that into a new URL (replace the `{ID}`):
    `https://drive.google.com/uc?id={ID}`
    
    In our example, that gives us: `https://drive.google.com/uc?id=19Srm3BZkMAs1FH_u2GTVerU3MmfxnsdS`

* If your site host let's you give it a URL for the image to display, you're done. If not, read the section below on building an html image (`img`) tag.

## Building an html image (`img`) tag

Some website hosts won't let you insert an image from a URL, but will let you edit the html directly (this may be called "html mode" or "advanced mode").

* Basic: 
    <br/>
    Insert `<img src="{URL}" />` replacing `{URL}` with the result from the previous section.

* Controlling size:
    <br/>
    Insert `<img src="{URL}" style="width:{width}px; height: auto;"/>` replacing `{URL}` with the result from the previous section and `{width}` with some number to control the size (I suggest starting with 200, and then going up or down based on how that looks vs what you want).

    Example: `<img src="https://drive.google.com/uc?id=19Srm3BZkMAs1FH_u2GTVerU3MmfxnsdS" style="width:250px; height: auto;"/>`

    Output:
    <img src="https://drive.google.com/uc?id=19Srm3BZkMAs1FH_u2GTVerU3MmfxnsdS" style="width:250px; height: auto;"/>


    What does the `style="..."` do?

    * In html, specifying a style [attribute](https://www.w3schools.com/tags/att_style.asp){:target="_blank"} allows us to apply some more rules to the look of an object
    * the `width: {width}px;` part tells the browser to show this image `{width}` pixels wide.
    * the `height: auto;` part tells the browser to keep the original aspect ratio.

There are lots of other options for controlling how an image renders in html (including placement), but these are the basics. I suggest you check out [W3 School's How To tutorial](https://www.w3schools.com/howto/howto_css_image_center.asp){:target="_blank"} for more html and image controls.