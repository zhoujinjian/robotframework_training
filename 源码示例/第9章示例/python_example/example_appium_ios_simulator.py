# coding=utf-8
'''Appium iOS模拟器自动化示例'''

from appium import webdriver
from random import randint
import unittest
import time
import os


class SimpleIOSTests(unittest.TestCase):

    def setUp(self):
        # set up appium
        app = os.path.abspath(
            '/Users/xxxx/Downloads/TestApp-iphonesimulator.app')
        self.driver = webdriver.Remote(
            command_executor='http://127.0.0.1:4723/wd/hub',
            desired_capabilities={
                'app': app,
                'platformName': 'iOS',
                'platformVersion': '11.2',
                'deviceName': 'iPhone 6s',
                'udid': '8AA9151A-1E3B-4272-AE62-5D8BC1D653C1',
                'automationName': 'XCUITEST'
            })
        self.driver.implicitly_wait(10)

    def tearDown(self):
        self.driver.quit()

    def _populate(self):
        els = [self.driver.find_element_by_accessibility_id('TextField1'),
               self.driver.find_element_by_accessibility_id('TextField2')]

        self._sum = 0
        for i in range(2):
            rnd = randint(0, 10)
            els[i].send_keys(rnd)
            self._sum += rnd

    def test_ui_computation(self):
        self._populate()
        self.driver.find_element_by_accessibility_id(
            'ComputeSumButton').click()
        sum = self.driver.find_element_by_accessibility_id('Answer').text
        self.assertEqual(int(sum), self._sum)


if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(SimpleIOSTests)
    unittest.TextTestRunner(verbosity=2).run(suite)
