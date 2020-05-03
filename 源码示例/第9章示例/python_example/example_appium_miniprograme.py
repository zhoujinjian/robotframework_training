# coding=utf-8

'''appium 微信小程序自动化示例'''

from appium import webdriver
import time
import sys
import unittest

reload(sys)
sys.setdefaultencoding('utf-8')


class SimpleMiniProgrameTests(unittest.TestCase):
    def setUp(self):
        # set up appium
        self.driver = webdriver.Remote(
            command_executor='http://127.0.0.1:4723/wd/hub',
            desired_capabilities={
                'platformName': 'Android',
                'automationName': 'uiautomator2',
                'platformVersion': '8.0',
                'deviceName': '4a98a997',
                'fullReset': False,
                'noReset': True,
                'unicodeKeyboard': True,
                'resetKeyboard': True,
                'appPackage': 'com.tencent.mm',
                'appActivity': 'com.tencent.mm.ui.LauncherUI',
                'chromeOptions': {'androidProcess': 'com.tencent.mm:tools'},
                'chromedriverExecutable': '/Users/xxx/chromedriver/chromedriver'

            })
        self.driver.implicitly_wait(15)
        time.sleep(8)

    def tearDown(self):
        self.driver.quit()

    def atest_miniprograme_search_name(self):
        '''测试通过小程序名称进入'''

        self.search_miniprograme_name_v1('汽车之家')
        # self.handler_action()

    def test_miniprograme_drop_down(self):
        '''测试通过下拉进入小程序'''

        self.swipe_down(self.driver)
        # self.handler_programe('美团外卖')
        # self.handler_action()

    def search_miniprograme_name(self, name):
        '''根据小程序名称，进入小程序'''

        self.driver.find_element_by_id('com.tencent.mm:id/iq').click()
        self.delay_print_context()
        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("小程序")').click()
        # self.driver.switch_to.context('WEBVIEW_com.tencent.mm:tools')
        # self.driver.find_element_by_xpath(
        #     "//*[contains(@text,'小程序')]").click()
        self.delay_print_context()
        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("搜索小程序")').send_keys(u'{}'.format(name))
        self.driver.find_element_by_android_uiautomator(
            'UiSelector().className("android.view.View").textContains("{}")'.format(name)).click()
        self.delay_print_context()
        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("{}")'.format(name)).click()
        self.delay_print_context()

    def search_miniprograme_name_v1(self, name):
        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("发现")').click()
        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("搜一搜")').click()
        self.delay_print_context()
        # self.driver.switch_to.context('WEBVIEW_com.tencent.mm:tools')
        # self.delay_print_context()
        time.sleep(8)

        # get_hotword = self.driver.find_element_by_css_selector(
        #     '.hotword-box__title').getAttribute("value")
        get_hotword = self.driver.find_element_by_xpath(
            '//div[contains(@class,"hotword-box__title")]')

        # self.driver.find_element_by_android_uiautomator(
        #     'UiSelector().text("小程序")').click()

    def handler_action(self):
        '''进入小程序后的处理动作'''

        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("汽车之家")').click()
        self.delay_print_context()
        # self.driver.switch_to.context('WEBVIEW_com.tencent.mm:tools')
        self.driver.find_element_by_android_uiautomator(
            'UiSelector().className("android.widget.TextView").text("选车")').click()
        self.delay_print_context()

        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("大众")').click()
        self.delay_print_context()
        page_source = self.driver.page_source
        self.assertIn('大众', page_source)
        self.assertIn('在售', page_source)
        self.assertIn('停售', page_source)

    def handler_programe(self, name):
        '''进入小程序后的处理动作'''

        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("{}")'.format(name)).click()
        self.delay_print_context()
        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("美食")').click()
        self.delay_print_context()

        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("综合排序")').click()
        self.driver.find_element_by_android_uiautomator(
            'UiSelector().text("距离最近")').click()
        self.delay_print_context()

    def swipe_down(self, driver, t=1000, n=1):
        '''根据屏幕分辨率大小，实现当前屏幕下拉操作'''

        size = driver.get_window_size()
        x1 = size['width'] * 0.5  # x坐标
        y1 = size['height'] * 0.25  # 起点y坐标
        y2 = size['height'] * 0.75  # 终点y坐标
        for i in range(n):
            driver.swipe(x1, y1, x1, y2, t)

    def delay_print_context(self, second=5):
        time.sleep(second)
        print(self.driver.contexts)
        print(self.driver.current_context)


if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(SimpleMiniProgrameTests)
    unittest.TextTestRunner(verbosity=2).run(suite)
