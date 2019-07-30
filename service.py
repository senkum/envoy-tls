from flask import Flask
from flask import request
import os
import requests
import socket
import sys

app = Flask(__name__)

@app.route('/service')
def hello():
  return ('Hello from behind Envoy')

if __name__ == "__main__":
  app.run(host='127.0.0.1', port=8080, debug=True)
