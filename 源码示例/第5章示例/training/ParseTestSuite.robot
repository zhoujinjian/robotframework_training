*** Variables ***
${name}           Robot Framework
${age}            20

*** Test Cases ***
TestCase1
    log    ${TESTNAME}
    log    ${age}

TestCase2
    log    ${TESTNAME}
    log    ${name}
    forloop    3

*** Keywords ***
forloop
    [Arguments]    ${n}
    :FOR    ${i}    IN RANGE    ${n}
    \    log    ${i}
