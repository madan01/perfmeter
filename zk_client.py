#!/usr/bin/python

import sys
import time
import zc.zk
import subprocess
import os
import socket 

def main():
    mode_check = os.getenv('MODE',0)
    
    if (mode_check == 0):
        mode=os.environ['MODE']
    else:
        print 'slave'
    
    sys.exit(0)	
    
    local_ip=socket.gethostbyname(socket.gethostname())
    zk = zc.zk.ZooKeeper(os.environ['ZK_HOST']+':2181')
    zk.register('/perfmeter/slaves', (local_ip))
    subprocess.call(['jmeter/bin/jmeter-server'])

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print >> sys.stderr, '\nExiting by user request.\n'
        sys.exit(0)




