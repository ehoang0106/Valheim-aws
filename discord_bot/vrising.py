import boto3
import requests
import json


def load_data():
    with open('meta_data.json') as file:
        data = json.load(file)
    return data
    
    webhook=data['webhook']

def send_discord_message(message):
    pass


def stop_server():
    data=load_data()
    ec2_resource=boto3.resource('ec2',region_name=data['region'])
    instance=ec2_resource.Instance(data['instance_id'])
    ip_address=instance.public_ip_address
    
    instance.stop()
    print(f'Stopping EC2 instance: {instance.id}')
    instance.wait_until_stopped()
    print(f'EC2 instance "{instance.id}" has been stopped')
    
    message=f'Masters, Vrising server ({instance.id}) with ip-{ip_address} has stopped.'
    return message
    
def start_server():
    data=load_data()
    ec2_resource=boto3.resource('ec2',region_name=data['region'])
    instance=ec2_resource.Instance(data['instance_id'])
    
    instance.start()
    print(f'Starting EC2 instance: {instance.id}')        
    instance.wait_until_running()
    print(f'EC2 instance "{instance.id}" has been started')
    
    message=f'Masters, Vrising server has started and the new IP Address is {instance.public_ip_address}'
    return message