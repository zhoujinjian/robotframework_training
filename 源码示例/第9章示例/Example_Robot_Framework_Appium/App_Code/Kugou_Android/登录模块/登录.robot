*** Settings ***
Suite Teardown    Close Application
Resource          ../../../App_Resource/Kugou_Android.robot

*** Variables ***
${remote_url}     http://127.0.0.1:4723/wd/hub
${appPackage}     com.kugou.android
${appActivity}    com.kugou.android.app.splash.SplashActivity
${udid}           127.0.0.1:62001
${automationName}    appium
${platformVersion}    4.4.2

*** Test Cases ***
帐号密码登录
    启动某某音乐App    ${remote_url}    ${appPackage}    ${appActivity}    ${udid}    ${automationName}    ${platformVersion}
    Click Wait Element    android=UiSelector().text("登录")
    Click Wait Element    android=UiSelector().text("帐号登录")
    Input Text    android=UiSelector().textContains("用户名")    ${username}
    Input Password    xpath=//*[@password="true"]    ${password}
    Click Wait Element    android=UiSelector().className("android.widget.Button").text("登录")
    Wait_Until_Page_Contains    乐库    timeout=15
    Page_Should_Contain_Element    accessibility_id=侧边栏
