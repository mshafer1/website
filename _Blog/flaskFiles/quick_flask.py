#!/usr/bin/python
#
# improved from: https://codepen.io/asommer70/post/serving-a-static-directory-with-flask
#
# Flask server, woo!
#

from flask import Flask, request, redirect, url_for, send_from_directory
import logging

_moduleLogger = logging.getLogger(__name__)
_moduleLogger.addHandler(logging.NullHandler())

# Setup Flask app.
app = Flask(__name__)
app.debug = True
app.static_folder = '.'


# Routes
@app.route('/')
def root():
    _moduleLogger.debug('Serving Index')
    return app.send_static_file('index.html')

@app.route('/<path:file>')
def static_proxy(file):
    # send_static_file will guess the correct MIME type
    # _moduleLogger.debug('Path: %s', path)
    _moduleLogger.debug('File: %s', file)
    # dest = os.path.join(path, file.strip('/'))
    dest = file
    if dest.endswith('/'):
        segments = list(file.split('/', False))
        segments.append('index.html')
        dest = os.path.join(*segments)
    _moduleLogger.debug('Joined: %s', dest)
    return app.send_static_file(dest)

if __name__ == '__main__':
    import os
    os.chdir(os.path.dirname(os.path.realpath(__file__)))
    
    import sys
    count = sys.argv.count('-v')
    logging_level = logging.WARNING - 10*count
    logging_level = max(logging.DEBUG, logging_level)
    
    FORMAT = '%(asctime)-15s %(levelname)-7s:%(message)s'
    logging.basicConfig(format=FORMAT, level=logging_level)
    app.run()
