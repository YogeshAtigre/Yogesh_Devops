## Methods of Metric Collection

- **Pull-Based Collection**: Metrics are scraped from an endpoint at regular intervals. Example: Prometheus scraping metrics from microservices.
- **Push-Based Collection**: Services push metrics data to a centralized server. Example: Using StatsD to push metrics to a monitoring system.
- **Agent-Based Collection**: Agents installed on the host collect and transmit metrics. Example: Using Telegraf for infrastructure monitoring.
- **Agentless Collection**: Data is collected via APIs without installing agents. Example: CloudWatch collecting metrics from AWS services.
- **Log-Based Metrics**: Parsing logs to extract metrics. Example: Using ELK stack to analyze application logs and derive metrics.
- **Event-Driven Collection**: Metrics are captured when specific events occur. Example: Capturing custom application events via Lambda functions.
- **Custom Instrumentation**: Developers add code to expose custom metrics. Example: Using OpenTelemetry for custom metric instrumentation.

**Practical Example**:
- Using Prometheus in pull mode to collect metrics from Node.js microservices.
- Deploying Telegraf agents to monitor system metrics from EC2 instances.
- Extracting metrics from application logs via Logstash.
- Setting up Lambda functions to capture metrics on S3 bucket events.