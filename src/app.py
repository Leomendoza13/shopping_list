"""
Flask application with PostgreSQL database connection.
Provides basic health check and database testing endpoints.
"""

import os

try:
    from flask import Flask, request, jsonify
except ImportError:
    print("Flask package not found. Please install it with: pip install flask")
    raise

try:
    import psycopg2
except ImportError:
    print(
        "psycopg2 package not found. Please install it with: pip install psycopg2-binary"
    )
    raise

app = Flask(__name__)


def get_db_connection():
    """
    Create and return a connection to the PostgreSQL database.

    Returns:
        psycopg2.extensions.connection: Database connection object.
        None: If connection fails.
    """
    try:
        conn = psycopg2.connect(os.environ.get("DATABASE_URL"))
        return conn
    except psycopg2.OperationalError as error:
        app.logger.error("Database connection error: %s", str(error))
        return None
    except psycopg2.Error as error:
        app.logger.error("General database error: %s", str(error))
        return None


def init_db():
    """
    Initialize the database by creating the items table if it doesn't exist.

    Logs any database initialization errors.
    """
    try:
        conn = get_db_connection()
        if conn:
            cur = conn.cursor()
            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS items (
                    id SERIAL PRIMARY KEY,
                    name TEXT NOT NULL
                )
            """
            )
            conn.commit()
            cur.close()
            conn.close()
            app.logger.info("items table created or already exists")
    except psycopg2.ProgrammingError as error:
        app.logger.error(
            "SQL syntax error during database initialization: %s", str(error)
        )
    except psycopg2.Error as error:
        app.logger.error("Database error during initialization: %s", str(error))


@app.route("/", methods=["GET"])
def health_check():
    """
    Simple health check endpoint to verify the application is running.

    Returns:
        tuple: A tuple containing 'OK' string and 200 status code.
    """
    return "OK", 200


@app.route("/test-db", methods=["GET"])
def test_db():
    """
    Test the database connection by executing a simple query.

    Returns:
        tuple: A success message with query result or error message with status code.
    """
    try:
        conn = get_db_connection()
        if conn:
            cur = conn.cursor()
            cur.execute("SELECT 1")
            result = cur.fetchone()
            cur.close()
            conn.close()
            return f"Database connection successful: {result[0]}"
        return "Error establishing database connection", 500
    except psycopg2.OperationalError as error:
        app.logger.error("Database operational error: %s", str(error))
        return f"Database operational error: {str(error)}", 500
    except psycopg2.Error as error:
        app.logger.error("Database error: %s", str(error))
        return f"Database error: {str(error)}", 500


@app.route("/add_item", methods=["POST"])
def add_item():
    """
    Add a new item to the database.

    Returns:
        tuple: A JSON response with added item details and status code.
    """
    try:
        item_name = request.form["item"]
        conn = get_db_connection()
        if conn:
            cur = conn.cursor()
            cur.execute(
                "INSERT INTO items (name) VALUES (%s) RETURNING id", (item_name,)
            )
            item_id = cur.fetchone()[0]
            conn.commit()
            cur.close()
            conn.close()
            return jsonify({"message": f"Item {item_name} added", "id": item_id}), 201
        return "Error establishing database connection", 500
    except KeyError as key_error:
        return f"Missing form data: {str(key_error)}", 400
    except psycopg2.Error as db_error:
        return f"Adding item Error: {str(db_error)}", 500


@app.route("/get_items", methods=["GET"])
def get_items():
    """
    Retrieve all items from the database.

    Returns:
        tuple: A JSON response with list of items and status code.
    """
    try:
        conn = get_db_connection()
        if conn:
            cur = conn.cursor()
            cur.execute("SELECT * from items")
            results = cur.fetchall()
            cur.close()
            conn.close()
            return jsonify(results)
        return "Error establishing database connection", 500
    except psycopg2.Error as db_error:
        return f"Error getting items: {str(db_error)}", 500


@app.route("/del_item", methods=["POST"])
def del_item():
    """
    Delete an item from the database by its ID.

    Returns:
        tuple: A JSON response with deleted item details and status code.
    """
    try:
        item_id = request.form["id"]
        conn = get_db_connection()
        if conn:
            cur = conn.cursor()
            cur.execute("DELETE FROM items WHERE id = %s RETURNING name", (item_id,))
            name = cur.fetchone()

            if not name:
                return jsonify({"message": f"No item found with id {item_id}"}), 404

            name = name[0]
            conn.commit()
            cur.close()
            conn.close()
            return jsonify({"message": f"Item {name} deleted", "id": item_id}), 200
        return "Error establishing database connection", 500
    except KeyError as key_error:
        return f"Missing form data: {str(key_error)}", 400
    except psycopg2.Error as db_error:
        return f"Error deleting item: {str(db_error)}", 500


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    host = os.environ.get("HOST", "0.0.0.0")  # nosec
    init_db()
    app.run(host=host, port=port, debug=False)
