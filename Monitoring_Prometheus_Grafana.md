# DevOps Monitoring & Observability Interview Questions – With Answers

This is a **comprehensive continuous list of interview questions** for DevOps engineers (3–7 years experience) covering **Prometheus, Grafana, monitoring, observability**, and **real-time scenarios**. All answers are detailed and include examples.

---

1. **What are the four core metric types in Prometheus?**  
**Answer:** Prometheus supports four main metric types:  
- **Counter:** Only increases over time. Example: `http_requests_total` counts total HTTP requests.  
- **Gauge:** Can increase or decrease. Example: `node_memory_usage_bytes` shows current memory usage.  
- **Histogram:** Measures the distribution of values over predefined buckets, e.g., request latency.  
- **Summary:** Calculates quantiles like p95/p99 over time for latency or response times.

2. **What is the pull model in Prometheus?**  
**Answer:** Prometheus uses a **pull-based model**, actively scraping metrics from endpoints over HTTP at intervals defined by `scrape_interval`. This allows Prometheus to control collection timing, handle missing targets, and scale efficiently in dynamic environments such as Kubernetes.

3. **What are exporters? Can you give examples?**  
**Answer:** Exporters expose metrics in Prometheus format:  
- **Node Exporter:** OS-level metrics (CPU, memory, disk, network).  
- **kube-state-metrics:** Kubernetes object metrics (pods, deployments, services).  
- **Blackbox Exporter:** Probes endpoints (HTTP/TCP/ICMP) for availability and response times.

4. **How does Prometheus store data?**  
**Answer:** Prometheus stores data in a **time-series database (TSDB)**. Each metric has a name, labels for context, timestamp, and value. TSDB supports retention policies, compression, and compaction to manage large datasets efficiently.

5. **What are labels? Why are they important? Give an example.**  
**Answer:** Labels are key-value pairs that **add context** to metrics and enable filtering and aggregation. Example:  
`node_cpu_seconds_total{instance="node1",mode="idle"} 12345`  
- Filter by node: `node_cpu_seconds_total{instance="node1"}`  
- Aggregate by mode: `sum by (mode)(node_cpu_seconds_total)`

6. **What is PromQL?**  
**Answer:** Prometheus Query Language (PromQL) allows selection, filtering, aggregation, and computation on metrics. It is used for dashboards, alerts, and data analysis.

7. **Difference between instant vector and range vector?**  
**Answer:**  
- **Instant vector:** Returns metrics at a single point in time, e.g., `up`.  
- **Range vector:** Returns metrics over a time range, e.g., `rate(http_requests_total[5m])` for per-second rate over 5 minutes.

8. **How do you calculate request rate per second?**  
**Answer:** Using the `rate` function:  
`rate(http_requests_total[5m])`  
It computes the per-second request rate over the last 5 minutes.

9. **How do you aggregate metrics by a label?**  
**Answer:** Use aggregation functions with `by(label)`. Example:  
`sum by (instance)(node_cpu_seconds_total{mode="idle"})`  
This calculates total idle CPU per node.

10. **How do you calculate p95 latency from histogram metrics?**  
**Answer:** Using `histogram_quantile`:  
`histogram_quantile(0.95, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))`  
This computes the 95th percentile of request duration over 5 minutes.

11. **What is an alerting rule in Prometheus?**  
**Answer:** A YAML rule defining **conditions, duration, labels, and annotations**. Example:  
- alert: HighCPUUsage  
  expr: node_cpu_seconds_total{mode="idle"} < 20  
  for: 5m  
  labels:  
    severity: critical  
  annotations:  
    summary: "CPU usage high on {{ $labels.instance }}"  

12. **What is Alertmanager and its role?**  
**Answer:** Alertmanager **receives alerts from Prometheus**, manages routing, grouping, silencing, and sends notifications to Slack, email, Teams, or PagerDuty. It prevents alert storms and ensures actionable notifications.

13. **How do you connect Prometheus as a data source in Grafana?**  
**Answer:** Add Prometheus as a data source in Grafana, set the URL, choose access type (proxy or direct), and save. Grafana can now query Prometheus metrics with PromQL.

14. **Dashboard vs Panel in Grafana?**  
**Answer:**  
- **Dashboard:** Collection of panels for a complete overview.  
- **Panel:** Individual visualization (graph, table, chart) using PromQL queries.

15. **How do you use PromQL in Grafana panels?**  
**Answer:** Write PromQL queries in the panel’s editor. Example:  
`rate(http_requests_total[5m])` → displays requests per second as a line chart.

16. **kube-state-metrics vs Node Exporter?**  
**Answer:**  
- **kube-state-metrics:** Metrics about Kubernetes objects (pods, deployments, services).  
- **Node Exporter:** OS metrics (CPU, memory, disk) for nodes.

17. **How do you set up an end-to-end monitoring stack in Kubernetes?**  
**Answer:** Use **Helm (kube-prometheus-stack)** to install Prometheus, Alertmanager, Grafana, Node Exporter, kube-state-metrics. Then configure dashboards, scrape targets, alert rules, and notification channels.

18. **Monitoring vs Observability?**  
**Answer:**  
- **Monitoring:** Tracks predefined metrics and alerts on known issues.  
- **Observability:** Allows understanding of unknown issues using metrics, logs, and traces for root cause analysis.

19. **What are the three pillars of observability?**  
**Answer:**  
- Metrics: Numeric system measurements.  
- Logs: Event records for context.  
- Traces: Request execution paths across services.

20. **What is Blackbox Exporter and its use?**  
**Answer:** Actively probes endpoints (HTTP, HTTPS, TCP, ICMP) and exposes metrics to Prometheus. Example:  
`probe_success{instance="example.com"} 1`  
Use cases: website availability, API response times.

21. **Average CPU per node last 5 min (PromQL)?**  
`avg(rate(node_cpu_seconds_total[5m])) by (instance)`

22. **Total HTTP 5xx errors per app (PromQL)?**  
`sum(rate(http_requests_total{status=~"5.."}[5m])) by (app)`

23. **Alert if CPU > 80% for 5 min (Prometheus alert)?**  
- alert: HighCPU  
  expr: 100 - (avg by(instance)(rate(node_cpu_seconds_total{mode="idle"}[5m]))*100) > 80  
  for: 5m  
  labels:  
    severity: critical  

24. **Alert if pod crash loop count > 3?**  
- alert: PodCrashLoop  
  expr: increase(kube_pod_container_status_restarts_total[10m]) > 3  
  for: 0m  
  labels:  
    severity: warning  

25. **Average memory per pod last 15 min (Grafana panel)?**  
`avg_over_time(container_memory_usage_bytes[15m]) by (pod)`

26. **p95 latency from histogram metric (PromQL)?**  
`histogram_quantile(0.95, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))`

27. **Total HTTP requests per service last 5 min (PromQL)?**  
`sum(rate(http_requests_total[5m])) by (service)`

28. **NodeHighCPU alert example (>90% for 10 min)?**  
- alert: NodeHighCPU  
  expr: 100 - (avg by(instance)(rate(node_cpu_seconds_total{mode="idle"}[5m]))*100) > 90  
  for: 10m  
  labels:  
    severity: critical  

29. **PodRestartCountHigh alert example?**  
- alert: PodRestartCountHigh  
  expr: increase(kube_pod_container_status_restarts_total[10m]) > 3  
  for: 0m  
  labels:  
    severity: warning  

30. **Panel for requests/sec per service in Grafana?**  
**Answer:** Use a **time-series line chart panel**, query Prometheus with:  
`sum(rate(http_requests_total[5m])) by (service)`  

31. **Heatmap of pod memory usage across the cluster in Grafana?**  
**Answer:** Use a **heatmap panel**, query:  
`avg_over_time(container_memory_usage_bytes[15m]) by (pod)` to visualize memory usage trends over time.

---
