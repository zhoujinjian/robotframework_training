# coding=utf-8
# 变量文件

from random import choice


class DataProvider(object):
    '''数据构造类'''

    def return_params_value(self):
        _list = ['张三', '李四', '王五', 'mikezhou', 'zhangsan', 'zhou', '医生']
        return choice(_list)


# 变量定义区
params_value = DataProvider().return_params_value()
