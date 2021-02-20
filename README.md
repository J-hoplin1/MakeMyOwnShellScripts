My shell script commands
===
***

- 이 레포지토리는 Shell Script를 사용해 Linux Command를 활용하여 간단한 명령어 체계 제작해본 코드를 저장하는 repository입니다.

- 기본적으로 bash(/bin/bash/)를 기반으로 작성하였으며, sh(bin/sh/)로는 작동하지 않는다는 점 알려드립니다.

- sh란 기본적으로 만들어진 shell 입니다. shell이란 기술적으로 가진 명칭은 사용자의 명령어를 해석하고 실행하는 명령어 해석기입니다. 즉 시스템에 접근하고 명령을 주고받기 위해 존재합니다. 간단히 생각하면 OS(운영체제)에서 System Call에 해당하는 부분이라고 생각하면 됩니다. 

- bash와 sh의 차이점을 간단하게 말하면 bash는 sh를 기반으로 여러기능이 포함된 shell입니다. bash는 sh를 기반으로 만들어졌기 때문에 sh에서 동작되는것들은 모두 bash 내에서도 돌아갑니다.

- Shell Script를 이용하여 bash command 작성하면서 확실한점은 shell script의 기본적인 문법보다는 **리눅스 명령어의 활용법과 Regular Expression에 중점을 두고 활용방안을 생각하는것**에 무게를 두어야한다고 느꼈습니다.

- 클라우드 IDE 환경 내에서는 사용불가

***

### 구현(?) 해본 명령어들

- pl : 프로세스 리스트를 나열합니다. 기본적으로 실행되는 shell 이외의 모든 shell의 프로세스를 조금 더 많은 정보를 포함하여 출력합니다.

- k : 입력한 PID에 대해 강제종료를 수행합니다.

- c : 쉘을 clear합니다.

- fitp : 특정 확장자, 이름, 정규표현식에 해당하는 프로세스를 찾습니다.

- hwinfo : CPU정보, RAM용량, GPU(그래픽 입출력장치) 기본정보를 표시합니다.

- history : shell이 실행되는동안의 명령어 기록을 시간과 명령어 순으로 출력합니다. -w 옵션을 넣어주게되면 쉘이 실행되는동안 입력된 명령어의 기록을 저장합니다.

- q,x : 쉘을 종료합니다.

- pysh : 리눅스 기본 내장 Python3 쉘을 실행합니다.

***

### 구현 예시 사진

- 초기화면

![img](img/1.png)

- option 명령어

![](img/2.png)

- covidKR 명령어 (파이썬으로 명령어 엔진 제작)

![](img/3.png)

- 특정 확장자 혹은 정규표현식에 따른 프로세스 검색(ps -ef | grep 활용)

![](img/4.png)

- 파이썬 쉘 실행

![](img/5.png)

- 기본적인 하드웨어 성능 조회

![](img/6.png)

- 명령어 기록 확인하기

![](img/7.png)

- 쉘 로그 출력하기

![](img/8.png)
