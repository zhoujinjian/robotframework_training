*** Settings ***
Resource          ../../../App_Resource/Kugou_iOS.robot
Library           AppiumLibrary

*** Variables ***
${remote_url}     http://127.0.0.1:4723/wd/hub
${udid}           90d58df50cfabe3226881283317b44c409a6a079
${automationName}    XCUITEST
${platformVersion}    11.4.1
${BundleId}       com.kugou.kugou1002

*** Test Cases ***
游客在歌单达人列表点击关注
    [Setup]    启动某某音乐App    ${remote_url}    ${BundleId}    ${udid}    ${automationName}    ${platformVersion}
    Click Wait Element    nsp=label=='游客试用'
    Click Wait Element    nsp=type=='XCUIElementTypeStaticText' AND label=='歌单'
    Click Wait Element    nsp=label=='关注'
    Click Wait Element    nsp=label LIKE '关注更多'
    @{els}    Get Webelements    nsp=type=='XCUIElementTypeButton' AND label LIKE '关注'
    ${els_len}    get length    ${els}
    should be true    ${els_len}>1
    Click Element    @{els}[0]
    Page Should Contain Element    accessibility_id=登录
    Page Should Contain Element    nsp=name=='注册'
    [Teardown]    Close Application
