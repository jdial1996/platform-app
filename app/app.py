from flask import Flask, request
import logging
from prometheus_client import start_http_server, Counter, Summary

logging.basicConfig(level=logging.INFO)
app = Flask(__name__)


REQUEST_COUNTER = Counter("http_requests_total", "Total number of HTTP requests")
REQUEST_LATENCY = Summary("request_latency_seconds", "Time spent processing request")


@app.route("/")
@REQUEST_LATENCY.time()
def index():

    client_ip = request.headers.get("X-Forwarded-For", request.remote_addr)

    app.logger.info(f"Received request from {client_ip} for {request.path}")

    message = "Flask app running on Kubernetes =)!"
    REQUEST_COUNTER.inc()
    return f"<h1>{message}</h1>"


if __name__ == "__main__":
    # Start Prometheus Metrics Server
    start_http_server(8000)
    # Start Flask App
    app.logger.info("Starting Flask application with Prometheus metrics server")
    app.run(host="0.0.0.0", port=5000)
