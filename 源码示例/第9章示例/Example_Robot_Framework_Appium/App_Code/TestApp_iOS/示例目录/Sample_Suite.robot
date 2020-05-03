*** Settings ***
Suite Setup
Resource          ../../../App_Resource/TestApp_iOS.robot

*** Variables ***
${remote_url}     http://127.0.0.1:4723/wd/hub
${app}            /Users/zhoujinjian/Downloads/TestApp-iphonesimulator.app
${udid}           8AA9151A-1E3B-4272-AE62-5D8BC1D653C1
${automationName}    XCUITEST
${platformVersion}    12.1
${BundleId}       io.appium.TestApp

*** Test Cases ***
安装并启动TestApp_断言两个数计算求和
    [Setup]    安装并启动TestApp    ${remote_url}    ${app}    ${udid}    ${automationName}    ${platformVersion}
    @{els_list}    create list    accessibility_id=TextField1    accessibility_id=TextField2
    ${_sum}    Set Variable    ${0}
    : FOR    ${i}    IN RANGE    2
    \    ${rnd}    Evaluate    random.randint(0,10)    random
    \    input text    @{els_list}[${i}]    ${rnd}
    \    ${_sum}    Evaluate    ${_sum}+${rnd}
    log    ${_sum}
    click element    accessibility_id=ComputeSumButton
    ${sum}    Get Text    accessibility_id=Answer
    Should Be Equal As Integers    ${_sum}    ${sum}
    [Teardown]    Close Application

免安装通过BundleId启动被测App_断言两个数求和
    [Setup]    免安装启动被测App    ${remote_url}    ${BundleId}    ${udid}    ${automationName}    ${platformVersion}
    @{els_list}    create list    accessibility_id=TextField1    accessibility_id=TextField2
    ${_sum}    Set Variable    ${0}
    :FOR    ${i}    IN RANGE    2
    \    ${rnd}    Evaluate    random.randint(0,10)    random
    \    input text    @{els_list}[${i}]    ${rnd}
    \    ${_sum}    Evaluate    ${_sum}+${rnd}
    log    ${_sum}
    click element    accessibility_id=ComputeSumButton
    ${sum}    Get Text    accessibility_id=Answer
    Should Be Equal As Integers    ${_sum}    ${sum}
    [Teardown]    Close Application
