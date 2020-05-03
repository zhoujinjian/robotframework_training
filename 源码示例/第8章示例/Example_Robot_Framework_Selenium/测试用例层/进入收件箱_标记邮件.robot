*** Settings ***
Suite Setup       邮箱帐号登录    mikezhou0806    sdoa6855700269
Suite Teardown    Close Browser
Resource          ../页面元素层/邮箱登录成功跳转首页.robot
Resource          ../页面元素层/收件箱页面.robot
Resource          ../公共组件层/浏览器.robot

*** Test Cases ***
标记最近一条邮件为已读
    点击【收件箱】菜单
    sleep    3
    勾选【第一封邮件】复选框
    sleep    3
    标记【所选中邮件】已读
