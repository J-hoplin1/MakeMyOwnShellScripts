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
    echo "-------------------------------------------------------------------------------"
    echo "Shell made by | $madeBy"
    #해당 bash shell 사용자 명
    echo "User Name | $(whoami)"
    #User의 IP주소
    ipad=${IPInfo[0]}
    echo "User IP Address | $ipad"
    #쉘 스크립트 실행 시간 알려주는 줄
    echo "Shell start at | $(date +%Y)/$(date +%m)/$(date +%d) $(date +%H):$(date +%M)"
    echo "Shell running location | $(pwd)"
    echo $kernelVersion | tr -d " "
    echo "  "
    echo "* Enter 'option' command to see support command lines"
    echo "-------------------------------------------------------------------------------"
    echo "  "
}

function viewCovidKR(){
    readData="commandExecuteEngine/covidInf.txt"
    #Read file and save datas in array
    dataArr=()

    while IFS= read -r line
    do
        dataArr+=("$line")
    done < "$readData"

    if [ "${dataArr[0]}" = "Error" ]; then
        echo "${dataArr[0]} : ${dataArr[1]}"
    else
        echo "  "
        echo "Covid19 Korea Status | Date : $(date +%Y)/$(date +%m)/$(date +%d)"
        echo "  "
        echo "-----------------------------------------------------------------"
        echo "  "
        echo "Recent Updated Period : ${dataArr[0]}"
        echo "Daily covid19 confirmation(Aboard + Domestic) : ${dataArr[1]}"
        echo "Cumulative number of confirmed cases : ${dataArr[2]}"
        echo "Treatment Completed : ${dataArr[3]}"
        echo "Under Treatment : ${dataArr[4]}"
        echo "Total of Dead : ${dataArr[5]}"
        echo "  "
    fi
}

function preLoadPCPerformance(){
    #Get CPU Info
    cpuinfo=`cat /proc/cpuinfo|egrep "model name"|head -n 1`
    IFS=':' read -r -a arraY <<< "$cpuinfo"
    #앞뒤 공백 제거 : ${변수:1:-1} 이 말은 변수의 1번째부터 뒤에서 1번째까지 가져오라는 뜻이다.
    cpuInfo=${arraY[1]:1:-1}

    #Get main memory(RAM) Info
    ramInfo=`cat /proc/meminfo | grep "MemTotal"`
    IFS=':' read -r -a arraY <<< "$ramInfo"
    ramInfo=${arraY[1]:8:-3}
    res=`expr $ramInfo / 1024 / 1024 + 1`

    #Get GPU Info
    gpuinfo=`lspci | grep -i VGA`
    IFS=':' read -r -a arraY <<< "$gpuinfo"
    gpuInfo=${arraY[2]:1}

    echo "Hardware Information"
    echo "  "
    echo "CPU : $cpuInfo"
    echo "RAM Total : ${res} GB"
    echo "GPU Info : $gpuInfo"


}

#명령어 매개변수 개수오류를 출력하는 함수. 매개변수로는 오류 메세지를 받는다.
function printParamError(){
    echo "Parameter Error : $1"
}


clearShell
madeBy="Hoplin"
IPInfo=`hostname -I`
IPInfo=($IPInfo)
kernelVersion=`hostnamectl | grep Kernel`

#Command가 사용된 시간이 저장되는 배열
commandUseTime=()
#쉘 명령어 기록
shellCommandHistoryStack=()

:<<END

참고하기 매우 좋은 블로그 : https://mug896.github.io/bash-shell/index.html

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

* read 명령어 옵션들

- a : 입력값을 array에 할당된다.
- r : Raw모드 백슬래시 기호를 이스케이프 시퀸스로 해석하지 않는다.


END

printShellInfo

while true

do
    echo -n ">> "
    #사용자 입력값에 대해 매개변수 및 옵션 검수를 위해 결과값을 바로 배열로 저장한다.
    read input
    #명령어가 입력되면 commandUseTime배열에는 입력된 시간이 저장된다
    commandUseTime+=("$(date +%Y)/$(date +%m)/$(date +%d) $(date +%H):$(date +%M):$(date +%S)")
    #완전한 문자열 형태의 명령어는 shellCommandHistoryStack배열에 저장된다.
    shellCommandHistoryStack+=("$input")
    :<<END
    IFS : 내부 필드 구분 기호
    Shell은 변수의 값을 표시할 때 IFS변수에 설정되어있는 값을 이용하여 단어를 분리해 표시한다.
    여기서 단어를 분리한다는 의미는 IFS변수에 설정되어 있는 문자를 space로 변경하여 표시한다는것이다.
END
    IFS=' ' read -r -a valTyped <<< "$input" # 이 문을 해석하자면 ' '을 기준으로 split을 한다는 이야기이다.
    #가장 맨 앞의 입력값은 명령어가 되어야한다.
    input=${valTyped[0]}
    #사용자가 입력한 부분을 배열로 변환하고 배열의 개수를 inputArLen에 저장해준다.
    inputArLen=${#valTyped[@]}
    # 명령어를 실행하기 위해서는 echo문에 backtick문자로 감싸주면 된다.
    case $input in

        'Option'|'OPTION'|'option')
        echo "Option : Show all of the commands which this shell script support"
        echo "PL or pl : Show running process list"
        echo "K or k : Force Close Process base on PID"
        echo "C or c : Clear Shell"
        echo "fitp : Search process base on parameter -> Parameter requires Regular Expression or Extention you want to find"
        echo "history : Show record of command that user entered. Show command timeline with time and command. -w option to save Command Record"
        echo "hwinfo : Show basic HardWare Information. Include CPU Information, Total volume of RAM, GPU Information"
        echo "covidKR : Show South Korea covid19 status"
        echo "pysh : Execute Python3 Shell Command"
        echo "Q or q or X or x : Exit shell"
        ;;
        'PL'|'pl')
        echo "Run PS : Process liSt"
        #이렇게 해야 값이 세로로(일반적인 리눅스 쉘에서 출력되는것처럼)출력된다.
        result=`ps -xl`
        echo "$result"
        :<<END 
        ps -xl : 접속된 터미널 뿐만 아니라 사용되고있는 모든 프로세스들에 대한(x) '자세한 내용'(l)출력 
        리눅스 명령어 ps는 process list를 반환하는 명령어입니다. 기본적으로 ps명령어만 사용하면 cmd,bash와 같은 사용자가 범접하는 측면에서만 볼 수 있는 것들만 보여줍니다.
        ps명령어에 -e옵션을 넣어주면 시스템 프로세스까지 모두 보여줍니다.
END
        ;;
        'k'|'K') echo -n "Enter PID(Process ID) : "
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
        if [ $inputArLen -eq 2 ]; then
            result=`ps -ef|grep ${valTyped[1]}`
            echo "$result"
        fi
        ;;
        'hwinfo')
        preLoadPCPerformance
        ;;
        'Hoplin'|'hoplin') echo "Hello user! My name is Hoplin who made this shell!"
        ;;
        'History'|'history')
        if [ $inputArLen -lt 2 ]; then
            historyStackLength=${#shellCommandHistoryStack[@]}
            for ((a=0; a<historyStackLength;a++))
            do
                echo -n "${commandUseTime[a]}       "
                echo "${shellCommandHistoryStack[a]}"
            done
        elif [ $inputArLen -eq 2 ]; then
            if [ "${valTyped[1]}" == "-w" ]; then
            # >> : 파일에 이어쓰기를 한다.
                echo "This record written at : $(date +%Y)/$(date +%m)/$(date +%d) $(date +%H):$(date +%M):$(date +%S)" >> CommandHistory.txt
                echo "Shell user : $(whoami)" >> CommandHistory.txt
                echo "------------------------------------------------------------------" >> CommandHistory.txt
                historyStackLength=${#shellCommandHistoryStack[@]}
                for ((a=0; a<historyStackLength;a++))
                do
                    echo "${commandUseTime[a]}      ${shellCommandHistoryStack[a]}" >> CommandHistory.txt
                done
                echo "------------------------------------------------------------------" >> CommandHistory.txt
                echo "  " >> CommandHistory.txt
            else
                echo "Wrong parameter or option : ${valTyped[1]}"
            fi
        else
            printParamError "Command 'fitp' requires 2 parameter but 3 or more parameter entered"
        fi
        ;;
        'pysh')
        pyV=`python3 -V`
        echo "  "
        echo "Python Shell : Version $pyV"
        echo "Type exit() to exit python shell"
        echo "  "
        `python3`
        echo "  "
        echo "Back to Shell"
        ;;
        'covidKR'|'covidkr')
        `python3 commandExecuteEngine/covid19.py`
        viewCovidKR
        `rm commandExecuteEngine/covidInf.txt`
        ;;
        'Q'|'q'|'X'|'x')
        clearShell
        exit 100
        ;;
        *)
        echo "  " 
        echo "Entered command '$input' is not supported by this shell. Enter 'option' to look supported command"
    esac
done
