#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import os
import binascii
curPath = os.path.abspath(os.path.dirname(__file__))
rootPath = os.path.split(curPath)[0]
sys.path.append(rootPath)
from pyDes import des, CBC, PAD_PKCS5 
# 秘钥
MyValue ="e580e38eb1dac625013a2f5c206edd51d2ba91cfc648bb7b4592b6d7112c69a584b363d2549c05e576ade0b3609983fe1d6719b8d073b3fd8900831badd3d17a7c831963beb1c34c012c01d4652cd5ca"
def des_encrypt(s):
    """
    DES 加密
    :param s: 原始字符串
    :return: 加密后字符串，16进制
    """
    KEY=input("请输入私钥:")
    if (len(KEY)<8):
        print ("私钥长度需要大于8位")
    secret_key = KEY
    iv = secret_key
    k = des(secret_key, CBC, iv, pad=None, padmode=PAD_PKCS5)
    en = k.encrypt(s, padmode=PAD_PKCS5)
    return binascii.b2a_hex(en).decode('utf8')

 
 
def des_descrypt(s):
    """
    DES 解密
    :param s: 加密后的字符串，16进制
    :return:  解密后的字符串
    """
    KEY=input("请输入私钥:")
    if (len(KEY)<8):
        print ("私钥长度需要大于8位")
    secret_key = KEY
    iv = secret_key
    k = des(secret_key, CBC, iv, pad=None, padmode=PAD_PKCS5)
    de = k.decrypt(binascii.a2b_hex(s), padmode=PAD_PKCS5)
    return de.decode('utf8')

def errorinputmsg():
    print("\033[1;41m 参数错误 \033[0m")
    print ("请输入参数 -e（加密） / -d (解密)  '明文/秘文'")
    print ("如：v2ray.py -e 'TestText'")
    print ("或如：v2ray.py -d 123456789")


#print(len(sys.argv))
#print(sys.argv[0])
#print(sys.argv[1])
#print(sys.argv[2])
#print(sys.argv[3])

if (len(sys.argv) < 1):
    errorinputmsg()
elif(len(sys.argv)==2):
    if(sys.argv[1]=="-q"):
        print (des_descrypt(MyValue))
    else:
        errorinputmsg();
elif(len(sys.argv)== 3):
    if (sys.argv[1] == "-e"):
        print (des_encrypt(sys.argv[2]))
    if (sys.argv[1] == "-d"):
        print (des_descrypt(sys.argv[2]))
else:
    errorinputmsg()   
