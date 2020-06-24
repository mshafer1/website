---
layout: project
title: Time Focuser
img: timeFocuserFiles/appointment-new.svg # from https://www.1001freedownloads.com/free-clipart/tango-appointment-new
category: AHK
tags: Raspberry-Pi-0 Python Circuits Maker
---


I have found at times in my life that I spend way too much time on YouTube or related sites. Clicking on the next interesting (or not really) video, because I just didn't want to get to work. However, it always happens that when I intended to spend 5 minutes (or 30 minutes) that I look at the clock after a while and realize it has been 2 hours (or more)!

I chose to write a script using [AutoHotkey](http://www.autohotkey.com){:target="_blank"} to help me keep better track of my time.

The basic concept is to use a `WinWaitActive` followed by a `WinWaitNotActive` with a timeout to start a timer when I open the page, but let the script continue once I've spent long enough on the page.
<div>
<pre>
<code class="autohotkey">
WinWaitActive, YouTube
WinWaitNotActive, YouTube,, 600 ; 10 min in seconds
</code>
</pre>
</div>

Then, if the timeout on the WaitNotActive occured, I want to show an alert (if we proceed past that point without a timeout, that means I've changed the active window and must not be vegging). To make it system modal, we use the [options parameter](https://autohotkey.com/docs/commands/MsgBox.htm#Group_4_Modality){:target="_blank"} and set it to 4096

<div>
<pre>
<code class="autohotkey">
if ErrorLevel
{
    MsgBox, 4096, Is there something else you need to be doing?, Hey`, you've been watching youtube for a bit . . .
}
</code>
</pre>
</div>

To keep it running, I added an infinite loop around these three lines; changed to using the [Group concept in AHK](https://autohotkey.com/docs/commands/GroupAdd.htm){:target="_blank"} so that I could specify multiple flavors of the windows I wanted to keep a tab on time while open (I eventually added Netflix to this list as well); made a variable for the time to wait before showing an alert and put it at the top for easy edit; added some comments; and, finally, utilized [FanaticGuru's Centered_MsgBox (renamed)](https://www.autohotkey.com/boards/viewtopic.php?p=42603&sid=15ab5b2d8380033e6295f2cf772adae7#p42603){:target="_blank"} to have it show up on top of the time waisting window.

## Full code

(you will need to install Autohotkey to run this code - it is possible to distribute compiled versions, but (a) you shouldn't trust them and (b) gh-pages would complain at me for hosting binary files)

<div>
<pre>
<code id="codeTarget" class="autohotkey">
</code>
</pre>

<script>
    var target = document.getElementById("codeTarget");

    // use JS encode URI to html escape the code.
    {% capture raw_code %}{% include_relative timeFocuserFiles/timeFocuser.ahk %}{% endcapture %}
    target.innerHTML = escape_html(`{{ raw_code | replace: "`", "\\`" }}`);

</script>

</div>

(To Download: <a href="timeFocuserFiles/timeFocuser.ahk" download>Click Here</a>)
