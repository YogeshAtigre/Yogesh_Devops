##  **Sorting, Timestamps, and Aggregation Over Time**

### 1 Sorting Functions
- `sort()`: Sorts the elements in ascending order.
- `sort_desc()`: Sorts the elements in descending order.

**Example:**
```promql
sort_desc(http_requests_total)
```
- Returns metrics sorted by the highest number of requests.

### 2 Timestamp Functions
- `time()`: Returns the current server time as a scalar.
- `timestamp()`: Returns the timestamp of a given metric.

**Example:**
```promql
timestamp(http_requests_total)
```
- Displays the timestamp of the last recorded value for the given metric.

### 3 Aggregation Over Time
- `sum_over_time()`, `avg_over_time()`, `min_over_time()`, `max_over_time()`, `stddev_over_time()`, `stdvar_over_time()`, `count_over_time()`, `quantile_over_time()`

**Example:** Calculate average CPU usage over the last 5 minutes:
```promql
avg_over_time(node_cpu_seconds_total[5m])
```
- Provides the average CPU usage over the specified time window.

### 4 Practical Use Case
- **Anomaly Detection:**
```promql
increase(http_requests_total[1h]) > increase(http_requests_total[1h] offset 1d)
```
- Detects if the current hour's request increase is greater than the same hour yesterday.

---