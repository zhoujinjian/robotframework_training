*** Settings ***
Library           AppiumLibrary
Resource          Common.robot

*** Keywords ***
启动微信App
    [Arguments]    ${remote_url}    ${appPackage}    ${appActivity}    ${deviceName}    ${platformVersion}    ${androidProcess}
    ${desired_capabilities}    Create Dictionary
    ${chromeOptions}    Create Dictionary
    Set To Dictionary    ${desired_capabilities}    platformName=Android
    Set To Dictionary    ${desired_capabilities}    automationName=uiautomator2
    Set To Dictionary    ${desired_capabilities}    fullReset=${False}
    Set To Dictionary    ${desired_capabilities}    noReset=${True}
    Set To Dictionary    ${desired_capabilities}    unicodeKeyboard=${True}
    Set To Dictionary    ${desired_capabilities}    resetKeyboard=${True}
    Set To Dictionary    ${desired_capabilities}    platformVersion=${platformVersion}
    Set To Dictionary    ${desired_capabilities}    deviceName=${deviceName}
    Set To Dictionary    ${desired_capabilities}    appPackage=${appPackage}
    Set To Dictionary    ${desired_capabilities}    appActivity=${appActivity}
    Set To Dictionary    ${chromeOptions}    androidProcess=${androidProcess}
    Set To Dictionary    ${desired_capabilities}    chromeOptions=${chromeOptions}
    Open Application    ${remote_url}    alias=WeChatapp    &{desired_capabilities}

下拉App页面
    [Arguments]    ${duration}=1000    ${counts}=1
    ${width}    get_window_width
    ${height}    get_window_height
    ${start_x}    Evaluate    ${width}*0.5
    ${start_y}    Evaluate    ${height}*0.25
    ${offset_y}    Evaluate    ${height}*0.75
    : FOR    ${i}    IN RANGE    ${counts}
    \    Swipe    ${start_x}    ${start_y}    ${start_x}    ${offset_y}    ${duration}
    sleep    3

微信搜索进入小程序
    [Arguments]    ${name}
    Click Element    id=com.tencent.mm:id/iq
    Click Element    android=UiSelector().text("小程序")
    Input Text    android=UiSelector().text("搜索小程序")    ${name}
    Click Element    android=UiSelector().className("android.view.View").textContains("${name}")
    Click Element    android=UiSelector().text("${name}")
