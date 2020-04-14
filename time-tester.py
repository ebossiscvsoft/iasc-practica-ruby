#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Aug 21 19:50:48 2018

@author: leandronarosky
"""

import random
import time
from uritemplate import URITemplate
import requests
import random
from queue import Queue
from threading import Thread
import numpy as np
import scipy.stats as stats
import pylab as pl
import matplotlib.pyplot as pyplot
from collections import Counter
import sys

url = sys.argv[1]

quantity= int(sys.argv[2])
  
print("Results for " + url)
times = []
    
def do_request(url):
    r = requests.get(url)
    times.append((r.status_code,r.elapsed.total_seconds(),r.url))
    return r

q = Queue(maxsize=0)
num_threads = min(50, quantity)

for i in range(quantity):
    q.put(url)
    
def execute_requests(q):
    while not q.empty():
        work=q.get()
        try:
            do_request(work)
        except Exception as e:
            print("something failed" + str(e))
        q.task_done()
    return True

for i in range(num_threads):
    worker = Thread(target=execute_requests, args=(q,))
    worker.setDaemon(True)
    worker.start()

q.join()

h = sorted([y for (x,y,z) in times])
print("Mean: "+ str(np.mean(h)))
print("Std: " + str(np.std(h)))                
fit = stats.norm.pdf(h, np.mean(h), np.std(h))
pl.plot(h,fit,'-o')
pl.xlabel("Time in seconds")
pl.hist(h,density=True)     
pl.show()

count = Counter([x for (x,y,z) in times])
pyplot.pie([float(v) for v in count.values()], labels=['Status: ' + str(k) for k in count],
           autopct=None)

    


 
