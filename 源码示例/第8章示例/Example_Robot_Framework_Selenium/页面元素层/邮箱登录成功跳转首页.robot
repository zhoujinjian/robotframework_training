*** Settings ***
Library           Selenium2Library

*** Keywords ***
点击【应用中心】菜单
    Click Element    xpath=//div[text()='应用中心']

点击【收件箱】菜单
    Click Element    xpath=//div[text()='收件箱']
