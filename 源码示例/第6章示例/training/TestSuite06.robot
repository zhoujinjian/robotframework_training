*** Settings ***
Library           String
Library           OperatingSystem
Library           Collections

*** Test Cases ***
TestCase01_Evaluate
    ${result}    set variable    ${3.14}
    #利用evaluate进行运算逻辑
    ${status}    evaluate    0<${result}<10
    log    ${status}

TestCase02_Evaluate
    #调用python基础函数，生成随机数
    ${random}    evaluate    random.randint(0, sys.maxint)    random, sys
    log    ${random}

TestCase03_Evaluate
    #利用evaluate命名空间
    ${ns} =    Create Dictionary    x=${4}    y=${2}
    ${result} =    Evaluate    x*10 + y    namespace=${ns}

TestCase04_Evaluate
    #利用Python string模块，生成字符串
    ${letters} =    Evaluate    string.letters    string
    #利用evaluate获取字符串长度
    ${letters_len}    Evaluate    len('${letters}')
    #随机获取其中任一字符串
    ${random}    evaluate    random.choice('${letters}')    random

TestCase05_Convert
    ${string}    convert to string    RobotFramework官网
    log    ${string}

TestCase06_Convert
    ${int}    convert to integer    50
    should be equal    ${int}    ${50}

TestCase07_Convert
    ${float}    convert to number    32.512    -1
    log    ${float}

TestCase08_Convert
    ${boolean}    convert to boolean    ${EMPTY}
    log    ${boolean}

TestCase09_Convert
    ${string}    set variable    验证通过
    ${encode_to_utf8}    Encode String To Bytes    ${string}    utf-8    errors=ignore

TestCase10_Variable
    ${local variable}    set variable    本地变量
    log variables

TestCase11_Variable
    import variables    ${CURDIR}/variables.py
    log    ${url}
    log many    @{str_list}

TestCase12_Variable
    ${hi}    set variable    hello world
    ${hi2}    set variable    I say: ${hi}
    ${name_list}    set variable    张三    李四    王五
    log many    @{name_list}
    ${name}    ${sex}    set variable    张三    男
    log    ${name}
    log    ${sex}

TestCase13_Variable
    set global variable    ${name}    张三
    log    ${name}

TestCase14_Variable
    set suite variable    ${name}    hello world
    ${id}    set variable    1234567
    set suite variable    ${id}
    set suite variable    &{name_dict}    name=张三    sex=男

TestCase15_Variable
    set test variable    ${test_var}    hello world

TestCase16_Variable
    ${rc}    set variable    ${0}
    ${var1}    set variable if    ${rc}==0    zero    nonzero
    ${var2}    set variable if    ${rc}>0    value1    value2
    ${var3}    set variable if    ${rc}<0    whatever

TestCase17_Variable
    ${vars}    get variables

TestCase18_Variable
    ${case_name}    get variable value    ${TEST_NAME}
    ${a}    get variable value    ${a}    default
    ${b}    get variable value    ${b}

TestCase19_Variable
    &{env_dict}    Get Environment Variables
    log many    &{env_dict}

TestCase20_Variable
    ${android_sdk}    Get Environment Variable    ANDROID_HOME
    ${a}    Get Environment Variable    a    default
    log    %{ANDROID_HOME}

TestCase21_Variable
    set Environment Variable    username    mikezhou
    log Environment Variables
    log    %{username}

TestCase22_Runkeyword
    ${time}    run keyword    get time

TestCase23_Runkeyword
    run keywords    gettime    sleep    1

TestCase24_Assertions
    ${str}    set variable    test
    Should Be Empty    ${str}    msg='${str}'不为空

TestCase25_Assertions
    ${str}    set variable    test
    Should Not Be Empty    ${str}

TestCase26_Assertions
    ${str}    set variable    test
    Should Be Equal    ${str}    test1    ignore_case=True

TestCase27_Assertions
    ${int}    set variable    ${80}
    Should not Be Equal As Strings    ${int}    80

TestCase28_Assertions
    ${output}    set variable    PASS
    ${some list}    create list    a    b
    Should Contain    ${output}    PASS
    Should Contain    ${some list}    A    msg=Failure!    values=false
    Should Contain    ${some list}    value    case_insensitive=True

TestCase29_Assertions
    ${output}    set variable    hello world
    ${some list}    create list    a    b    c
    @{sub_list}    create list    a    c
    Should not Contain Any    ${output}    hello    world
    Should not \ Contain Any    ${some list}    @{sub_list}

TestCase30_Assertions
    Should Start With    hello world    hello
    Should Start With    hello world    hello1    msg=不是以hello开头    values=false

TestCase31_Assertions
    Comment    Should Match Regexp    ${output}    \\d{6}
    Comment    Should Match Regexp    ${output}    ^\\d{6}$
    Comment    ${ret}    Should Not Match Regexp    Foo: 42    foo: \\d+
    ${match}    ${group1}    ${group2}    Should Not Match Regexp    Bar: 43    (Foo|Bar): (\\d+)

TestCase32_Collections
    @{list}    create list    a    b    c
    Append To List    ${list}    d    e
    log list    ${list}

TestCase33_Collections
    @{list}    create list    a    b    c
    Insert Into List    ${list}    0    ${1}
    Insert Into List    ${list}    1    ${2}
    Insert Into List    ${list}    -1    ${-1}
    log list    ${list}
    @{new_list}    copy list    ${list}
    log list    ${new_list}

TestCase34_Collections
    @{list}    create list    a    b    c    a
    ${a_indx}=    Get Index From List    ${list}    a    start=1    end=3

TestCase35_Collections
    @{list}    create list    a    b    c
    reverse list    ${list}
    log list    ${list}

TestCase36_Collections
    @{list}    create list    a    b    c
    Set List Value    ${list}    0    aa
    Set List Value    ${list}    -1    cc
    log list    ${list}

TestCase37_Collections
    @{list1}    create list    a    b    c
    @{list2}    create list    c    c    a
    Lists Should Be Equal    ${list1}    ${list2}

TestCase38_Collections
    @{list1}    create list    a    b    c    a
    Comment    ${delete}    remove from list    ${list1}    0
    Remove Values From List    ${list1}    a    c    dd
    log list    ${list1}

TestCase39_Collections
    ${dict}    Create Dictionary    name=mike
    Set To Dictionary    ${dict}    foo=bar
    Set To Dictionary    ${dict}    sex    girl
    ${items}    Get Dictionary Items    ${dict}
    ${keys}    Get Dictionary keys    ${dict}
    ${values}    Get Dictionary values    ${dict}

TestCase40_Collections
    ${dict}    Create Dictionary    name=mike
    Set To Dictionary    ${dict}    age    20
    ${items}    Get Dictionary Items    ${dict}
    ${keys}    Get Dictionary keys    ${dict}
    ${values}    Get Dictionary values    ${dict}
    Comment    Remove From Dictionary    ${dict}    age    name
    Log Dictionary    ${dict}
    Dictionary Should Contain Item    ${dict}    name    mike

TestCase41_Collections
    &{dict1}    Create Dictionary    name=mike    age=20
    &{dict2}    Create Dictionary    age=20    name=mike
    Dictionaries Should Be Equal    ${dict1}    ${dict2}

TestCase42_Log
    log    hello world
    Log    Warning, world!    level=WARN
    Log    <b>Hello</b>, world!    level=HTML
    Log    Hello, console!    console=yes
    Log    张三    repr=yes

TestCase43_Log
    @{list}    create list    a    b
    &{dict}    Create Dictionary    name=mikezhou
    Log Many    @{list}    &{dict}
    Log Many    hello    world

TestCase44_Log
    Log To Console    Hello, console!
    Log To Console    Hello, stderr!    STDERR
    Log To Console    Message starts here and is    no_newline=true
    Log To Console    continued without newline

TestCase45_Sleep
    sleep    42
    sleep    1.5
    sleep    2 minutes 10 seconds
    sleep    10s    Wait for a reply

TestCase46_GetTime
    ${time} =    Get Time
    ${secs} =    Get Time    epoch
    ${year} =    Get Time    year
    ${yyyy}    ${mm}    ${dd} =    Get Time    year,month,day
    @{time} =    Get Time    year month day hour min sec
    ${y}    ${s} =    Get Time    year and seconds

TestCase47_GetTime
    ${time} =    Get Time    \    1544326409
    ${day} =    Get Time    day    2018-12-09 11:33:20
    ${year} =    Get Time    year    NOW
    @{time} =    Get Time    hour min sec    NOW + 1h 2min 3s
    @{utc} =    Get Time    hour min sec    UTC

TestCase48_PassExecution
    [Setup]    runkeywords    pass execution    test
    ...    AND    log    rest
    Pass Execution    All features available in this version tested    test    -t
    Pass Execution    Deprecated test.
    log    此条语句不会被执行到
