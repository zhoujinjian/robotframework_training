*** Settings ***
Documentation     获取患者信息业务场景
Force Tags
Resource          ../../../../Resources/Business/HealthManager.robot

*** Test Cases ***    page          pageSize                     index
Business_01_校验列表中第1位患者信息
                      [Template]    getPatientInfo_assertFlow
                      1             20                           0

Business_02_校验列表中第2位患者信息
                      [Template]    getPatientInfo_assertFlow
                      1             20                           1

Business_03_校验列表中第3位患者信息
                      [Template]    getPatientInfo_assertFlow
                      1             20                           2

Business_04_随机校验列表任一患者信息
                      [Template]    getPatientInfo_assertFlow
                      1             20                           random

Business_05_遍历校验列表所有患者信息
                      [Template]    getPatientInfo_assertFlow
                      1             20

*** Keywords ***
getPatientInfo_assertFlow
    [Arguments]    ${page}    ${pageSize}    ${index}=${None}
    [Documentation]    获取患者信息业务流程
    ${token}    get_login_token    ${phone}    ${password}
    ${token}=    Remove String    ${token}    "
    ${cloudUserId_list}    get_recentPatients_list    ${page}    ${pageSize}    ${EMPTY}    ${token}
    run keyword if    '${index}'=='${None}'    getPatientInfo_forloop    ${cloudUserId_list}    ${token}
    ${status}    ${randomchoice}=    Run Keyword And Ignore Error    randomchoice_from_list    ${cloudUserId_list}
    ${status}    ${orderchoice}=    Run Keyword And Ignore Error    get from list    ${cloudUserId_list}    ${index}
    ${cloudUserId}=    Set Variable If    '${index}'=='random'    ${randomchoice}    ${orderchoice}
    getPatientInfo_Get    ${cloudUserId}    ${token}

getPatientInfo_forloop
    [Arguments]    ${cloudUserId_list}    ${token}
    : FOR    ${cloudUserId}    IN    @{cloudUserId_list}
    \    log    ${cloudUserId}
    \    getPatientInfo_Get    ${cloudUserId}    ${token}
    Pass Execution    全部遍历完成
