*** Settings ***
Test Setup        启动微信App    ${remote_url}    ${appPackage}    ${appActivity}    ${deviceName}    ${platformVersion}    ${androidProcess}
Test Teardown     Close Application
Resource          ../../../App_Resource/WeChat_XCX_ATHM.robot

*** Variables ***
${remote_url}     http://127.0.0.1:4723/wd/hub
${appPackage}     com.tencent.mm
${appActivity}    com.tencent.mm.ui.LauncherUI
${androidProcess}    com.tencent.mm:tools
${deviceName}     4a98a997
${platformVersion}    8.0

*** Test Cases ***
验证下拉App页面进入小程序
    [Setup]
    下拉App页面
    Click Element    android=UiSelector().text("汽车之家")
    Click Element    android=UiSelector().className("android.widget.TextView").text("选车")
    Click Element    android=UiSelector().text("大众")
    Page Should Contain Text    大众
    Page Should Contain Text    在售
    Page Should Contain Text    停售
    [Teardown]

验证通过微信搜索进入小程序
    微信搜索进入小程序    汽车之家
    Click Element    android=UiSelector().className("android.widget.TextView").text("选车")
    Click Element    android=UiSelector().text("大众")
    Page Should Contain Text    大众
    Page Should Contain Text    在售
    Page Should Contain Text    停售
