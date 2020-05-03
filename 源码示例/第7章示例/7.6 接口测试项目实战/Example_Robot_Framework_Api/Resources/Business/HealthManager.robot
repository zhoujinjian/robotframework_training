*** Settings ***
Documentation     HealthManager项目业务资源文件
Resource          ../Public/http_request.robot
Variables         ../Lib/config.py

*** Variables ***
${phone}          ${phone}     # 手机号
${password}       ${password}    # 密码

*** Keywords ***
request_get
    [Arguments]    ${host}    ${path}    ${datas}    ${params}    ${headers}=None    ${cookies}=None
    ${resp}=    _Get_Request    ${host}    ${path}    ${datas}    ${params}    ${headers}
    ...    ${cookies}
    [Return]    ${resp}

request_post
    [Arguments]    ${host}    ${path}    ${datas}    ${params}    ${headers}=None    ${cookies}=None
    ${resp}=    _Post_Request    ${host}    ${path}    ${datas}    ${params}    ${headers}
    ...    ${cookies}
    [Return]    ${resp}

set_global_token
    ${token}    get_login_token    ${phone}    ${password}    ${EMPTY}    ${EMPTY}
    ${token}=    Remove String    ${token}    "
    Set Global Variable    ${token}

get_login_token
    [Arguments]    ${phone}    ${password}    ${brandEquipmentModelPushId}=${EMPTY}    ${pushClientId}=${EMPTY}    ${vcode}=${EMPTY}
    [Documentation]    获取登录token
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
    should contain    ${content}    "resultCode":0
    ${token}=    get json value    ${content}    /data/token
    [Return]    ${token}

get_recentPatients_list
    [Arguments]    ${page}    ${pageSize}    ${paramsValue}    ${token}
    [Documentation]    获取近期患者列表
    Evaluate    reload(sys)    sys
    Evaluate    sys.setdefaultencoding( "utf-8" )    sys
    ${path}=    set variable    /ip-healthmanager-dtr-app-web/groupMessage/recentPatients
    ${datas}=    create dictionary
    ${params}=    create dictionary
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
    should contain    ${content}    "resultCode":0
    ${data}    get json value    ${content}    /data
    ${data}    replace string    ${data}    true    "true"
    ${data}    replace string    ${data}    false    "false"
    ${data}    replace string    ${data}    null    "null"
    ${data_list}    evaluate    list(${data})
    ${data_list_len}=    get length    ${data_list}
    ${cloudUserId_list}=    create list
    : FOR    ${index}    IN RANGE    ${data_list_len}
    \    ${cloudUserId}    Get From Dictionary    ${data_list[${index}]}    cloudUserId
    \    append to list    ${cloudUserId_list}    ${cloudUserId}
    [Return]    ${cloudUserId_list}

getPatientInfo_Get
    [Arguments]    ${cloudUserId}    ${token}
    Evaluate    reload(sys)    sys
    Evaluate    sys.setdefaultencoding( "utf-8" )    sys
    ${path}=    set variable    /ip-healthmanager-dtr-app-web/myPatients/getPatientInfo
    ${datas}=    create dictionary
    ${params}    create dictionary
    set to dictionary    ${params}    token=${token}
    set to dictionary    ${params}    cloudUserId=${cloudUserId}
    log    ---输出预期值---
    ${resp}=    request_get    ${URL}    ${path}    ${datas}    ${params}
    ${content}=    set variable    ${resp.content}
    ${content}=    charconver    ${resp.content}
    log    ---输出${cloudUserId}返回内容----：
    log json    ${content}    INFO
    log    ---开始断言验证---
    should be true    ${resp.status_code}==200
    should contain    ${content}    "resultCode":0
    [Return]    ${content}
