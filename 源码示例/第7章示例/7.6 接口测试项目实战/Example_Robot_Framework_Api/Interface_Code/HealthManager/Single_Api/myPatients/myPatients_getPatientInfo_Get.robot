*** Settings ***
Documentation     获取患者信息
Force Tags
Resource          ../../../../Resources/Business/HealthManager.robot
Library           Verification_Library

*** Test Cases ***    cloudUserId                         field
Class_01_获取患者信息       [Template]                          getPatientInfo_Get
                      3B9D321A26D7485393E49CC94D5A8113

Class_02_校验患者张三是否正常返回
                      [Tags]                              张三                                 env_prod    smoke
                      [Template]                          getPatientInfo_assertClass
                      66C64560E3C449A3BD1E4A53BBA6187E

Class_03_校验患者李四是否正常返回
                      [Template]                          getPatientInfo_assertClass
                      3B9D321A26D7485393E49CC94D5A8113

Exception_04_校验不存在的患者信息
                      [Template]                          getPatientInfo_assertException
                      1234567890                          -1

Exception_05_校验传入不符合用户规则
                      [Template]                          getPatientInfo_assertException
                      abcdef                              -1

DataVerify_06_校验患者age大于0
                      [Template]                          getPatientInfo_assertDataVerify
                      3B9D321A26D7485393E49CC94D5A8113    age

DataVerify_07_校验患者patientName非空
                      [Template]                          getPatientInfo_assertDataVerify
                      3B9D321A26D7485393E49CC94D5A8113    patientName

DataVerify_08_校验患者healthcardNo非空
                      [Template]                          getPatientInfo_assertDataVerify
                      3B9D321A26D7485393E49CC94D5A8113    healthcardNo

DataVerify_09_校验患者phone非空
                      [Template]                          getPatientInfo_assertDataVerify
                      3B9D321A26D7485393E49CC94D5A8113    phone

DataVerify_10_校验患者avatar非空
                      [Template]                          getPatientInfo_assertDataVerify
                      3B9D321A26D7485393E49CC94D5A8113    avatar

*** Keywords ***
getPatientInfo_Get
    [Arguments]    ${cloudUserId}
    Evaluate    reload(sys)    sys
    Evaluate    sys.setdefaultencoding( "utf-8" )    sys
    ${path}=    set variable    /ip-healthmanager-dtr-app-web/myPatients/getPatientInfo
    ${datas}=    create dictionary
    ${params}    create dictionary
    Comment    ${token}    get_login_token    ${phone}    ${password}
    Comment    ${token}=    Remove String    ${token}    "
    set to dictionary    ${params}    token=${token}
    set to dictionary    ${params}    cloudUserId=${cloudUserId}
    log    ---输出预期值---
    ${resp}=    request_get    ${URL}    ${path}    ${datas}    ${params}
    ${content}=    set variable    ${resp.content}
    ${content}=    charconver    ${resp.content}
    log    ---输出返回内容----：
    log json    ${content}    INFO
    log    ---开始断言验证---
    should be true    ${resp.status_code}==200
    [Return]    ${content}

getPatientInfo_assertClass
    [Arguments]    ${cloudUserId}
    ${content}    getPatientInfo_Get    ${cloudUserId}
    should contain    ${content}    "resultCode":0

getPatientInfo_assertException
    [Arguments]    ${cloudUserId}    ${errorCode}    ${errorMessage}
    ${content}    getPatientInfo_Get    ${cloudUserId}
    should contain    ${content}    "resultCode":${errorCode}
    should contain    ${content}    "errorMessage":${errorMessage}

getPatientInfo_assertDataVerify
    [Arguments]    ${cloudUserId}    ${field}
    ${content}    getPatientInfo_Get    ${cloudUserId}
    should contain    ${content}    "resultCode":0
    ${data}    get json value    ${content}    /data
    ${field_value}    get json value    ${data}    /${field}
    ${is_digit}    get_data_isdigit    ${field_value}
    run keyword if    ${is_digit}    run keyword    should be true    ${field_value}>0
    run keyword unless    ${is_digit}    Should Not Be Empty    ${field_value}
