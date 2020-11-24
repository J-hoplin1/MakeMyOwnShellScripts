#!/bin/bash

#쉘 스크립트 실행 시간 알려주는 줄
echo "Shell start at | $(date +%Y)/$(date +%m)/$(date +%d)  $(date +%H):$(date +%M)"
while true

do
    echo -n "명령어 입력하기 : "
    read input

    # 명령어를 실행하기 위해서는 echo문에 backtick문자로 감싸주면 된다.
    case $input in

        'Option'|'OPTION'|'option')
        echo "Option : Show all of the commands which this shell script support"
        echo "P or p : Run UNIX command 'ps' | Show running process list"
        echo "K or k : Run UNIX command 'Kill' | This command basically use option '-9' which means 'Force Close'"
        echo "Q or q or X or x : Exit shell"
        ;;
        'P'|'p')
        echo "Run PS : Process liSt"
        echo `ps -e` 
        #리눅스 명령어 ps는 process list를 반환하는 명령어입니다. 기본적으로 ps명령어만 사용하면 cmd,bash와 같은 사용자가 범접하는 측면에서만 볼 수 있는 것들만 보여줍니다.
        #ps명령어에 -e옵션을 넣어주면 시스템 프로세스까지 모두 보여줍니다.
        ;;
        'K'|'k') echo -n "Enter PID(Process ID) : "
        read PID
        echo `kill -9 $PID` #과제에서 입력한 PID값을 '강제 종료' 하라고 하였습니다. kill 명령어의 대표적인 옵션에는 -9 -15가 있는데 차이점은 -9 는 강제종료, -15는 작업종료를 의미합니다.
        echo "Successfully kill PID : $PID"
        ;;
        'Q'|'q'|'X'|'x') echo "Close Shell"
        exit 100
        ;;
        *) echo "지원하지 않는 명령어입니다."

    esac
done