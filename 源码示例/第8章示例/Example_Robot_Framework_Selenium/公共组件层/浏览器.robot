*** Settings ***
Library           Selenium2Library
Resource          ../页面元素层/126邮箱登录页面.robot

*** Keywords ***
打开Chrome浏览器
    [Arguments]    ${url}    ${browser}=chrome
    Open Browser    ${url}    ${browser}

切换iFrame
    [Arguments]    ${locator}
    Select Frame    ${locator}

邮箱帐号登录
    [Arguments]    ${email}    ${password}
    打开Chrome浏览器    https://mail.126.com/
    点击【邮箱帐号登录】Tab
    切换iFrame    //iframe[contains(@id,'x-URS-iframe')]
    输入【邮箱登录帐号】文本框    ${email}
    输入【邮箱登录密码】密码框    ${password}
    点击【登录】按钮
    sleep    5
    Click Link    登录
    sleep    5
    ${loginSuccessText}    Get Text    spnUid
    Should Not Be Empty    ${loginSuccessText}
    Should Contain    ${loginSuccessText}    ${email}
