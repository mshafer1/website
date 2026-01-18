---
layout: blog
title: "There is no such thing as 'too small' of a target."
summary: |
  Wait, why are people attacking my website?
  How I learned that vulnerabilities and hacking are not usually personal.
date: 2026-01-17 19:00:00 -0500
---

* foo
{:toc}

> Wait, why does my nginx server have a pile of logs of people requesting PHP pages? I don't even run PHP on here...
>
> \- Me, one Saturday morning.

## Big Companies: Big Risk

Any company that processes personal information, has a lot of employees, or stores sensitive data will have plenty of security concerns. One data breach can leak all of their customers' or employees' (or both!) personal information opening the individuals up to identity theft and similar problems. Because of this, most countries have strict laws around how companies handle personal information and sensitive data. Additionally, companies tend to have what they consider to be “trade secrets” that help them operate and maintain a competitive advantage. If this information is leaked or held for ransom, it can disrupt the lives of individual customers or employees, or even ruin the company itself. For these reasons, many large companies make a strong effort to keep that data secure.

## Small Startups: Same Impact

Even small startups with only a few customers and employees still need to be extremely careful to safeguard the data that they collect because they are just as susceptible to suffering a breach (having the data accessed by a bad-faith actor), which can have the same implications for those whose data is stolen.


## The Individual: It's Still Your Livelihood

But even if a hacked account or stolen data affects only one person, it would still be devastating to have your identity get stolen, to be locked out of the accounts you use every day, or even just to lose your current work or family pictures.

Regardless of the size of the organization, the impact to those affected is the same. For this reason, it is important to follow the same security practices as an individual that one would if they worked for a large company.


## The wake up call

For years, I thought that hacking only happened to big companies, that I didn't need to worry about security beyond installing updates and using good passwords, and that "nobody" would targe me. Then one morning, I checked the logs on my web server in my living room (a Raspberry Pi that just served some static html files to make my life easier) and discovered that my server had been regularly getting requests for files and pages that were that could not be from a legitimate page on the server (since I had stopped using PHP *years* before on a different physical server).

Requests pages like:
- `phpMyAdmin`
- `/admin/wordpressconf.php`
- `.env` (this is a file that is often used to store configuration and secrets)

I then checked another server that I run and found the same thing there as well.

I don't have those logs anymore, but here is a dump of similar requests that hit a server in the time it took me to setup the firewall:

<details>
<summary>Click to expand:</summary>
<pre>
<code class="log">
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x16\x03\x01\x01" 400 166 "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x16\x03\x01\x01" 400 166 "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x03\x00\x00/*\xE0\x00\x00\x00\x00\x00Cookie: mstshash=Administr" 400 166 "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /favicon.ico HTTP/1.1" 404 196 "https://&lt;domain&gt;/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET / HTTP/1.1" 502 568 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /foo HTTP/1.1" 404 8719603 "-" "curl/8.5.0"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /foo HTTP/1.1" 404 8719773 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "CONNECT www.google.com:443 HTTP/1.1" 400 166 "-" "-"
::1 - - [&lt;timestamp&gt;] "GET /test HTTP/1.1" 404 162 "-" "curl/8.5.0"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET / HTTP/1.1" 444 0 host="&lt;server_ip&gt;" http_host="&lt;server_ip&gt;:80" "-" "curl/7.81.0"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET / HTTP/1.1" 444 0 host="&lt;server_ip&gt;" http_host="&lt;server_ip&gt;" "-" "Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET / HTTP/1.0" 444 0 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "OPTIONS / HTTP/1.0" 444 0 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /nice%20ports%2C/Tri%6Eity.txt%2ebak HTTP/1.0" 444 0 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x05\x00\x0B\x03\x10\x00\x00\x00H\x00\x00\x00\x01\x00\x00\x00\xB8\x10\xB8\x10\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x01\x00\x08\x83\xAF\xE1\x1F]\xC9\x11\x91\xA4\x08\x00+\x14\xA0\xFA\x03\x00\x00\x00\x04]\x88\x8A\xEB\x1C\xC9\x11\x9F\xE8\x08\x00+\x10H`\x02\x00\x00\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x05\x01\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x04\x01yh\xB9\xF7\x89\x8B\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x80\x00\x00(,\xB4\x98\x95\x00\x00\x00\x00\x00\x00\x00\x02\x00\x01\x86\xA0\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x03\x00\x00,'\xE0\x00\x00\x00\x00\x00Cookie: mstshash=eltons" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "OPTIONS sip:&lt;server_ip&gt; SIP/2.0" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x00\x0E8ZL\xF3\x82+v\x9A\x02\x00\x00\x00\x00\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x00\x9C\x00\x01\x1A+&lt;M\x00\x01\x00\x00\x01\x00\x00\x00\x00\x00\x00\x03\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x00\x00\x001\xFFSMBr\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x0E\x00\x02NT LM 0.12\x00\x02\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x00\x00\x00n\xFESMB@\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00$\x00\x04\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x02\x10\x02\x00\x03\x02\x03\x11\x03" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x00\x00\x00\x09\x00\x03\x00\x00\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "*1" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x12\x01\x00\x1A\x00\x00\x00\x00\x00\x00\x0B\x00\x06\x01\x00\x11\x00\x01\xFF\x08\x00\x01U\x00\x00\x01" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "7\x00\x00\x007\x8E@\xC2\x00\x00\x00\x00\xD4\x07\x00\x00\x00\x00\x00\x00admin.$cmd\x00\x00\x00\x00\x00\x01\x00\x00\x00\x10\x00\x00\x00\x10hello\x00\x01\x00\x00\x00\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "0\x0C\x02\x01\x01`\x07\x02\x01\x03\x04\x00\x80\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "0\x1D\x02\x01\x01w\x18\x80\x161.3.6.1.4.1.1466.20037" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x00x\x00\x00\x01\x00\x00\x00\x01@\x01,\x00\x81 \x00\xFF\xFF\x7F\x08\x00\x00\x01\x00\x00.\x00J\x00\x00\x07\xF8\x04\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00 \x00\x00 \x00\x00\x00\x00\x00\x00\x00\x00\x00\x00(DESCRIPTION=(CONNECT_DATA=(COMMAND=version)))" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\xCF2\x00\x00\x00\x05\x01+\x0E\x01\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x13/multistream/1.0.0" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "fox a 1 -1 fox hello" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "l\x00\x0B\x00\x00\x00\x00\x00\x00\x00\x00\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "stats" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x01\x00\x00\x00\x00\xCD\x00\x01\x00\x00ANY-SCP         ECHOSCU         \x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x151.2.840.10008.3.1.1.1 \x00\x00.\x01\x00\x00\x000\x00\x00\x111.2.840.10008.1.1@\x00\x00\x111.2.840.10008.1.2P\x00\x00:Q\x00\x00\x04\x00\x00\x00\x00R\x00\x00\x1B1.2.276.0.7230010.3.0.3.6.2U\x00\x00\x0FOFFIS_DCMTK_362" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x01!\x01\x01\x01\x01\x01\x01" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x002\xD0\x01\x00\x01\x00,\x10A\x00\x04\x11^\x00\x04\x11m\x00\x04\x11Z\x00\x18\x14\x04\x14\x03\x00\x07$\x07\x00\x08$\x0F\x00\x08\x14@\x00\x08\x14t\x00\x08\x00\x04\x11G" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\xA6-f32)\x8C\xB2&gt;\x10\xC4\x8D\x9F\x82\xBA\xC6[\xA7\xB31\x7Ff\x90g\xAA\xF5\xC4\x99\xB8&gt;5-\x13\x968\xA9\xB1. \x9A\xEE\xBA\xB2\xB8\xEFW`\xFD3sB\xE12\x8E+:\x0C\x0C'wI#\xFF\x97\xA8q\x1D\xA3\x91{\x1F\xFE\x81\x9B\xDA\x1D\xF0Q\x14$\x07`\xB1\xC7DD\xC9q\x97\x92\xC5\xF1\xAF\xE2\x87\xBF4;\xA9\x91\xDB\xC7\xE6\xF0c\x8A\x8B\xF4`\xDA{\x0B[\xD4U\x89\xA3\xC7e\x14;\x13\x0C1\xDD\xBE\x07\xF0G\xFB\xFC\x15\xC4\x12qB\x06\x1D\x12\xC9\xB9\x86\xF2\xD8\x07V\xD4\x7F\x88\x12\x0F\x88\x08\xA14\xB9z\xA5\xA2\x06\xA4:`'69\xB3\xAD\xA8\xB1P\xF1ICv0\xFF\xE8\x1Cf\xB6d\xA8M\xC4\x06\xE5\xB1\xA3\xE6t\xA8\xCBPt\xEAF\xAFY \x89\x0B\x1C\xEDaF\xAE\x96K\x91i\xCF\xE9\xE0\x9D\xBA]" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\xF9\xBE\xB4\xD9version\x00\x00\x00\x00\x00V\x00\x00\x00P!\xEA\xE4\x80\x11\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00O\x9F*h\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFF\xFF\x7F\x00\x00\x01 \x8D\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFF\xFF\x7F\x00\x00\x01 \x8D\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "HELFD\x00\x00\x00\x00\x00\x00\x00\xFF\xFF\xFF\x7F\xFF\xFF\xFF\x7F\x00\x00\x00\x00\x00\x00\x00\x00$\x00\x00\x00opc.tcp://localhost:4840/UADiscovery" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\xFB\x01" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "OPTIONS * RTSP/1.0" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "&lt;?xml version='1.0'?&gt;&lt;stream:stream version='1.0' xml:lang='en' xmlns:stream='http://etherx.jabber.org/streams' xmlns='jabber:client' to='localhost'&gt;" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x16\x03\x01\x00{\x01\x00\x00w\x03\x03\xE1\xC9\xD9\xAFUA@C\x9Dn\xFF" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x16\x03\x01\x01" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET / HTTP/1.1" 444 0 host="&lt;server_ip&gt;" http_host="&lt;server_ip&gt;:80" "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36 Edg/90.0.818.46"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x16\x03\x01\x02\x00\x01\x00\x01\xFC\x03\x03\xEF\x1DO+\xF1\xD5\xEB\xD5\xC1k\xFF\xFD\x8B7~\xE7{\x1Dt\x22\xF8\x83\x00W/Pu@\xB1C-\x8A I\xF5\x8EN\xFFc]\x1E\xF1#\x84\xC5go\x0C\xB6\xC1\x1C\x0F\xC7z\x9F\xED\x14\x7F\x87\xED\xF9\xD1K:&\x00\x1C\x13\x01\x13\x02\x13\x03\xC0+\xC0,\xC0/\xC00\xC0\x13\xC0(\x00\x9C\x00\x9D\x00/\x005\x00" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "\x16\x03\x01\x02\x00\x01\x00\x01\xFC\x03\x03\x12\xADUd`\x8B=\x1E(\x16&lt;\x9F\xCA\xD8\x86\x0F\x0E\xEB\xEB\xDB\xAB\x9E\xE6\xB3\x96\xB4L\xAA\x90\x03\x90\xD8 \xD0\x91\xC4\xBB8\xA7\x1Al\xE4`\xACw\x1B0\xF2\x0E-\xA9\x22\xD0\xEB0AK_\x98\x81" 400 166 host="" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /@vite/env HTTP/1.1" 404 2801442 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /actuator/env HTTP/1.1" 404 8719270 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /server HTTP/1.1" 404 8718771 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /@vite/env HTTP/1.1" 404 573218 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /about HTTP/1.1" 404 8721108 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /.vscode/sftp.json HTTP/1.1" 404 8718788 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /debug/default/view?panel=config HTTP/1.1" 404 2031394 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /v2/_catalog HTTP/1.1" 404 1851170 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /actuator/env HTTP/1.1" 404 8718731 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /server HTTP/1.1" 404 8718737 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /.vscode/sftp.json HTTP/1.1" 404 8721108 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /debug/default/view?panel=config HTTP/1.1" 404 818978 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /v2/_catalog HTTP/1.1" 404 425762 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /ecp/Current/exporttool/microsoft.exchange.ediscovery.exporttool.application HTTP/1.1" 404 8719425 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /_all_dbs HTTP/1.1" 404 212770 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Mozilla/5.0 (l9scan/2.0.035313e2333313e27363e2237313; +https://leakix.net)"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /server-status HTTP/1.1" 404 8719437 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /login.action HTTP/1.1" 404 8721108 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /ecp/Current/exporttool/microsoft.exchange.ediscovery.exporttool.application HTTP/1.1" 404 8719153 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /about HTTP/1.1" 404 5652258 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /.DS_Store HTTP/1.1" 404 1015586 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /server-status HTTP/1.1" 404 8721108 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /_all_dbs HTTP/1.1" 404 327458 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Mozilla/5.0 (l9scan/2.0.43e24313e21323e2430313; +https://leakix.net)"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /login.action HTTP/1.1" 404 8719124 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /.env HTTP/1.1" 404 8721108 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /.git/config HTTP/1.1" 404 8721108 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /.DS_Store HTTP/1.1" 404 1638178 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /s/035313e2333313e27363e2237313/_/;/META-INF/maven/com.atlassian.jira/jira-webapp-dist/pom.properties HTTP/1.1" 404 8721108 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /.env HTTP/1.1" 404 8718899 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /config.json HTTP/1.1" 404 8718949 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /?rest_route=/wp/v2/users/ HTTP/1.1" 200 893 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /config.json HTTP/1.1" 404 8718899 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /telescope/requests HTTP/1.1" 404 8718830 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /?rest_route=/wp/v2/users/ HTTP/1.1" 200 893 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /.git/config HTTP/1.1" 404 8011554 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /telescope/requests HTTP/1.1" 404 8721108 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /s/43e24313e21323e2430313/_/;/META-INF/maven/com.atlassian.jira/jira-webapp-dist/pom.properties HTTP/1.1" 404 8721108 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /info.php HTTP/1.1" 404 8721108 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /info.php HTTP/1.1" 404 8721108 host="&lt;domain&gt;" http_host="&lt;domain&gt;" "-" "Go-http-client/1.1"
::1 - - [&lt;timestamp&gt;] "\x16\x03\x01\x02\x00\x01\x00\x01\xFC\x03\x03\xBC\xE1\x19j*\x91\x0F\x09\xD1H\x1CDe{\x016\x02\xBA\xFB\x80e\x0B\xEA\x7F\xF4n\xBD\x95\xA8O\xF7\x8B \xE5\xF6\x9D\xE1\xF7\xAB\xCE\xDA\xCED\x05\xEC\x88}S\x99\xC5\x821o\x22$X\x88\xAA\xF2\x1D\xB0\xC9o\xBF\xE3\x00&gt;\x13\x02\x13\x03\x13\x01\xC0,\xC00\x00\x9F\xCC\xA9\xCC\xA8\xCC\xAA\xC0+\xC0/\x00\x9E\xC0$\xC0(\x00k\xC0#\xC0'\x00g\xC0" 400 166 host="&lt;domain&gt;" http_host="-" "-" "-"
&lt;source_ip&gt;- - [&lt;timestamp&gt;] "GET /.env HTTP/1.1" 444 0 host="&lt;server_ip&gt;" http_host="&lt;server_ip&gt;" "-" "Mozilla/5.0 (Linux; U; Android 4.4.2; en-US; HM NOTE 1W Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 UCBrowser/11.0.5.850 U3/0.8.0 Mobile Safari/534.30"
</code>
</pre>
</details>

&nbsp;

While the actions I took to harden my security that day might be the basis for a future post, what I learned that day was:
- There are actors out there that are scanning the entire IP address space looking for vulnerabilities
- Security isn't just for big companies; whoever was scanning my server apparently didn't care that I'm not a business.
  - Actually, I realized, they probably didn't even know that, so it doesn't matter that "I'm nobody". If I have a vulnerability on my web server or router that they happen to look for, they'll get in.
- I don't want to be running something at home that has my main firewall forwarding to it.
  - If they had actually gotten in, all of my computers would have been at risk!


## Conclusion

From that day, I've endeavored to:
- Only use strong passwords (more then 12 characters)
- Make sure I don't have the same password multiple places
- Use 2FA on anything important (and anywhere else I can)
- [Never use PHP](https://blog.boot.dev/python/python-versus-php/#python-versus-php-security)
- Strive to have the impact of a website I run getting hacked be as small as possible (ideally, just that website and no others)

I hope that reading my story has persuaded you to join me in these endeavors to better protect your own information.
