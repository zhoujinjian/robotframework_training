*** Settings ***
Suite Setup       邮箱帐号登录    mikezhou0806    sdoa6855700269
Suite Teardown    Close Browser
Resource          ../公共组件层/浏览器.robot
Resource          ../页面元素层/有道词典页面.robot
Resource          ../页面元素层/邮箱登录成功跳转首页.robot
Resource          ../页面元素层/应用中心页面.robot

*** Test Cases ***
验证有道词典应用是否可用
    点击【应用中心】菜单
    sleep    3
    切换iFrame    //iframe[contains(@id,'frmoutlink.OutlinkModule')]
    点击【所有应用】元素
    点击【有道词典】元素
    Unselect Frame
    sleep    3
    点击【试用看看】元素
    切换iFrame    //iframe[contains(@id,'frmoutlink.OutlinkModule')]
    sleep    3
    Wait Until Element Is Visible    //*[@id="translateContent"]    timeout=15
    输入【翻译词】文本框    你好
    点击【翻译】按钮
