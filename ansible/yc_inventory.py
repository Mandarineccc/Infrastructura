#!/usr/bin/env python3
import subprocess
import json
import sys

def output(var):
    try:
        result = subprocess.run(
            ["terraform", "output", "-raw", var],
            cwd="../terraform",
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError:
        return ""  # безопасный фолбэк

def get_inventory():
    return {
        "webservers": {
            "hosts": [
                "web1.ru-central1.internal",
                "web2.ru-central1.internal"
            ]
        },
        "zabbix": {
            "hosts": ["zabbix.ru-central1.internal"]
        },
        "elasticsearch": {
            "hosts": ["elasticsearch.ru-central1.internal"]
        },
        "kibana": {
            "hosts": ["kibana-server.ru-central1.internal"]
        },
        "bastion": {
            "hosts": ["bastion.ru-central1.internal"]
        },
        "_meta": {
            "hostvars": {}
        }
    }

if __name__ == "__main__":
    if "--list" in sys.argv:
        print(json.dumps(get_inventory(), indent=2))
    elif "--host" in sys.argv:
        print(json.dumps({}))  # not used
    else:
        print("Usage: --list or --host <hostname>", file=sys.stderr)
        sys.exit(1)
