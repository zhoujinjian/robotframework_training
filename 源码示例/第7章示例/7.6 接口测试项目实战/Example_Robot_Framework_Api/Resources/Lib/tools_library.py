# _*_ coding:utf-8 _*_
import re
import os
import sys
import glob
import time
import hashlib
import random
import string
import urllib
import base64
import shutil
import struct
import urllib2
import urllib
import json
import requests
import datetime
import uuid
import subprocess
import platform

from multiprocessing import Process
from threading import Thread
from random import choice
from urllib3.exceptions import InsecureRequestWarning


exedir = os.path.abspath('.')
sys.path.insert(0, glob.glob(exedir)[0])


class tools_library(object):
    # 正则表达式等号分割字符串，用于header，cookie等处理
    def __init__(self):
        self.clients = {}

    def splitbyequal(self, arglist):

        pattern = re.compile(r'=')
        res = pattern.split(arglist, 1)
        return res

    def get_type(self, content):
        return type(content)

    def conver_evel(self, content):
        return eval(content)

    def charConver(self, content):
        """Converts the utf-8 content to unicode

        ex:
        | charConver | ${resp.content} |
        """
        CODEC = 'utf-8'
        str = content.decode(CODEC)
        return str

    def charConver_unicode(self, content):
        """converts chinese(unicode_escape) to unicode"""
        string = content.decode('unicode_escape')
        return string

    def utf8_decode(self, content):
        return content.decode('utf-8')

    def gettimestr(self):
        '''获取当前时间'''

        return datetime.datetime.now().strftime('%Y%m%d%H%M%S')

    def getmillisecond(self):
        '''获取当前时间'''

        return int(time.time()*1000)

    def get_data_isdigit(self, data):
        '''判断指定的数据是整型还是字符串'''

        if isinstance(data, int):
            return True
        elif isinstance(data, str):
            return False
        else:
            return None

    def get_timeStamp(self, timestr):
        timeArray = time.strptime(timestr, "%Y-%m-%d %H:%M:%S")
        timeStamp = int(time.mktime(timeArray))
        return timeStamp

    def randomchoice_from_list(self, list1):
        return choice(list1)

    def post_request_v1(self, url, headers, loginparams, cookies_dict):
        '''
        post请求
        '''

        # 禁用安全请求警告
        requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
        requests.adapters.DEFAULT_RETRIES = 5

        client = requests.Session()
        resp = client.post(url, headers=headers, data=loginparams,
                           cookies=cookies_dict, verify=False)
        return resp

    def generate_uuid(self):
        '''生成32bit uuid唯一字符串，并转换成大写'''
        gen_uuid = uuid.uuid1()
        return ''.join(str(gen_uuid).split('-')).upper()

    def post_request_v2(self, url, headers, loginparams, cookies_dict={}):
        '''
        post请求,data以json串传入
        '''

        # 禁用安全请求警告
        requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
        requests.adapters.DEFAULT_RETRIES = 5

        client = requests.Session()
        if loginparams:
            resp = client.post(url, headers=headers, data=json.dumps(
                loginparams), cookies=cookies_dict, verify=False)
        else:
            resp = client.post(url, headers=headers,
                               cookies=cookies_dict, verify=False)
        return resp


    def GetMiddleStr(self, content, startStr, endStr):
        """get the middle string between the startStr and endStr

        ex:
        | GetMiddleStr | AhelloB | A | B |
        The result is 'hello'
        """
        if '[' in startStr:
            startStr = startStr.replace('[', '\[')
        if ']' in endStr:
            endStr = endStr.replace(']', '\]')
        patternStr = r'%s(.+?)%s' % (startStr, endStr)
        p = re.compile(patternStr)
        res = p.search(content).groups()
        return res[0]



    # 随机生成字符串
    def randomstr(self, bit=16):
        """generate random string, default 16bit.

        ex:
        | ${str}= | randomstr | 13 |
        ==> ${str} is a 13 bit string
        """
        intbit = int(bit)
        seed = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        l = []
        for i in range(intbit):
            l.append(random.choice(seed))
        str = string.join(l).replace(' ', '')
        return str


    def utf8urlencode(self, content):
        str = urllib.urlencode({"a": content.encode("utf8")})
        return str

    def urldecode(self, content):
        contentstr = urllib.unquote(content)
        return unicode(contentstr)

    def get_listcmp(self, list1):
        '''
        如果传入的列表为升序则返回True, 如果不是，则返回False
        '''
        return all(x < y for x, y in zip(list1, list1[1:]))


if __name__ == '__main__':
    t = tools_library()
