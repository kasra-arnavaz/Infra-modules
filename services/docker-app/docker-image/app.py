from flask import Flask, jsonify
import pymysql
import os

app = Flask(__name__)

def get_db_connection():
    return pymysql.connect(host=os.environ["DB_ADDRESS"],
                           database=os.environ["DB_NAME"],
                           user=os.environ["DB_USERNAME"],
                           password=os.environ["DB_PASSWORD"],
                           cursorclass=pymysql.cursors.DictCursor)

@app.route("/", methods=["GET"])
def index():
    return jsonify("Welcome to the Library!")

@app.route("/data", methods=["GET"])
def get_data():
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            table_name = os.environ["DB_TABLE"]
            safe_tables = ["books"]  # List of known safe table names
            if table_name in safe_tables:
                query = f"SELECT * FROM {table_name}"
                cursor.execute(query)
                data = cursor.fetchall()
                return jsonify(data)
            else:
                return "Invalid table name", 400
    finally:
        connection.close()

if __name__=="__main__":
    app.run(debug=True)