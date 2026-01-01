---
layout: dark-basic
title: Blog
---

<div class="container">
        {% assign sorted_blog_posts = site.Blog | sort: 'date' | reverse %}
        {% for post in sorted_blog_posts %}{% if post.summary %}
        {% capture thecycle %}{% cycle 'odd', 'test', 'test2', 'even' %}{% endcapture %}
        {% if thecycle == 'odd' %}
        <div class="row">
            {% endif %}

            <div class="col-lg-3 col-md-6 text-center">
                <a href="{{post.url}}">
                    <div class="service-box">
                        <h3>{{post.title}}</h3>
                        <p class="text-muted">({{ post.date }})</p>
                        <p class="text-muted">{{post.summary}}</p>
                    </div>
                </a>
            </div>

            <!-- Need to close the div on the opposite group -->
            {% if thecycle == 'even' %}
        </div>
        {% endif %}
        {% endif %}{% endfor %}
    </div>

