# coding=utf-8

'''appium 微信h5自动化示例'''

from appium import webdriver
import time
import sys
import unittest

reload(sys)
sys.setdefaultencoding('utf-8')


class SimpleH5Tests(unittest.TestCase):
    def setUp(self):
        # set up appium
        self.driver = webdriver.Remote(
            command_executor='http://127.0.0.1:4723/wd/hub',
            desired_capabilities={
                'platformName': 'Android',
                'platformVersion': '8.0',
                'deviceName': '4a98a997',
                'fullReset': False,
                'noReset': True,
                'appPackage': 'com.tencent.mm',
                'appActivity': 'com.tencent.mm.ui.LauncherUI',
                'chromedriverExecutable': '/Users/zhoujinjian/chromedriver/chromedriver',
                'chromeOptions': {'androidProcess': 'com.tencent.mm:tools'},
            })
        self.driver.implicitly_wait(15)

    def tearDown(self):
        self.driver.quit()

    def test_switch_to_context(self):
        # 进入到目标页面
        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("发现")').click()
        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("看一看")').click()
        # 点击搜索框
        self.driver.find_element_by_class_name(
            "android.widget.ImageButton").click()
        time.sleep(10)
        # 打印webview contenxt
        print(self.driver.contexts)
        print(self.driver.current_context)

        # 切换webview
        self.driver.switch_to.context('WEBVIEW_com.tencent.mm:tools')
        self.driver.find_element_by_xpath(
            "//*[contains(@text,'我的在看')]").click()
        # 切到默认content
        self.driver.switch_to_default_content()


if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(SimpleH5Tests)
    unittest.TextTestRunner(verbosity=2).run(suite)
