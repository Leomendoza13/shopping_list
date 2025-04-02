"""
Flask application with PostgreSQL database connection.
Provides basic health check and database testing endpoints.
"""

import os

try:
    from flask import Flask
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
        Connection object or None if connection fails
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
        String 'OK' with status code 200
    """
    return "OK", 200


@app.route("/test-db", methods=["GET"])
def test_db():
    """
    Test the database connection by executing a simple query.

    Returns:
        Success message with query result or error message with status code
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


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    init_db()
    app.run(host="0.0.0.0", port=port, debug=False)
