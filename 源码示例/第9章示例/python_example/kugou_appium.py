# coding=utf-8
from appium import webdriver
import time
import os

desired_caps = {}
desired_caps['automationName'] = 'Appium'
desired_caps['platformName'] = 'Android'
desired_caps['platformVersion'] = '4.4.2'
desired_caps['deviceName'] = '127.0.0.1:62001'
desired_caps['udid'] = '4a98a997'
desired_caps['newCommandTimeout'] = 360
desired_caps['unicodeKeyboard'] = True
desired_caps['resetKeyboard'] = True
desired_caps['autoGrantPermissions'] = True
# desired_caps['noReset'] = True
desired_caps['appPackage'] = 'com.kugou.android'
desired_caps['appActivity'] = 'com.kugou.common.useraccount.app.KgUserLoginAndRegActivity'


driver = webdriver.Remote('http://127.0.0.1:4723/wd/hub', desired_caps)
driver.implicitly_wait(10)

try:

    driver.find_element_by_android_uiautomator(
        'UiSelector().text("登录")').click()
    driver.find_element_by_android_uiautomator(
        'UiSelector().text("帐号登录")').click()
    driver.find_element_by_android_uiautomator(
        'UiSelector().textContains("用户名")').send_keys('username')
    driver.find_element_by_xpath('//*[@password="true"]').send_keys('password')
    driver.find_element_by_android_uiautomator(
        'UiSelector().className("android.widget.Button").text("登录")').click()

    time.sleep(3)
    os.system(
        'adb shell am start -n com.kugou.android/.app.MediaActivity')
    time.sleep(15)
except:
    pass
finally:
    driver.quit()
