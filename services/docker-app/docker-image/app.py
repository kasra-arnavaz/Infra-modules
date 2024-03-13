from flask import Flask, Response

app = Flask(__name__)

@app.route("/", methods=["GET"])
def index():
    return Response("Hey You!", status=200, content_type="text/plain")