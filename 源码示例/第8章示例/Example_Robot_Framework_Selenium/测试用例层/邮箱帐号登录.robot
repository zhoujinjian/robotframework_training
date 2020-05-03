*** Settings ***
Suite Teardown    Close Browser
Test Teardown
Resource          ../公共组件层/浏览器.robot
Resource          ../页面元素层/126邮箱登录页面.robot

*** Test Cases ***
验证正确的邮箱帐号密码登录
    打开Chrome浏览器    https://mail.126.com/
    点击【邮箱帐号登录】Tab
    切换iFrame    //iframe[contains(@id,'x-URS-iframe')]
    输入【邮箱登录帐号】文本框     ${username}
    输入【邮箱登录密码】密码框    ${password}
    点击【登录】按钮
    sleep    15
    Click Link    登录
    sleep    5
    ${loginSuccessText}    Get Text    spnUid
    Should Not Be Empty    ${loginSuccessText}
    Should Contain    ${loginSuccessText}     ${username}
