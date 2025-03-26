## **Data Types in Prometheus**

Prometheus primarily works with numeric data and supports specific data types that influence how data is stored and queried.

###  Scalar
- Represents a **single numeric value** at a particular timestamp.
- Example:
  ```
  up
  ```
  This returns a scalar value of `1` if the target is up or `0` if it's down.

###  Instant Vector
- Represents a **set of time series** that share the same timestamp but have different label sets.
- Example Query:
  ```
  http_requests_total{method="GET"}
  ```
  This fetches the latest values for all `GET` method HTTP requests.

###  Range Vector
- Represents a **set of time series** over a specified time range.
- Example Query:
  ```
  rate(http_requests_total[5m])
  ```
  This calculates the per-second rate of requests over the past 5 minutes.

###  String (Metadata)
- Used internally for handling **metadata** like metric names and help text.
- Not directly queryable but important for labeling and identifying metrics.

###  Practical Example
- To analyze the rate of successful HTTP requests over 5 minutes:
  ```
  rate(http_requests_total{status="200"}[5m])
  ```
  - **Data Type**: Range Vector
  - **Use Case**: Measures the traffic of successful API responses over time.

---