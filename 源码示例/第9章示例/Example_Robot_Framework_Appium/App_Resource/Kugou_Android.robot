*** Settings ***
Library           AppiumLibrary
Resource          Common.robot

*** Keywords ***
启动某某音乐App
    [Arguments]    ${remote_url}    ${appPackage}    ${appActivity}    ${udid}    ${automationName}    ${platformVersion}
    Open Application    ${remote_url}    alias=kugouapp    platformName=Android    deviceName=${udid}    automationName=${automationName}    appActivity=${appActivity}
    ...    appPackage=${appPackage}    udid=${udid}    platformVersion=${platformVersion}    unicodeKeyboard=${True}    resetKeyboard=${True}
    跳过欢迎页

跳过欢迎页
    ${status}    if page contain element    android=UiSelector().text("跳过")
    run keyword if    '${status}'=='PASS'    Click Wait Element    android=UiSelector().text("跳过")

登录某某音乐App
    [Arguments]    ${remote_url}    ${appPackage}    ${appActivity}    ${udid}    ${automationName}    ${platformVersion}
    启动某某音乐App    ${remote_url}    ${appPackage}    ${appActivity}    ${udid}    ${automationName}    ${platformVersion}
    Click Wait Element    android=UiSelector().text("登录")
    Click Wait Element    android=UiSelector().text("帐号登录")
    Input Text    android=UiSelector().textContains("用户名")    ${username}
    Input Password    xpath=//*[@password="true"]    ${password}
    Click Wait Element    android=UiSelector().className("android.widget.Button").text("登录")
    Wait_Until_Page_Contains    乐库    timeout=15
    Page_Should_Contain_Element    accessibility_id=侧边栏
