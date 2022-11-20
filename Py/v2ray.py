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
MyValue="c32014cf234226d2cd1205dc6de8aaf88736ab3fc0a56b29b99c56c571f2ecc28b63b84de610b436764637bbd3b6f4ede58469cd5a19e11556832fa959a0b14c99edb1503b5fbad95de05db0c5a9c7fb44422ab432eb473da989134b7f2219e96742b8ca3154dc9f587dc7b50a092a8e8ab8a5fcab75da8173e96e478f61b6a0df3497cb5424e4f100c5a6d88fb32eb83682126e2d69ee8d"

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
