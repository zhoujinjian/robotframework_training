# coding=utf-8
'''Appium iOS真机自动化示例'''

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
                'useNewWDA': True,
                'bundleId': 'com.tencent.xin'
            })
        self.driver.implicitly_wait(10)

    def tearDown(self):
        self.driver.quit()

    def test_login_no_password(self):
        self.driver.find_element_by_ios_predicate("label=='找回密码'").click()
        self.driver.find_element_by_ios_predicate(
            "label BEGINSWITH '不能'").click()
        self.driver.find_element_by_ios_predicate(
            "label LIKE '查询申诉进度'").click()
        get_title = self.driver.find_element_by_ios_predicate(
            "type=='XCUIElementTypeStaticText'").text
        self.assertIn('申诉找回微信帐号密码', get_title)


if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(SimpleIOSTests)
    unittest.TextTestRunner(verbosity=2).run(suite)
