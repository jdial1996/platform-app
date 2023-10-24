from flask import Flask, Response
import logging

app = Flask(__name__)


# Configure logging
log_format = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
logging.basicConfig(level=logging.INFO, format=log_format)

# Create a logger instance
logger = logging.getLogger(__name__)


@app.route("/")
def index():
    message = "Plaform app with Python Flask running on Kubernetes =)!"
    return Response(message, status=200, mimetype="application/json")


if __name__ == "__main__":
    logger.info("Flask application is running successfully")
    app.run(host="0.0.0.0", port=5000)
