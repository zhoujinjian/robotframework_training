*** Settings ***
Library           Selenium2Library

*** Keywords ***
勾选【第一封邮件】复选框
    Comment    Click Element    //*[contains(@class,'nui-chk')]
    @{checkout_box}    Get WebElements    //*[contains(@class,'nui-chk')]
    ${len}    get length    ${checkout_box}
    Click Element    ${checkout_box[2]}

标记【所选中邮件】已读
    Click Element    //span[text()='标记为']
    Capture Page Screenshot
    sleep    3
    Click Element    //span[text()='已读']
