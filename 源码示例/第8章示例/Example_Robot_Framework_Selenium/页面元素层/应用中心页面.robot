*** Settings ***
Library           Selenium2Library

*** Keywords ***
点击【所有应用】元素
    Click Element    xpath=//*[text()='所有应用']

点击【有道词典】元素
    Click Element    xpath=//span[text()='有道词典']

点击【试用看看】元素
    Click Link    试用看看
