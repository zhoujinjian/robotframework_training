# coding=utf-8
'''Appium iOS真机自动化-酷狗音乐示例'''

from appium import webdriver
import unittest
import time
import os
import sys

reload(sys)
sys.setdefaultencoding('utf-8')


class SimpleIOSTests(unittest.TestCase):

    def setUp(self):
        # set up appium

        self.driver = webdriver.Remote(
            command_executor='http://127.0.0.1:4723/wd/hub',
            desired_capabilities={
                'platformName': 'iOS',
                'platformVersion': '11.4.1 ',
                'deviceName': 'iPhone 7',
                'udid': '90d58df50cfabe3226881283317b44c409a6a079',
                'automationName': 'XCUITEST',
                # 'useNewWDA': True,
                'bundleId': 'com.kugou.kugou1002'
            })
        self.driver.implicitly_wait(10)

    def tearDown(self):
        self.driver.quit()

    def test_visitors_trial(self):
        self.driver.find_element_by_ios_predicate("label=='游客试用'").click()
        self.driver.find_element_by_ios_predicate(
            "type=='XCUIElementTypeStaticText' AND label=='歌单'").click()
        self.driver.find_element_by_ios_predicate("label=='关注'").click()
        self.driver.find_element_by_ios_predicate("label LIKE '关注更多'").click()
        els = self.driver.find_elements_by_ios_predicate(
            "type=='XCUIElementTypeButton' AND label LIKE '关注'")
        els[0].click()
        time.sleep(5)


if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(SimpleIOSTests)
    unittest.TextTestRunner(verbosity=2).run(suite)
