*** Settings ***
Documentation     获取近期患者列表
Force Tags
Resource          ../../../../Resources/Business/HealthManager.robot
Variables         ../../../../Resources/Lib/variable.py

*** Test Cases ***    page                 pageSize                           paramsValue        field
Class_01_获取医生近期患者     [Template]           recentPatients_Get
                      1                    20                                 ${EMPTY}

Class_02_获取近期患者第1页10条
                      [Template]           recentPatients_assertClass
                      1                    10                                 ${params_value}

Class_03_获取近期患者第1页100条
                      [Template]           recentPatients_assertClass
                      1                    100                                ${EMPTY}

Class_04_获取近期患者第2页10条
                      [Template]           recentPatients_assertClass
                      2                    10                                 ${EMPTY}

Class_05_获取近期患者第10页1条
                      [Template]           recentPatients_assertClass
                      10                   1                                  ${EMPTY}

Class_06_获取陈姓患者第1页10条
                      [Template]           recentPatients_assertClass
                      1                    10                                 陈

Class_07_获取陈姓患者第2页5条
                      [Template]           recentPatients_assertClass
                      2                    5                                  陈

Exception_08_page页码留空
                      [Template]           recentPatients_assertException
                      \                    5                                  ${EMPTY}           page不能留空

Exception_09_page页码为非数字
                      [Template]           recentPatients_assertException
                      a                    5                                  ${EMPTY}

Exception_10_pageSize页数留空
                      [Template]           recentPatients_assertException
                      1                    \                                  ${EMPTY}

Exception_11_pageSize页数为非数字
                      [Template]           recentPatients_assertException
                      1                    a                                  ${EMPTY}

Exception_12_page页码为无穷大
                      [Template]           recentPatients_assertException
                      10000000000000000    1                                  ${EMPTY}

Exception_13_pageSize页数为无穷大
                      [Template]           recentPatients_assertException
                      1                    10000000000000000                  ${EMPTY}

Exception_14_page页码为负数
                      [Template]           recentPatients_assertException
                      -1                   10                                 ${EMPTY}

Exception_15_pageSize页数为负数
                      [Template]           recentPatients_assertException
                      1                    -10                                ${EMPTY}

DataVerify_16_校验返回的患者name非空
                      [Template]           recentPatients_assertDataVerify
                      1                    10                                 ${EMPTY}           name

DataVerify_17_校验返回的患者cloudUserId非空
                      [Template]           recentPatients_assertDataVerify
                      1                    10                                 ${EMPTY}           cloudUserId

DataVerify_18_校验返回的患者age大于0
                      [Template]           recentPatients_assertDataVerify
                      1                    10                                 ${EMPTY}           age

DataVerify_19_校验返回的患者focusStatus大于0
                      [Template]           recentPatients_assertDataVerify
                      1                    10                                 ${EMPTY}           focusStatus

DataVerify_20_校验返回的患者avatar非空
                      [Template]           recentPatients_assertDataVerify
                      1                    10                                 ${EMPTY}           avatar

DataVerify_21_校验返回的患者排序是否为时间降序
                      [Template]           recentPatients_assertDataVerify
                      1                    10                                 ${EMPTY}           date

*** Keywords ***
recentPatients_Get
    [Arguments]    ${page}    ${pageSize}    ${paramsValue}
    Evaluate    reload(sys)    sys
    Evaluate    sys.setdefaultencoding( "utf-8" )    sys
    ${path}=    set variable    /ip-healthmanager-dtr-app-web/groupMessage/recentPatients
    ${datas}=    create dictionary
    ${params}    create dictionary
    ${token}    get_login_token    ${phone}    ${password}
    ${token}=    Remove String    ${token}    "
    set to dictionary    ${params}    token=${token}
    set to dictionary    ${params}    page=${page}
    set to dictionary    ${params}    pageSize=${pageSize}
    set to dictionary    ${params}    paramsValue=${paramsValue}
    log    ---输出预期值---
    ${resp}=    request_get    ${URL}    ${path}    ${datas}    ${params}
    ${content}=    set variable    ${resp.content}
    ${content}=    charconver    ${resp.content}
    log    ---输出返回内容----：
    log json    ${content}    INFO
    log    ---开始断言验证---
    should be true    ${resp.status_code}==200
    [Return]    ${content}

recentPatients_assertClass
    [Arguments]    ${page}    ${pageSize}    ${paramsValue}
    ${content}    recentPatients_Get    ${page}    ${pageSize}    ${paramsValue}
    should contain    ${content}    "resultCode":0

recentPatients_assertException
    [Arguments]    ${page}    ${pageSize}    ${paramsValue}    ${errorMessage}
    ${content}    recentPatients_Get    ${page}    ${pageSize}    ${paramsValue}
    should contain    ${content}    "resultCode":0

recentPatients_assertDataVerify
    [Arguments]    ${page}    ${pageSize}    ${paramsValue}    ${field}
    ${content}    recentPatients_Get    ${page}    ${pageSize}    ${paramsValue}
    should contain    ${content}    "resultCode":0
    ${data}    get json value    ${content}    /data
    ${data}    replace string    ${data}    null    "null"
    ${data_list}    evaluate    list(${data})
    ${data_list_len}    get length    ${data_list}
    ${timstam_list}    create list
    : FOR    ${index}    IN RANGE    ${data_list_len}
    \    ${field_value}    Get From Dictionary    ${data_list[${index}]}    ${field}
    \    ${is_digit}    get_data_isdigit    ${field_value}
    \    run keyword if    ${is_digit}    run keyword    should be true    ${field_value}>0
    \    run keyword unless    ${is_digit}    Should Not Be Empty    ${field_value}
    \    ${timestamp}    run keyword if    '${field}'=='date'    get_timeStamp    ${field_value}
    \    append to list    ${timstam_list}    ${timestamp}
    run keyword if    '${field}'=='date'    list cmp    ${timstam_list}    ${False}
    ${排序方式}=    get_listcmp    ${timstam_list}
    should be equal    ${排序方式}    ${False}
