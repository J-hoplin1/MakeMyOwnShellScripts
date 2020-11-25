#!/bin/bash
#위의 줄같은 경우에는 이 프로그램은 bash를 기반으로 실행된다는것을 알리는 줄이다.
#이 줄은 항상 첫번째 줄에 위치해 있어야한다.


#쉘 시작과 동시에 terminal 혹은 cmd를 clear하여 해당 bash shell 인터페이스만 남게끔 한다.
function clearShell(){
    echo `clear`
}

#쉘이 시작되거나 clear되는 경우에 
function printShellInfo(){
    #Shell제작자 명
    echo "Shell made by | $madeBy"
    #해당 bash shell 사용자 명
    echo "User Name | $(whoami)"
    #User의 IP주소
    ipad=$(hostname -I)
    echo "User IP Address | $ipad"
    #쉘 스크립트 실행 시간 알려주는 줄
    echo "Shell start at | $(date +%Y)/$(date +%m)/$(date +%d)  $(date +%H):$(date +%M)"
    echo "Enter 'option' command to see supported command lines"
    echo " "
}

#명령어 매개변수 개수오류를 출력하는 함수. 매개변수로는 오류 메세지를 받는다.
function printParamError(){
    echo "Parameter Error : $1"
}

clearShell
madeBy="Hoplin"


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

* 배열 길이 가져오기

array=(1 2 3 4 5)
echo "${#array}" -> 이렇게 하면 배열 길이를 알 수 있다.

END

printShellInfo

while true

do
    echo -n ">> "
    #사용자 입력값에 대해 매개변수 및 옵션 검수를 위해 결과값을 바로 배열로 저장한다.
    read -a valTyped
    #가장 맨 앞의 입력값은 명령어가 되어야한다.
    input=${valTyped[0]}
    #사용자가 입력한 부분을 배열로 변환하고 배열의 개수를 inputArLen에 저장해준다.
    inputArLen=${#valTyped[@]}
    # 명령어를 실행하기 위해서는 echo문에 backtick문자로 감싸주면 된다.
    case $input in

        'Option'|'OPTION'|'option')
        echo "Option : Show all of the commands which this shell script support"
        echo "P or p : Show running process list"
        echo "K or k : Force Close Process base on PID"
        echo "C or c : Clear Shell"
        echo "fitp : Search process base on parameter -> Parameter requires Regular Expression or Extention you want to find"
        echo "Q or q or X or x : Exit shell"
        ;;
        'P'|'p')
        echo "Run PS : Process liSt"
        #이렇게 해야 값이 세로로(일반적인 리눅스 쉘에서 출력되는것처럼)출력된다.
        result=`ps -xl`
        echo "$result" 
        #ps -xl : 접속된 터미널 뿐만 아니라 사용되고있는 모든 프로세스들에 대한(x) '자세한 내용'(l)출력 
        #리눅스 명령어 ps는 process list를 반환하는 명령어입니다. 기본적으로 ps명령어만 사용하면 cmd,bash와 같은 사용자가 범접하는 측면에서만 볼 수 있는 것들만 보여줍니다.
        #ps명령어에 -e옵션을 넣어주면 시스템 프로세스까지 모두 보여줍니다.
        ;;
        'K'|'k') echo -n "Enter PID(Process ID) : "
        read PID
        echo `kill -9 $PID` # kill 명령어의 대표적인 옵션에는 -9 -15가 있는데 차이점은 -9 는 강제종료, -15는 작업종료를 의미합니다.
        echo "Successfully kill PID : $PID"
        ;;
        'C'|'c') clearShell
        printShellInfo
        ;;
        'fitp') 
        #매개변수가 없는경우
        if [ $inputArLen -lt 2 ]; then
            printParamError "Command 'fitp' requires 2 parameter but 1 parameter entered"
            continue # continue를 하면 다시 명령어 입력을 할 수 있게끔 한다.
        fi
        #매개변수가 2개 혹은 그 이상의 경우인 경우
        if [ $inputArLen -gt 2 ]; then
            printParamError "Command 'fitp' requires 2 parameter but 3 or more parameter entered"
            continue
        fi
        #정상적인 매개변수 1개 입력되었을 경우
        if [ $inputArLen -ge 2 ]; then
            echo `ps -ef|grep ${valTyped[1]}`
        fi
        ;;
        'Q'|'q'|'X'|'x') echo "Close Shell"
        clearShell
        exit 100
        ;;
        *) echo "Entered command $input is not supported by this shell. Enter 'option' to look supported command"
    esac
done
