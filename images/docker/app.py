from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/", methods=["GET"])
def get_root():
    return "<h1> Welcome to the Homepage! <h1/>"

if __name__ == "__main__":
    app.run(debug=True, host="127.0.0.1", port=5000)