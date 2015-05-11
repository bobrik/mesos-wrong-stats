# Wrong CPU stats from mesos

This is an example for https://issues.apache.org/jira/browse/MESOS-2713.

Docker stats and [collectd-docker](https://github.com/bobrik/collectd-docker)
report correct values from cgroups.

Mesos slave with `/monitor/statistics.json` endpoint reports wrong data.
This happens because CPU usage is calculated on a tree and recalculated
each time. When process dies, all of it's usage is gone as well.

Three consecutive measurements:

```json
[
  {
    "statistics": {
      "timestamp": 1431340786.14526,
      "mem_rss_bytes": 671744,
      "mem_limit_bytes": 570425344,
      "cpus_user_time_secs": 0.72,
      "cpus_system_time_secs": 0.06,
      "cpus_limit": 1.1
    },
    "source": "wtf_wrong-stats.ce16b7c8-f7c9-11e4-a977-56847afe9799",
    "framework_id": "20150126-100650-3909200064-5050-1-0007",
    "executor_name": "Command Executor (Task: wtf_wrong-stats.ce16b7c8-f7c9-11e4-a977-56847afe9799) (Command: NO EXECUTABLE)",
    "executor_id": "wtf_wrong-stats.ce16b7c8-f7c9-11e4-a977-56847afe9799"
  }
]
```

```json
[
  {
    "statistics": {
      "timestamp": 1431340786.86123,
      "mem_rss_bytes": 671744,
      "mem_limit_bytes": 570425344,
      "cpus_user_time_secs": 1.43,
      "cpus_system_time_secs": 0.07,
      "cpus_limit": 1.1
    },
    "source": "wtf_wrong-stats.ce16b7c8-f7c9-11e4-a977-56847afe9799",
    "framework_id": "20150126-100650-3909200064-5050-1-0007",
    "executor_name": "Command Executor (Task: wtf_wrong-stats.ce16b7c8-f7c9-11e4-a977-56847afe9799) (Command: NO EXECUTABLE)",
    "executor_id": "wtf_wrong-stats.ce16b7c8-f7c9-11e4-a977-56847afe9799"
  }
]
```

```json
[
  {
    "statistics": {
      "timestamp": 1431340787.79716,
      "mem_rss_bytes": 671744,
      "mem_limit_bytes": 570425344,
      "cpus_user_time_secs": 0,
      "cpus_system_time_secs": 0.02,
      "cpus_limit": 1.1
    },
    "source": "wtf_wrong-stats.ce16b7c8-f7c9-11e4-a977-56847afe9799",
    "framework_id": "20150126-100650-3909200064-5050-1-0007",
    "executor_name": "Command Executor (Task: wtf_wrong-stats.ce16b7c8-f7c9-11e4-a977-56847afe9799) (Command: NO EXECUTABLE)",
    "executor_id": "wtf_wrong-stats.ce16b7c8-f7c9-11e4-a977-56847afe9799"
  }
]
```
