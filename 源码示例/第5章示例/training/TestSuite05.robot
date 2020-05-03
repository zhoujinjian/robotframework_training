*** Test Cases ***
TestCase01
    : FOR    ${index}    IN    a    b    c
    \    log    ${index}

TestCase02
    @{list}    create list    a    b    c
    : FOR    ${index}    IN    @{list}
    \    log    ${index}

TestCase03
    : FOR    ${index}    IN RANGE    10
    \    log    ${index}

TestCase04
    : FOR    ${index}    IN RANGE    2    10    3
    \    log    ${index}

TestCase05
    : FOR    ${index}    ${englist_name}    ${chinese_name}    IN ENUMERATE    cat    猫
    ...    dog    狗
    \    log    ${index}-${englist_name}-${chinese_name}

TestCase06
    @{list}    create list    a    b    c
    : FOR    ${index}    ${value}    IN ENUMERATE    @{list}
    \    log    ${index}-${value}

TestCase07
    @{numbers}    create list    1    2    3
    ${chars}    create list    a    b    c
    : FOR    ${number}    ${char}    IN ZIP    ${numbers}    ${chars}
    \    log    ${number}-${char}

TestCase08
    ${nums}    Set Variable    ${5}
    ${ints}    Set Variable    ${1}
    run keyword if    ${nums}>10    log    nums大于10
    ...    ELSE IF    ${ints}>0    log    ints大于0
    ...    ELSE    log    nums既不大于10，且ints也不大于0
