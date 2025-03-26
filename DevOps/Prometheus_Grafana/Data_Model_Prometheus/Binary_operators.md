##  **Operators in Prometheus**

PromQL provides a variety of operators to perform arithmetic, comparison, logical, and set operations on time series data.

### 1 Arithmetic Operators
- Used for basic mathematical calculations.
- Operators: `+`, `-`, `*`, `/`, `%`, `^`
- Example:
  ```
  node_cpu_seconds_total / 60
  ```
  - Converts CPU seconds to minutes.

### 2 Comparison Operators
- Used to compare values in queries.
- Operators: `==`, `!=`, `>`, `<`, `>=`, `<=`
- Example:
  ```
  http_requests_total > 100
  ```
  - Returns time series where the total requests are greater than 100.

### 3 Logical Operators
- Used for logical comparisons.
- Operators: `and`, `or`, `unless`
- Can only be used on Instant Vectors
- Example:
  ```
  up == 1 and http_requests_total > 100
  ```
  - Returns series where the target is up and requests are greater than 100.

### 4 Set Operators
- Used to combine multiple series.
- Operators: `union`, `intersect`, `except`
- Example:
  ```
  http_requests_total{method="GET"} unless http_requests_total{status="500"}
  ```
  - Returns all GET requests excluding those with a 500 status code.

### 5 Aggregation Operators
- Used to aggregate series by labels.
- Operators: `sum`, `avg`, `min`, `max`, `count` , `group` , `count_values` , `topk` , `bottomk` , `stddev` , `stdvar`
- Example:
  ```
  sum(http_requests_total) by (method)
  or
  sum(http_requests_total) without (method)
  ```
  - Summarizes the total requests grouped by the HTTP method.
  - Summarizes the total requests without the HTTP method.

### 6 Practical Example
- Identify nodes with high CPU usage:
  ```
  node_cpu_seconds_total{mode="user"} > 1000
  ```
  - Flags nodes where CPU usage in user mode exceeds 1000 seconds.

---