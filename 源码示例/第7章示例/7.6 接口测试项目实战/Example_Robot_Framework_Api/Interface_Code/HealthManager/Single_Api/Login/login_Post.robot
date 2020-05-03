*** Settings ***
Documentation     Login登录接口
Force Tags        login
Resource          ../../../../Resources/Business/HealthManager.robot

*** Test Cases ***    brandEquipmentModelPushId           password                  phone          pushClientId    vcode       errorMessage
Class_01_手机号密码正常登录    [Documentation]                     手机号密码正常登录
                      [Tags]                              online                    test           mikezhou
                      [Template]                          login_Post
                      ${EMPTY}                            ${password}               ${phone}       ${EMPTY}        ${EMPTY}

Class_02_brand型号非空    [Documentation]                     brand型号非空
                      [Tags]                              online                    test           mikezhou
                      [Template]                          login_assertClass
                      BBC937DA541E4AF6884C2DE2D5FCC8C0    ${password}               ${phone}       ${EMPTY}        ${EMPTY}

Class_03_pushClientId非空
                      [Documentation]                     pushClientId非空
                      [Tags]                              online                    test           mikezhou
                      [Template]                          login_assertClass
                      ${EMPTY}                            ${password}                ${phone}      9100            ${EMPTY}

Class_04_vcode非空      [Documentation]                     vcode非空
                      [Tags]                              online                    test           mikezhou
                      [Template]                          login_assertClass
                      ${EMPTY}                            ${password}                ${phone}    ${EMPTY}        1000

Exception_05_登录密码错误
                      [Template]                          login_assertException
                      ${EMPTY}                            111111                     ${phone}    ${EMPTY}        ${EMPTY}    登录密码错误

Exception_06_登录密码留空
                      [Template]                          login_assertException
                      ${EMPTY}                            \                          ${phone}    ${EMPTY}        ${EMPTY}    密码不能同时为空

Exception_07_手机号不存在
                      [Template]                          login_assertException
                      ${EMPTY}                            ${password}                  ${phone}1    ${EMPTY}        ${EMPTY}    账户不存在

Exception_08_手机号不符合规则
                      [Template]                          login_assertException
                      ${EMPTY}                            ${password}                  12345678       ${EMPTY}        ${EMPTY}    账户不存在

DataVerify_09_关键字段校验
                      [Template]                          login_assertDataVerify
                      ${EMPTY}                            ${password}                 ${phone}    ${EMPTY}        ${EMPTY}

*** Keywords ***
login_Post
    [Arguments]    ${brandEquipmentModelPushId}    ${password}    ${phone}    ${pushClientId}    ${vcode}
    [Documentation]    login登录接口
    Evaluate    reload(sys)    sys
    Evaluate    sys.setdefaultencoding( "utf-8" )    sys
    ${path}=    set variable    /ip-healthmanager-dtr-app-web/login?token
    ${datas}=    create dictionary
    ${params}    create dictionary
    set to dictionary    ${datas}    brandEquipmentModelPushId=${brandEquipmentModelPushId}
    set to dictionary    ${datas}    password=${password}
    set to dictionary    ${datas}    phone=${phone}
    set to dictionary    ${datas}    pushClientId=${pushClientId}
    set to dictionary    ${datas}    vcode=${vcode}
    log    ${datas}
    log    ---输出预期值---
    ${resp}=    request_post    ${URL}    ${path}    ${datas}    ${params}
    log    ${resp.content}
    ${content}=    set variable    ${resp.content}
    log    ---输出返回内容----：
    log json    ${content}    INFO
    should be true    ${resp.status_code}==200
    [Return]    ${content}

login_assertClass
    [Arguments]    ${brandEquipmentModelPushId}    ${password}    ${phone}    ${pushClientId}    ${vcode}
    [Documentation]    正常场景
    ${content}=    login_post    ${brandEquipmentModelPushId}    ${password}    ${phone}    ${pushClientId}    ${vcode}
    should contain    ${content}    "resultCode":0

login_assertException
    [Arguments]    ${brandEquipmentModelPushId}    ${password}    ${phone}    ${pushClientId}    ${vcode}    ${errorMessage}
    [Documentation]    异常场景
    ${content}=    login_post    ${brandEquipmentModelPushId}    ${password}    ${phone}    ${pushClientId}    ${vcode}
    should contain    ${content}    "resultCode":-1
    should contain    ${content}    ${errorMessage}

login_assertDataVerify
    [Arguments]    ${brandEquipmentModelPushId}    ${password}    ${phone}    ${pushClientId}    ${vcode}
    [Documentation]    数据校验
    ${content}=    login_post    ${brandEquipmentModelPushId}    ${password}    ${phone}    ${pushClientId}    ${vcode}
    should contain    ${content}    "resultCode":0
    #开始进行数据取值、断言校验
    log    ----开始进行响应数据校验----:
    ${token}    get json value    ${content}    /data/token
    ${doctorAccountId}    get json value    ${content}    /data/doctorAccountId
    ${doctorAvatar}    get json value    ${content}    /data/doctorInfo/doctorAvatar
    ${jobTitle}    get json value    ${content}    /data/doctorInfo/jobTitle
    ${doctorName}    get json value    ${content}    /data/doctorInfo/doctorName
    ${qrUrl}    get json value    ${content}    /data/doctorInfo/qrUrl
    ${deptConsultOrderNum}    get json value    ${content}    /data/doctorInfo/deptConsultOrderNum
    ${doctorOpenId}    get json value    ${content}    /data/doctorInfo/doctorOpenId
    #验证关键字段返回不为空
    Should Not Be Empty    ${token}
    Should Not Be Empty    ${doctorAccountId}
    Should Not Be Empty    ${doctorAvatar}
    Should Not Be Empty    ${jobTitle}
    Should Not Be Empty    ${doctorName}
    Should Not Be Empty    ${qrUrl}
    Should Not Be Empty    ${doctorOpenId}
    should be true    ${deptConsultOrderNum}>=0
    #验证二维码地址连通性
    ${qrurlcode}=    get_url_status    ${qrUrl}
    should be equal    ${qrurlcode}    ${200}
