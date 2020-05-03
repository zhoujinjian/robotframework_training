# coding=utf-8
from appium import webdriver
import time

desired_caps = {}
desired_caps['automationName'] = 'Appium'
desired_caps['platformName'] = 'Android'
desired_caps['platformVersion'] = '4.4.2'
desired_caps['deviceName'] = '127.0.0.1:62001'
desired_caps['udid'] = '127.0.0.1:62001'
desired_caps['newCommandTimeout'] = 360
desired_caps['unicodeKeyboard'] = True
desired_caps['resetKeyboard'] = True
desired_caps['autoGrantPermissions'] = True
desired_caps['noReset'] = True
desired_caps['appPackage'] = 'com.example.android.contactmanager'
desired_caps['appActivity'] = 'com.example.android.contactmanager.ContactManager'

# 这个是要安装的app的安装包地址，不是必须的，有这个项的话会先通过这个地址安装app，我没有用这个，直接用的Package名和activity名
#desired_caps['app'] = '/Users/xxx/apk/ContactManager.apk'


driver = webdriver.Remote('http://127.0.0.1:4723/wd/hub', desired_caps)
driver.implicitly_wait(10)
driver.find_element_by_id(
    "com.example.android.contactmanager:id/addContactButton").click()
driver.find_element_by_id(
    "com.example.android.contactmanager:id/contactNameEditText").send_keys("zhangsan")
driver.find_element_by_id(
    "com.example.android.contactmanager:id/contactPhoneEditText").send_keys("13612345678")
driver.find_element_by_id(
    "com.example.android.contactmanager:id/contactEmailEditText").send_keys("tester@126.com")
driver.find_element_by_id(
    "com.example.android.contactmanager:id/contactSaveButton").click()

time.sleep(5)
driver.quit()
