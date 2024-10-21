#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

PublicKey = "92345567890"
PublicKeyArray = list(PublicKey)
PublicKeylength = len(PublicKeyArray)


# region 加密-编码
def wordtonum(parm):
    i = parm % 85 + 32
    j = parm / 85
    str = chr(i)
    if (j > 0):
        return (wordtonum(j) + str)
    else:
        return str


# endregion
# region 加密函数（参数 明文字符串）
def encode(str):
    encodestr1 = ''.join([(wordtonum(ord(x))).rjust(3, "0") for x in str])
    encodestr2 = 'KYBC' + ''.join(
        [chr(ord(encodestr1[x]) + int(PublicKeyArray[x % PublicKeylength])) for x in range(0, len(encodestr1))])
    return encodestr2


# endregion

# region 解密-解码
def numtoword(str):
    if (ord(str[0]) != 48):
        return -32 + 85 * 85 * (-32 + ord(str[0])) + 85 * (-32 + ord(str[1])) + ord(str[2])
    else:
        if (ord(str[1]) != 48):
            return -32 + 85 * (-32 + ord(str[1])) + ord(str[2])
        else:
            return -32 + ord(str[2])


# endregion
# region 解密函数 (参数秘文)
def decode(str):
    if (len(str) < 4): return "XXXX1"
    if (str.startswith("KYBC") != 1): return "XXXX1"
    str = str[4:len(str)]
    decodestr1 = ''.join([chr(ord(str[x]) - int(PublicKeyArray[x % PublicKeylength])) for x in range(0, len(str))])
    decodestr1 = [decodestr1[i:i + 3] for i in xrange(0, len(decodestr1), 3)]
    decodestr1 = ''.join([chr(numtoword(x)) for x in decodestr1])
    return decodestr1


# endregion

# region 正确配对明、密文 1
CliperText = "dasd asd asd asd ads asd asd as d"
EncodeText = "KYBC9#24&16(F9!823D5&27)G0*134E5'38*>9#245E6(49!G2$355F7)50*13%C56G8*,9#A4&467H9!52$B5&578I0*.3%C56G8*/"
# endregion

# region 正确配对明、密文 2
CliperText1 = "lujinhui"
EncodeText1 = "KYBC9#:4&E6(=9!=2$=5&97)I0*6"


# endregion



# region 测试
# print encode(CliperText1)
# print  decode(EncodeText1)


def errorinputmsg():
    print("\033[1;41m 参数错误 \033[0m")
    print ("请输入参数  -e [加密] / -d [解密]  '明文/秘文'")
    print ("如：CARBLLNO.py -e 'TestText'")
    print ("或如：CARBLLNO.py -d 'KYBC92w4&56(F9!H23x5&67)L0*A'")


if (len(sys.argv) == 1):
    errorinputmsg()
else:
    if (len(sys.argv) == 3):
        if (sys.argv[1] == "-e"):
            print (encode(sys.argv[2]))
        elif (sys.argv[1] == "-d"):
            print (decode(sys.argv[2]))
        else:
            errorinputmsg()
    else:
        errorinputmsg()
# endregion
