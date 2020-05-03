*** Settings ***
Suite Setup       log    我是测试套件suite setup
Suite Teardown    log    我是测试套件suite teardown

*** Test Cases ***
TestCase01
    [Setup]    log    我是测试用例setup
    log    我是TestCase01,验证setup和teardown
    [Teardown]    log    我是测试用例teardown

TestCase02
    log    我是TestCase02,我不带有setup和teardown
