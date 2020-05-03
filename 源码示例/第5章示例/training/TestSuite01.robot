*** Test Cases ***
TestCase01
    log    第1条用例

TestCase02
    log    第2条用例

TestCase03
    [Tags]    test
    Comment    log    ${NAME}
    ${name}    set variable    robotframwork
    ${姓名}    set variable    张三
    log    ${name}
    log    ${姓名}
