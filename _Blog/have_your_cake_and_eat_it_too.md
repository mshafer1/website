---
layout: blog
title: "Have your cake and eat it too: How to get Travis-CI to build your Jekyll site AND run tests on it through Python with Selenium"
summary: "I run a website (ahkgen.com) for which I wrote Python Selenium based system tests. Coming back to this project, I decided it was time to get these tests running in Travis-CI."
result_file: https://github.com/mshafer1/preview-ahk-gen/blob/master/.travis.yml
date: 2020-06-23 19:30:00 -0500
---

TOC:
* foo
{:toc}

## Background:

[ahkgen.com](http://www.ahkgen.com){:target="_blank"} is a simple utility I wrote for making it easier for people wanting to get more done do so through [AutHotkey](http://www.autohotkey.com){:target="_blank"} without having to learn the entire language. When I wrote it originally I was not aware of JavaScript (JS) testing frameworks like [Jest](http://jestjs.io/){:target="_blank"}, but I needed a way to lighten the testing burden to make sure that adding new features didn't break old ones (This was the beginning of my journey to discover [Test Driven Development](https://www.guru99.com/test-driven-development.html){:target="_blank"}).

Since then, I have learned a lot. Some features I couldn't figure out for the original release I've had to figure out for other projects; I've been exposed to [Jest](http://jestjs.io/){:target="_blank"}; and I've learned a lot more about writing testable code. 

Here in lies the problem: A lot of the code in the original setup isn't very testable (I had no reason to break up my functions in ways that made it easy to unit test - I "couldn't" unit test them anyways).

I began refactoring the site anyways, but paused when I got to the point that I thought I had it working (before pushing it to the public host), to beef up the system level validation. If I could get automated tests running at the system level that verified the the behavior the user saw was unchanged, then I could be confident in my refactors.

## Why Travis-CI?

The site is already hosted in [GitHub Pages](https://pages.github.com/){:target="_blank"} with a [GitHub repo](https://github.com/mshafer1/ahk-generator){:target="_blank"} as version controlled management system. [Travis-CI](https://travis-ci.com/){:target="_blank"} integrates well with GitHub - allowing for scheduled tests (Constantly checking if any dependency has broken the project) as well as tests on all branches and pull-requests (PR's) (allowing for validation of any new changes regardless of contributor).

## What's the complication?

The site is built on [Jekyll](https://jekyllrb.com/docs/){:target="_blank"} (which serves as the backend to [GitHub Pages](https://help.github.com/en/github/working-with-github-pages/setting-up-a-github-pages-site-with-jekyll){:target="_blank"}) and takes advantage of some of the templating features available. <br/>
This means that:
* the source files that are stored aren't completely ready-to-serve HTML and JS (templating)
* There is no server present already in the Travis-CI framework (Normally handled by GH-Pages serving the static output from Jekyll)

## The objective:

The objective was to setup a Travis-CI pipeline that would:
* Build the site using Jekyll,
* Use Jekylll's dev server to serve up the pages,
* Load the pages through a headless browser (to actually run the JS)
* And use Python with Selenium to load various pages and test that the UI reacts as expected.

## Why Write about it?

I spent ~3 weeks digging through Travis-CI docs, Stack Overflow questions, and general Google searching to piece-meal this together. I'm documententing this in the hopes that it will help the next person to come along to develop good, automated, system level testing quicker.

## Solution/Example

If you want to skip ahead and look at the resulting pipeline file, the current version can be found [here]({{page.result_file}}){:target="_blank"} (<b>Note:</b> This link will likely change over time as I work to integrate this refactoring into the main project, I will try to remember to come back and update it here when I do. If I forgot, checkout the master branch of the [main repo](https://github.com/mshafer1/AHK-generator){:target="_blank"}).

## Steps In overcoming

### Problem 1: Build the Jekyll site

This is actually something I had done before, but in my search to get this  larger project setup, I came across a blog post by [mattouille.com](https://mattouille.com/articles/2017-10/testing-jekyll-with-travis-ci/){:target="_blank"} that not only built the site using jekyll, but used a ruby Gem called [htmlproofer](https://github.com/gjtorikian/html-proofer){:target="_blank"} to validate the links point to valid sites, images have alt tags, and similar. I chose to adopt this into my site as well to reduce the amount of testing I would have to write.

[link to article](https://mattouille.com/articles/2017-10/testing-jekyll-with-travis-ci/){:target="_blank"}

At this point the `travis.yml` file looked something like this (notice that I took advantage of the fact that bundler is a node JS concept, so I could still run my JS unit tests and report to coveralls at this point):

```yaml
sudo: false
language: node_js
node_js:
- '10'

cache:
  bundler: true
  directories:
  - node_modules

before_install:
- npm update

install:
- bundler install
- npm install
- bundle exec jekyll build -d _site

script:
- bundle exec htmlproofer ./_site --only-4xx --check-favicon --check-html
- npm test

after_success:
- npm run coveralls
```


### Problem 2: Need both Jekyll (Ruby based) and Python/Selenium available in a Travis-CI container

Jekyll is required to build and serve the site, Python to test it.

I eventually found this GitHub Issue to the Travis-CI project: https://github.com/travis-ci/travis-ci/issues/4090 - The jist of it is the OP wanted to have Python and Node.js available for running both the front and back ends of their site for testing purposes.

<b>The official answer was:</b> (Use `language: python` and install Node.js through the runtime [specifically nvm](https://github.com/travis-ci/travis-ci/issues/4090#issuecomment-122688955){:target="_blank"})

Testing this for my project proved successful.

At this point, The .travis.yaml file looked something like this:

```yaml
language: python
python:
  - "3.6"

before_install:
- nvm install node 11.10.0
- npm update

install:
- bundler install
- npm install
- pip install -r requirements_test.txt

script:
- bundle exec jekyll build -d _site
- bundle exec htmlproofer ./_site --only-4xx --check-favicon --check-html
- python -m pytest .

after_success:
- npm run coveralls
```

(at this point, the only test that would get picked up was a no-op. Just validation that the test runners were setup)


### Problem 3: Getting Chrome and chromedriver installed

For installing Chrome, I found the official Travis-CI docs has an article: [Google Chrome - Travis CI](https://docs.travis-ci.com/user/chrome){:target="_blank"}

For getting chromedriver downloaded to control Chrome, I found this help issue where a setup for downloading and extracting latest chrome-driver is demoed: [how to setup chromedriver...](https://travis-ci.community/t/how-to-setup-chromedriver-74-with-chrome-74-for-travis/2678/7){:target="_blank"}

(Note: I learned through trying to get selenium to open that I needed to have chrome-driver be in the `$PATH` so that is reflected here as well)

```yaml
language: python
python:
  - "3.6"

before_install:
- nvm install node 11.10.0
- npm update

install:
- bundler install
- npm install
- pip install -r requirements_test.txt

# from https://travis-ci.community/t/how-to-setup-chromedriver-74-with-chrome-74-for-travis/2678/7
before_script:
- LATEST_CHROMEDRIVER_VERSION=`curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE"`
- curl "https://chromedriver.storage.googleapis.com/${LATEST_CHROMEDRIVER_VERSION}/chromedriver_linux64.zip" -O
- unzip chromedriver_linux64.zip -d ~/bin
- export PATH=$PATH:~/bin

script:
- bundle exec jekyll build -d _site
- bundle exec htmlproofer ./_site --only-4xx --check-favicon --check-html
- python -m pytest .

after_success:
- npm run coveralls
```

### Problem 4: Running the jekyll server AND pytest at the same time

There are multiple ways of solving this, including launching a detached tmux, but I chose to go with just using bash's fork syntax (`&`) to avoid having one more thing to install and get setup.

I also added a 5 second sleep in after starting the server to allow it time to generate and get setup.

Note: the `--no-watch` flag is used because the pipeline won't be changing the website, and any `*.pyc` or `__pycache__` files and folders that show up don't need to trigger a rebuild.

```yaml
language: python
python:
  - "3.6"

before_install:
- nvm install node 11.10.0
- npm update

install:
- bundler install
- npm install
- pip install -r requirements_test.txt

# from https://travis-ci.community/t/how-to-setup-chromedriver-74-with-chrome-74-for-travis/2678/7
before_script:
- LATEST_CHROMEDRIVER_VERSION=`curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE"`
- curl "https://chromedriver.storage.googleapis.com/${LATEST_CHROMEDRIVER_VERSION}/chromedriver_linux64.zip" -O
- unzip chromedriver_linux64.zip -d ~/bin
- export PATH=$PATH:~/bin

script:
- bundle exec jekyll build -d _site
- bundle exec htmlproofer ./_site --only-4xx --check-favicon --check-html
- bundle exec jekyll serve --no-watch &
- sleep 5s
- python -m pytest .

after_success:
- npm run coveralls
```

### Problem 5: Telling Pytest how to find the chrome-driver exe

(This was actually something I had solved for other projects, but thought it was worth documenting here as well)

Pytest actually allows you to customize the command line arguments it will take - this is particularly useful as it allows me to specify `~/bin/chomedriver` here, but something like `C:\chromedriver` on my dev machine.

To add args to pytest, author a [conftest](https://docs.pytest.org/en/2.7.3/plugins.html?highlight=conftest.py#conftest-py-plugins){:target="_blank"} and add the following method:

```python
def pytest_addoption(parser):
    parser.addoption(
        "--driver-path",
        dest="driver_path",
        action="store",
        help="Path to the chrome webdriver to use",
        required=True,
    )
    parser.addoption(
        "--use-headless",
        dest="use_headless",
        action="store_true",
        help="Use browser in headless mode",
        required=False,
        default=False,
    )
```

If you are familiar with [ArgParse](https://docs.python.org/3/library/argparse.html){:target="_blank"}, you might recognize the syntax!

Then, to make a Pytest pseudo-fixture that passes this down into tests and other fixtures, add this method as well:

(Note: because I made my parameters required, I don't have to check if their in the option, but you might have to if not choosing to do that)

```python
def pytest_generate_tests(metafunc):
    # This is called for every test. Only get/set command line arguments
    # if the argument is specified in the list of test "fixturenames".
    driver_path = metafunc.config.option.driver_path
    use_headless = metafunc.config.option.use_headless

    if "driver_path" in metafunc.fixturenames:
        metafunc.parametrize("driver_path", [metafunc.config.getoption("driver_path")])

    if "use_headless" in metafunc.fixturenames:
        metafunc.parametrize("use_headless", [use_headless])
```

This creates a pseudo-fixture named "driver_path" that is available to all tests and fixture that contains the path passed from command line (and a use_headless that is false unless `--use-headless` was passed).

At this point, the `.travis.yml` file looked something like:
```yaml
language: python
python:
  - "3.6"

before_install:
- nvm install node 11.10.0
- npm update

install:
- bundler install
- npm install
- pip install -r requirements_test.txt

# from https://travis-ci.community/t/how-to-setup-chromedriver-74-with-chrome-74-for-travis/2678/7
before_script:
- LATEST_CHROMEDRIVER_VERSION=`curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE"`
- curl "https://chromedriver.storage.googleapis.com/${LATEST_CHROMEDRIVER_VERSION}/chromedriver_linux64.zip" -O
- unzip chromedriver_linux64.zip -d ~/bin
- export PATH=$PATH:~/bin

script:
- bundle exec jekyll build -d _site
- bundle exec htmlproofer ./_site --only-4xx --check-favicon --check-html
- bundle exec jekyll serve --no-watch &
- sleep 5s # allow time for pages to generate
- python -m pytest . --driver-path ~/bin/chromedriver --use-headless

after_success:
- npm run coveralls
```

### Problem 6: Tests take way to long to run - most of which is in closing and re-opening Chrome

Initially, I wrote a `browser` fixture that launched the driver, yielded, then closed. But then I realized how much time I was spending in-between tests relaunching the browser.

Original:
```python
@pytest.fixture()
def browser(driver_path, use_headless):
    opts = Options()
    if use_headless:
        opts.add_argument("--headless")
        opts.add_argument("--disable-gpu")

    result = webdriver.Chrome(driver_path, options=opts)
    yield result
    result.close()
```

Changed to one per test session:

```python
@pytest.fixture(scope="session",)
def browser(driver_path, use_headless):
    if not browser.result:
        opts = Options()

        if use_headless:
            opts.add_argument("--headless")
            opts.add_argument("--disable-gpu")

        browser.result = webdriver.Chrome(driver_path, options=opts)
    yield browser.result

    try:
        browser.result.close()
    except:
        pass
    browser.result = None


browser.result = None
```

(Note: this also necessitated changing the psuedo-fixtures of `driver_path` and `use_headless` to session scoped as well by adding `scop="session"` to each of the parametrize calls)

## Summary

And there you have it. ([Final file]({{page.result_file}}){:target="_blank"})

Feel free to copy and re-use the result, but I hope that by walking through how it got built up, that this can serve as an example for projects with slightly different requirements or objectives but similar needs.

Happy Coding!
