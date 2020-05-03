*** Settings ***
Suite Setup       登录某某音乐App    ${remote_url}    ${appPackage}    ${appActivity}    ${udid}    ${automationName}    ${platformVersion}
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
点击指定歌单列表
    Click Wait Element    android=UiSelector().text("歌单")
    @{eles}    get_webelements    class=android.widget.ImageView
    Click Element    @{eles}[2]
    ${result_follow}    If Page Contain Element    android=UiSelector().text("关注")
    ${result_unfollow}    If Page Contain Element    android=UiSelector().text("已关注")
    run keyword if    '${result_follow}'=='PASS'    run keywords    Click Wait Element    android=UiSelector().text("关注")
    ...    AND    Page Should Contain Text    关注成功
    run keyword if    '${result_unfollow}'=='PASS'    run keywords    Click Wait Element    android=UiSelector().text("已关注")
    ...    AND    Click Wait Element    android=UiSelector().text("确定")
    ...    AND    Page Should Contain Text    取消关注成功
