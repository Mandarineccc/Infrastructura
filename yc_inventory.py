#!/usr/bin/env python3
import json

def main():
    inventory = {
        "all": {
            "children": {
                "zabbix-server": {
                    "hosts": {
                        "zabbix1.internal": {
                            "ansible_host": "192.168.10.32"
                        }
                    }
                },
                "web": {
                    "hosts": {
                        "web1.internal": {
                            "ansible_host": "192.168.10.17"
                        }
                    }
                }
            }
        }
    }
    
    print(json.dumps(inventory))

if __name__ == "__main__":
    main()

