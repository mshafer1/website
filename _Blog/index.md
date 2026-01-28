---
layout: dark-basic
title: Blog
---

<link href="https://cdn.jsdelivr.net/gh/mshafer1/quick-filter-table@1.0.1/quick-filter-table/dist/quick-filter-table.css"
    rel="stylesheet" />
<script
    src="https://cdn.jsdelivr.net/gh/mshafer1/quick-filter-table@1.0.1/quick-filter-table/dist/quick-filter-table.js"></script>


<div id="table" class="container"></div>


<script>
    QuickFilterTable.renderApp("table", {
          items: [
            {% assign sorted_blog_posts = site.Blog | sort: 'date' | reverse %}
        {% for post in sorted_blog_posts %}{% if post.summary %}
            {{ 'render': {{ `<div class="row">
                <a href="{{post.url}}">
                    <div class="service-box">
                        <h3>{{post.title}}</h3>
                        <p class="text-muted">({{ post.date }})</p>
                        <p class="text-muted">{{post.summary}}</p>
                    </div>
                </a>
            </div>` }} }}
        {% endfor %}
          ],
          headers: [
            { text: "", value: "render", html: true },
          ],
        });
      }
</script>