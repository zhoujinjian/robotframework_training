*** Settings ***
Suite Teardown    Close Application
Resource          ../../../App_Resource/Kugou_Android.robot

*** Variables ***
${remote_url}     http://127.0.0.1:4723/wd/hub
${appPackage}     com.kugou.android
${appActivity}    com.kugou.android.app.splash.SplashActivity
${udid}           192.168.58.101:5555
${automationName}    UiAutomator2
${platformVersion}    7.0

*** Test Cases ***
获取帐号密码错误Toast提示
    启动某某音乐App    ${remote_url}    ${appPackage}    ${appActivity}    ${udid}    ${automationName}    ${platformVersion}
    Click Wait Element    android=UiSelector().text("登录")
    Click Wait Element    android=UiSelector().text("帐号登录")
    Input Text    android=UiSelector().textContains("用户名")    ${username}
    Input Password    xpath=//*[@password="true"]    123456
    Click Wait Element    android=UiSelector().className("android.widget.Button").text("登录")
    Wait Until Page Contains Element    xpath=//*[contains(@text,'密码不正确')]    20
    ${toast_text}    get text    xpath=//*[contains(@text,'密码不正确')]
    Should Be Equal    ${toast_text}    用户名或密码不正确
