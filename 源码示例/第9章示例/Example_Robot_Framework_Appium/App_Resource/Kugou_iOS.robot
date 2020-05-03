*** Settings ***
Library           AppiumLibrary
Resource          Common.robot

*** Keywords ***
启动某某音乐App
    [Arguments]    ${remote_url}    ${BundleId}    ${udid}    ${automationName}    ${platformVersion}
    Open Application    ${remote_url}    alias=KugouiOS    platformName=iOS    platformVersion=${platformVersion}    deviceName=iPhone 7    automationName=${automationName}
    ...    bundleId=${BundleId}    udid=${udid}
