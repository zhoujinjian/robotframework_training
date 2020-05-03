*** Settings ***
Library           Selenium2Library

*** Keywords ***
输入【翻译词】文本框
    [Arguments]    ${text}
    Input Text    //*[@id="translateContent"]    ${text}

点击【翻译】按钮
    Click Button    翻译
