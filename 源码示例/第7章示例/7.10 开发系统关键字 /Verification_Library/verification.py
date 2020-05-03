# coding=utf-8
# 作用：公共json数据校验方法，遍历data数据，校验字符串及整型数值

from robot.api import logger


class Verfication(object):

    def verfication_data(self, data, msg=None):
        '''
        1、验证传入的参数，如果为字典，则遍历字典中的各个key，判断各个key值，如果为字符串型，则校验字符串为非空，如果为整型，则校验字符串大于0
        2、如果传入的参数为列表，则将列表中各个参数取出，如果列表中各个参数为字典，处理方法参照第1步。

        '''
        if isinstance(data, dict):
            logger.info("---基本信息获取---")
            logger.info("传入的data为json对象!")
            logger.info('传入过来的json对象主key的长度：%s' % len(data))
            keys = data.keys()
            logger.info(keys)
            logger.info('---开始进行校验---')
            # 定义变量，计算遍历次数
            times = 0
            for key, value in data.iteritems():
                times = times+1
                logger.info("")
                logger.info("---传入的data数据，第%s对象元素,key值对应为:%s---" %
                            (times, key))
                logger.info('%s:%s' % (key, value))
                self.analysis_subItem(value, msg)
        else:
            logger.info("传入的data数据不是dict对象")

    # 判断value值对应的类型，从而进行相应的处理，嵌入递归函数
    def analysis_subItem(self, item, msg):
        '''
        1、不管value值取出如何，最终还是拆解成最小单元，字符串或者是整型来进行判断
        :return:
        '''
        if isinstance(item, str):
            if self.get_length(item) == 0:
                raise AssertionError(msg or "'%s' should not be empty." % str)
        elif isinstance(item, int):
            if int(item) <= 0:
                raise AssertionError("当前int型获取到的数字小于等于0")

        elif isinstance(item, list):
            value_list_len = len(item)
            logger.info('%s对应值的类型为list且长度为%s' % (item, value_list_len))
            for i in range(value_list_len):
                logger.info("")
                logger.info("内嵌的列表中，第%s个子元素" % (i+1))
                self.analysis_subItem(item[i], msg)

        elif isinstance(item, dict):
            value_dict_len = len(item)
            logger.info('%s对应值的类型为dict且长度为%s' % (item, value_dict_len))
            times = 0
            for subkey, subvalue in item.iteritems():
                times = times+1
                logger.info("")
                logger.info("---内嵌的字典中,第%s对象元素,key值对应为:%s---" %
                            (times, subkey))
                logger.info('%s:%s' % (subkey, subvalue))
                self.analysis_subItem(subvalue, msg)

    # 计算字符串长度
    def get_length(self, item):
        length = self._get_length(item)
        logger.info('Length is %d' % length)
        logger.info("")
        return length

    def _get_length(self, item):
        try:
            return len(item)
        except:
            raise RuntimeError("Could not get length of '%s'." % item)


if __name__ == '__main__':
    run_object = Verfication()
