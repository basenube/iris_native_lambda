import irisnative
import json
import time
import os


def lambda_handler(event, context):
    
    # Retrieve connection information from configuration file
    connection_detail = get_connection_info("connection.config")

    ip = connection_detail["ip"]
    port = int(connection_detail["port"])
    namespace = connection_detail["namespace"]
    username = connection_detail["username"]
    password = connection_detail["password"]

    # Overrides for Portal
    ip = os.environ.get('IRISHOST')
    port = int(os.environ.get('IRISPORT'))
    namespace = os.environ.get('NAMESPACE')
    username = os.environ.get('USERNAME')
    password = os.environ.get('PASSWORD')
    
    print("ip: " + ip)
    print("port: " + str(port))
    print("namespace: " + namespace)
    print("username: " + username)
    print("password: " + password)


    # Create connection to InterSystems IRIS
    connection = irisnative.createConnection(ip, port, namespace, username, password)

    print("Connected to InterSystems IRIS")

    # Create an iris object
    iris_native = irisnative.createIris(connection)

    # Managed wrapper class, hard-coded right now for sanity
    classname = "ZDEMO.IRIS.Lambda.Operations"
    returnvalue = ""

    # We are expecting an event object that looks like the following
    '''
    {
      "method": "Version",
      # important, if method requires no args, enforce "none"
      "args": "none"
      # example method with args, comma seperated
      # "args": "thing1, thing2"
    }
    '''
    method = event['method']
    args = event['args']

    # ok, here is the money for a returned value classname, method, args
    '''
    # "{\"status\":1,\"payload\":\"IRIS for UNIX (Red Hat Enterprise Linux for x86-64) 2020.2 (Build 210U) Thu Jun 4 2020 15:48:46 EDT\"}"
    # "{\"status\":1,\"payload\":\"Successfully set system mode to GAR\"}"
    '''
    if args == "none":
      returnvalue = iris_native.classMethodValue(classname,method)
    else:
      returnvalue = iris_native.classMethodValue(classname,method,args)

    # this object should be the JSON object above!
    return returnvalue
    
    
def get_connection_info(file_name):
    # Initial empty dictionary to store connection details
    connections = {}

    # Open config file to get connection info
    with open(file_name) as f:
        lines = f.readlines()
        for line in lines:
            # remove all white space (space, tab, new line)
            line = ''.join(line.split())

            # get connection info
            connection_param, connection_value = line.split(":")
            connections[connection_param] = connection_value
    
    return connections