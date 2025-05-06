#!/usr/bin/env python3
import json
import subprocess

def output(terraform_output_name):
    """
    Функция для получения значения output из Terraform
    """
    command = ["terraform", "output", "-json", terraform_output_name]
    result = subprocess.run(command, stdout=subprocess.PIPE)
    return json.loads(result.stdout)

def get_infrastructure():
    lb_ip = output('load_balancer_ip')
    web_server_1_ip = output('web_server_1_ip')
    web_server_2_ip = output('web_server_2_ip')
    zabbix_server_ip = output('zabbix_server_ip')

    return {
        'web_servers': [web_server_1_ip, web_server_2_ip],
        'zabbix_server': [zabbix_server_ip],
        'load_balancer_ip': lb_ip
    }

if __name__ == '__main__':
    # Пример использования функции
    infrastructure = get_infrastructure()
    print(infrastructure)