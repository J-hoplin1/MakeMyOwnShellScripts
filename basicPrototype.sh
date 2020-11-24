#!/bin/bash
#쉘 시작과 동시에 terminal 혹은 cmd를 clear하여 해당 bash shell 인터페이스만 남게끔 한다.
echo `clear`

:<<END

주의할 점 : 쉘 스크립트에서는 명령어 저장을 할때 (변수명)=(데이터) 에서 데이터와 변수명 등호를 모두 붙여서 써야한다.

* 다선 주석처리
:<<END ~ END 로 하면된


* cut 명령어

일반적인 문자열 split을 대신하여 사용한다.

기능 : 파일에서 필드를 뽑아낸다. 필드는 구분자로 구분할 수 있다.

cut [option] [file]

옵션

-c 문자위치 : 잘라낼 곳의 글자 위치를 정한다. 콤마나 하이픈을 사용하여 범위를 정할 수 도 있으며, 이런 표현들을 혼합하여 사용할 수 도 있다.
-f 필드 : 잘라낼 필드를 정한다.
-d 구분자 : 필드를 구분하는 문자를 지정한다. 디폴트는 탭 문자다.
-s : 필드 구분자를 포함할 수 없다면 그 행은 하지않는다.

END
#해당 bash shell 사용자 명
echo "User Name | $(whoami)"
#User의 IP주소
ipad=$(hostname -I)
echo "User IP Address | $ipad"
#쉘 스크립트 실행 시간 알려주는 줄
echo "Shell start at | $(date +%Y)/$(date +%m)/$(date +%d)  $(date +%H):$(date +%M)\n"
while true

do
    echo -n ">> "
    read input

    # 명령어를 실행하기 위해서는 echo문에 backtick문자로 감싸주면 된다.
    case $input in

        'Option'|'OPTION'|'option')
        echo "Option : Show all of the commands which this shell script support"
        echo "P or p : Run UNIX command 'ps' | Show running process list"
        echo "K or k : Run UNIX command 'Kill' | This command basically use option '-9' which means 'Force Close'"
        echo "nt : Run UNIX command 'hostname'"
        echo "Q or q or X or x : Exit shell"
        ;;
        'P'|'p')
        echo "Run PS : Process liSt"
        #이렇게 해야 값이 세로로(정상적인 쉘처럼)출력된다.
        result=`ps -xl`
        echo "$result" #ps -xl : 접속된 터미널 뿐만 아니라 사용되고있는 모든 프로세스들에 대한(x) '자세한 내용'(l)출력 
        #리눅스 명령어 ps는 process list를 반환하는 명령어입니다. 기본적으로 ps명령어만 사용하면 cmd,bash와 같은 사용자가 범접하는 측면에서만 볼 수 있는 것들만 보여줍니다.
        #ps명령어에 -e옵션을 넣어주면 시스템 프로세스까지 모두 보여줍니다.
        ;;
        'K'|'k') echo -n "Enter PID(Process ID) : "
        read PID
        echo `kill -9 $PID` # kill 명령어의 대표적인 옵션에는 -9 -15가 있는데 차이점은 -9 는 강제종료, -15는 작업종료를 의미합니다.
        echo "Successfully kill PID : $PID"
        ;;
        'Q'|'q'|'X'|'x') echo "Close Shell"
        echo `clear`
        exit 100
        ;;
        *) echo "Entered command $input is not supported by this shell. Enter 'option' to look supported command"
    esac
done
