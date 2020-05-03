*** Settings ***
Library           AppiumLibrary
Library           Collections

*** Keywords ***
Click Wait Element
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    timeout=15    error=Not Found
    Click Element    ${locator}

If Page Contain Element
    [Arguments]    ${locator}
    ${status}    ${value}=    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${locator}    15
    [Return]    ${status}
