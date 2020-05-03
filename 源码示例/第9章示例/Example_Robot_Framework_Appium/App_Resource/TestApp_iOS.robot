*** Settings ***
Library           AppiumLibrary
Resource          Common.robot

*** Keywords ***
安装并启动TestApp
    [Arguments]    ${remote_url}    ${app}    ${udid}    ${automationName}    ${platformVersion}
    Open Application    ${remote_url}    alias=TestApp    platformName=iOS    platformVersion=${platformVersion}    deviceName=iPhone 6s    automationName=${automationName}
    ...    app=${app}    udid=${udid}

免安装启动被测App
    [Arguments]    ${remote_url}    ${BundleId}    ${udid}    ${automationName}    ${platformVersion}
    Open Application    ${remote_url}    alias=TestApp    platformName=iOS    platformVersion=${platformVersion}    deviceName=iPhone 6s    automationName=${automationName}
    ...    bundleId=${BundleId}    udid=${udid}
