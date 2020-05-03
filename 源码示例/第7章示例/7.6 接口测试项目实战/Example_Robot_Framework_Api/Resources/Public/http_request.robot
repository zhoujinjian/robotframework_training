*** Settings ***
Documentation     http/https 公共请求库
Library           RequestsLibrary
Library           Collections
Library           String
Library           HttpLibrary.HTTP
Library           ../Lib/tools_library.py

*** Keywords ***
_Post_Request
    [Arguments]    ${host}    ${path}    ${datas}    ${params}=${EMPTY}    ${headers}=None    ${cookies}=None
    ...    ${timeout}=30
    [Documentation]    *公共Post请求*
    ...    | 参数 | ${host} | ${path} | ${data} | ${header} | ${cookies} | ${params} | ${timeout} |
    ...    | 解释 | 请求域名 | 请求地址 | post请求数据 | 请求头 | 请求cookie | url查询参数 | 请求超时时间 |
    ...    | 示例 | www.baidu.com | /ip-healthmanager-dtr-app-web/login | {'username':'xxx'} | 默认为None | 默认为None | 默认为空 | 默认为30 |
    # 设置编码
    Evaluate    reload(sys)    sys
    Evaluate    sys.setdefaultencoding( "utf-8" )    sys
    #处理请求header
    ${header_dict}    create dictionary    Content-Type=application/json
    run keyword if    ${headers}== ${None}    log    没有添加自定义header
    ...    ELSE    run keyword    add_header    ${headers}    ${header_dict}
    # 处理cookies
    ${cookie_dict}    create dictionary
    run keyword if    ${cookies}==${None}    log    没有添加cookie信息
    ...    ELSE    run keyword    add_cookies    ${cookies}    ${cookie_dict}
    # 创建session
    create session    example_robotframework    ${host}    timeout=${timeout}    cookies=${cookie_dict}
    #发起Post请求
    ${resp}    RequestsLibrary.post_request    example_robotframework    ${path}    data=${datas}    headers=${header_dict}    params=${params}
    [Return]    ${resp}

_Get_Request
    [Arguments]    ${host}    ${path}    ${datas}    ${params}    ${headers}=None    ${cookies}=None
    ...    ${timeout}=30
    [Documentation]    *公共Get请求*
    ...    | 参数 | ${host} | ${path} | ${data} | ${params} | ${header} | ${cookies} | ${timeout} |
    ...    | 解释 | 请求域名 | 请求地址 | post请求数据 | url查询参数 | 请求头 | 请求cookie | 请求超时时间 |
    ...    | 示例 | www.baidu.com | /ip-healthmanager-dtr-app-web/login | {'username':'xxx'} | name=test&sex=男 | 默认为None | 默认为None | 默认为30 |
    # 设置编码
    Evaluate    reload(sys)    sys
    Evaluate    sys.setdefaultencoding( "utf-8" )    sys
    #处理请求header
    ${header_dict}    create dictionary    Content-Type=application/json
    run keyword if    ${headers}== ${None}    log    没有添加自定义header
    ...    ELSE    run keyword    add_header    ${headers}    ${header_dict}
    # 处理cookies
    ${cookie_dict}    create dictionary
    run keyword if    ${cookies}==${None}    log    没有添加cookie信息
    ...    ELSE    run keyword    add_cookies    ${cookies}    ${cookie_dict}
    # 创建session
    create session    example_robotframework    ${host}    timeout=${timeout}    cookies=${cookie_dict}
    #发起Get请求
    ${resp}    RequestsLibrary.get_request    example_robotframework    ${path}    headers=${header_dict}    params=${params}
    [Return]    ${resp}

add_cookies
    [Arguments]    ${cookies}    ${cookiedict}
    [Documentation]    *处理cookies*
    @{cookielist}=    split string    ${cookies}    ;
    : FOR    ${cookie}    IN    @{cookielist}    #用；分割cookie
    \    run keyword if    '${cookie}' == '${None}'    exit for loop    #如果cookie为none，则跳出loop
    \    ${cookie_split}=    split string    ${cookie}    =
    \    Set To Dictionary    ${cookiedict}    ${cookie_split[0]}=${cookie_split[1]}    #set到一起

add_header
    [Arguments]    ${dict1}    ${dict2}
    [Documentation]    *遍历字典dict1，并将dict1中的值，添加到dict2中*
    log    在请求中添加自定义header
    ${itmes}    Get Dictionary Items    ${dict1}
    : FOR    ${index}    ${key}    ${value}    IN ENUMERATE    @{itmes}
    \    Set To Dictionary    ${dict2}    ${key}=${value}

get_url_status
    [Arguments]    ${url}
    [Documentation]    验证${url}的连通性
    ${URL}    remove string    ${url}    "
    create session    url    ${URL}
    ${resp}    RequestsLibrary.get_request    url    ${EMPTY}
    log    验证 ${url}地址连通性正常，返回的状态码为: ${resp.status_code}
    [Return]    ${resp.status_code}
