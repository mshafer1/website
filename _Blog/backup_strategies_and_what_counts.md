---
layout: blog
title: "Backups: what counts?"
summary: Why do I want 3-2-1? Does a RAID count?
date: 2025-07-11 20:00:00 -0500
---

* foo
{:toc}

## What is 3-2-1 in backups?

Let's work through a scenario:

> This is an important file that I would not like to lose

Whether it’s the precious photo of a loved one, the important paper/presentation for class or work, or your tax documents: What are you going to do if you lost it? 

> Ok, I'll make a copy on a thumb drive.

Good start. So now, if the computer you’re working on dies, you should still have your thumb drive. If your thumb drive goes through the laundry machine, you should still have the copy on your computer. Just..., be careful to not do laundry while your computer isn’t in a known working state... 

> Ok, I'll copy it to TWO thumb drives!

Better, especially if you don’t keep them together. But what if your house burns down (destroying the computer and both thumb drives)? Would it be detrimental to have also lost this file? (granted this file will likely not be your top priority at that point, but it could add to the sadness/frustration)

> I'll keep one of the thumb drives at my friend's house!

You have now arrived at a 3-2-1 backup. 

- 3 copies (computer, thumb drive #1, and thumb drive #2)
- 2 different storage mediums (the drive in the computer and the flash storage in the thumb drives)
- 1 copy off-site (at your friend's house)

With one off-site, if all 3 copies are lost/destroyed at once, ... you probably have bigger issues to deal with. 

> But, how do I make sure my friend doesn't snoop on my files? Or what if I use "cloud"? Can I count on online backups?

For making sure your friend doesn't snoop on it, lock it in some way (like in a fire box, or use an encrypted file).

For "cloud"...

People in tech/cyber-security are divided on whether you can rely on "cloud" backup:
- (+) Under a paid plan, the company should be guaranteeing your data 
- (+) It's simple, and is off-site
- (-) The company will be a target for hacking attacks (any big name is going to be a target because they possess a massive number of people’s data)
- (-) What if your (individual) account is hacked and deleted (or you forget the password or otherwise lose access)? (at best, you can work with the customer support to regain access or possibly get the file restored, but that will likely take weeks or not happen)

Personally, I use online backups for a lot of things, but I’m wary of using them to store important documents that contain personal data AND that I’m required to keep (pronounced: tax documents). 

## Is RAID a backup?

You may be familiar with the line:

> RAID is not a backup.

I have found that there are two types of people who say this: those who understand why, and those who’ve just heard it and repeat it as unquestionable-truth. 

I’m not going to address the latter here. (I need arguments to reason with...).

To summarize the arguments for this statement [[reference](https://www.raidisnotabackup.com/)]

> - The RAID hardware can die
> - If you delete or change the file, it's changed on the entire array

### The RAID hardware can die

So can your hard drive in a fire box. If you are concerned about that point of failure, use software-based RAID.

### If you delete or change the file, it's changed on the entire array

Ok, so, then what you're really arguing by saying this is "RAID doesn't count as more then one copy, people should still utilize 3-2-1."

The whole point of RAID is make your data more resilient to drive failures (i.e., help me still have my file after a drive dies -> just like a backup!!)

Let's work through an example, let's say I have an important file and I WILL have a drive/storage-device die in the next year.

<table class="table">
<thead>
<tr>
    <th colspan="3">File storage locations</th>
    <th>Result</th>
</tr>
</thead>
<tbody>
<tr>
    <td>🔥 My Computer</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><b>Data lost</b></td>
</tr>
</tbody>
</table>
100% file loss...

<table class="table">
<thead>
<tr>
    <th colspan="3">File storage locations</th>
    <th>Result</th>
</tr>
</thead>
<tbody>
<tr>
    <td>🔥 My Computer</td>
    <td>External Drive 1</td>
    <td>&nbsp;</td>
    <td>Data <b>at risk</b></td>
</tr>
<tr>
    <td>My Computer</td>
    <td>🔥 External Drive 1</td>
    <td>&nbsp;</td>
    <td>Data <b>at risk</b></td>
</tr>
</tbody>
</table>

What do I mean by "Data at risk"?

> At Risk (n.)
> 
> The state in which (if action is not taken) data may be lost when another drive fails.

What if we have two external copies?

<table class="table">
<thead>
<tr>
    <th colspan="3">File storage locations</th>
    <th>Result</th>
</tr>
</thead>
<tbody>
<tr>
    <td>🔥 My Computer</td>
    <td>External Drive 1</td>
    <td>External Drive 2</td>
    <td>Data is fine</td>
</tr>
<tr>
    <td>My Computer</td>
    <td>🔥 External Drive 1</td>
    <td>External Drive 2</td>
    <td>Data is fine</td>
</tr>
<tr>
    <td>My Computer</td>
    <td>External Drive 1</td>
    <td>🔥 External Drive 2</td>
    <td>Data is fine</td>
</tr>
</tbody>
</table>

Here, with every possible occurrence of 1 drive failing, the data is still fine (and exists as two copies on separate devices).

Now, let's look at RAID. To keep things simple, I will only discuss the following RAID types:

{:class="table"}
| Name | Description | Minimum # of drives |
| ---- | ----------- | ------------------- |
| RAID-0 | aka, "Extended", all data shared, there is no redundancy (named "0" because it is not redundant thus a "non-raid") | 2 |
| RAID-1 | aka, "Mirrored", The data is duplicated on two drives (can have more then two, but each file is present on 2) | 2 |
| RAID-5 | Data + Parity data is distributed across all drives. | 3 |
| RAID-Z1 | 1 drive is dedicated to Parity data for the other drives | 2 |

(for a ful list of RAID types/levels, see [wikipedia](https://en.wikipedia.org/wiki/RAID))


What do I mean by "Parity data"?

> Parity Data (n.) 
>
> Extra bytes that reflect the original data. Often used to detect a problem in 
> storage/retrieval or transmission. Many RAID setups use it to be able to reconstruct lost data. 

<table class="table">
<thead>
<tr>
    <th colspan="3">Raid 0 - no redundancy</th>
</tr>
<tr>
    <th colspan="2">Drives</th>
    <th>Result</th>
</tr>
</thead>
<tbody>
<tr>
    <td>🔥 RAID drive 1</td>
    <td>RAID drive 2</td>
    <td><b>Data is lost</b></td>
</tr>
<tr>
    <td>RAID drive 1</td>
    <td>🔥 RAID drive 2</td>
    <td><b>Data is lost</b></td>
</tr>
</tbody>
</table>

100% guaranteed, will lose files when a drive fails. (Note: the outcome is no different to the example above of only having a copy on “My computer”, but (mathematically speaking) the chances of either drive failing is double the chance of a single drive failing -> assuming the same drives). 



<table class="table">
<thead>
<tr>
    <th colspan="3">Raid 1 - purely redundant</th>
</tr>
<tr>
    <th colspan="2">Drives</th>
    <th>Result</th>
</tr>
</thead>
<tbody>
<tr>
    <td>🔥 RAID drive 1</td>
    <td>RAID drive 2</td>
    <td>Data <b>is at risk</b></td>
</tr>
<tr>
    <td>RAID drive 1</td>
    <td>🔥 RAID drive 2</td>
    <td>Data <b>is at risk</b></td>
</tr>
</tbody>
</table>

Here, there’s a 100% chance that the files are fine, as long as you then take action to make more copies and/or repair the RAID array by replacing the failed drive. 

The story is actually the same for RAID-5, and RAID-Z1: when a single drive dies, the data is <b>at risk</b> (not lost).

> So,..., is RAID a backup?

Yes, it really is (and assuming a RAID level above a RAID-0, a backup that is less likely to fail then a single drive). 
But it <em>is only <u><b>one</b></u> copy. So, that quote should really be:

> RAID is only <u><b>one</b></u> backup

ie. <u>It doesn't count as two copies<u> to put something on a RAID-1. Yes, that array is less likely to die then a single drive; however, if you remove the file, you've removed it from the whole thing. It is <u><b>one</b></u> copy.

## "One Backup is None Backup"?

I hate this saying. Why?, because it's oversimplified to the point of being false.

A more accurate statement would be:

> When a copy dies, you're one backup just became your <b><u>only</u></b> copy.

So, in our hypothetical situation from above, where "I WILL have a drive die this year", I can HAVE a backup, and when that one drive dies (whether that is my main computer or my backup), THEN I have NO backup.

Those who preach that one backup = none-backup often argue:

> But if you don't make sure that your backup is working, then Murphy's law says that it won't be. And then it's none-backup.

If I didn't check my backup was working, I never had a backup. Leave Murphy out of this.

**A backup is <em><u>a</u></em> backup, until something happens**

But the same is true for 3 backups. It will inherently become 2 or 1 at some point. 
