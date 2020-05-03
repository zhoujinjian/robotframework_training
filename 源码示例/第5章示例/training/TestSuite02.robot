*** Settings ***
Library           Collections
Resource          TestResource01.robot

*** Variables ***
${name}           robotframework
@{list}           张三    李四    王五
&{dict}           name=张三    sex=男    age=20

*** Test Cases ***
TestCase01
    [Documentation]    打印输出PATH环境变量
    [Tags]    ModuleA
    log    %{PATH}

TestCase02
    [Documentation]    设置数值常量
    [Tags]    ModuleA
    ${float}    set variable    ${3.14}
    ${int}    set variable    ${80}

TestCase03
    [Documentation]    空格和空字符串常量
    [Tags]    ModuleB
    Should Be Equal    ${EMPTY}    ${EMPTY}
    Should Be Equal    ${SPACE}    \ \

TestCase04
    [Documentation]    使用${name}变量
    log    ${name}

TestCase05
    [Documentation]    使用set variable定义变量
    ${name}    set variable    robotframwork
    ${姓名}    set variable    张三
    log    ${name}
    log    ${姓名}

TestCase06
    [Documentation]    引用输出列表型变量
    log    ${list}
    log many    @{list}

TestCase07
    [Documentation]    通过关键字创建列列变量
    @{list_1}    create list    a    b    c
    log many    @{list_1}
    @{list_2}    set variable    d    e    f
    log many    @{list_2}

TestCase08
    log    ${dict}
    log many    &{dict}

TestCase09
    &{dict}    Create Dictionary    name=张三    age=20    sex=男
    #输出整个字典
    log    ${dict}
    #依次输出字典中的值
    log many    &{dict}
    #取值，三种方式
    ${name}    get from dictionary    ${dict}    name
    log    ${name}
    log    &{dict}[age]
    log    ${dict.sex}

TestCase10
    不带参数关键字

TestCase11
    带参数关键字    张三    这个是一个带Scalar类型参数传入的关键字

TestCase12
    带参数关键字    张三    这个是一个带Scalar类型参数传入的关键字    替换选填参数默认值    12345678

TestCase13
    带参数关键字    张三    这个是一个带Scalar类型参数传入的关键字    替换选填参数默认值    12345678    a    b

TestCase14
    log    ${var}

TestCase15
    @{list}    带参数关键字    张三    这个是一个带Scalar类型参数传入的关键字    替换选填参数默认值    12345678    a
    ...    b
    log many    @{list}
