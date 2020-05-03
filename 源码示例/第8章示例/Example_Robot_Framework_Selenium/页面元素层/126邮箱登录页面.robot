*** Settings ***
Library           Selenium2Library

*** Keywords ***
点击【邮箱帐号登录】Tab
    Click Element    id=lbNormal

输入【邮箱登录帐号】文本框
    [Arguments]    ${text}
    Input Text    xpath=//input[@name="email"]    ${text}

输入【邮箱登录密码】密码框
    [Arguments]    ${passwd}
    Input Password    name=password    ${passwd}

点击【登录】按钮
    Click Element    id=dologin
