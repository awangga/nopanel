# -*- coding: utf-8 -*-
"""
Created on Fri Jun 18 08:12:42 2021

@author: rolly
"""

import dns.resolver
from datetime import datetime
from time import sleep

google = dns.resolver.Resolver()
hyper1 = dns.resolver.Resolver()
hyper2 = dns.resolver.Resolver()

def lookupdomain(module,nameserver,recordtype,domainname):
    module.nameservers = [nameserver] # using google DNS
    try:
        result = module.resolve(domainname, recordtype)
        records = [ns.to_text() for ns in result]
    except:
        records = ['RTO']
    return records

def cekdns(dnstest):
    inisiasiresolver = dns.resolver.Resolver()
    records=lookupdomain(inisiasiresolver,dnstest,'A','bukalapak.com')
    if records[0] == 'RTO':
        print('RTO')
        ket=datetime.now().strftime("%Y-%m-%d %H:%M:%S.%f")+" | "+dnstest+" | Terjadi Time Out Lookup Domain"
        with open("rtodns.log","a") as logrto:
           logrto.write(ket+"'\n")
    else:
        print(dnstest+' aman resolved')

while True:
    print('cek local DNS')
    cekdns('192.168.1.220')
    print('cek google DNS')
    cekdns('8.8.8.8')
    print('cek hyper1 DNS')
    cekdns('103.10.60.133')
    print('cek hyper2 DNS')
    cekdns('114.129.23.33')
    sleep(1)

#a=lookupdomain(google,'8.8.8.8','A','bukalapak.com')
#b=lookupdomain(hyper1,'103.10.60.133','A','bukalapak.com')
#c=lookupdomain(hyper2,'114.129.23.33','A','bukalapak.com')