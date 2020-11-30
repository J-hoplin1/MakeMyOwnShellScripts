'''
공공데이터에서 코로나 API를 제공하고 있지만 API테스트 불가 등 API사용에 제한이 되어서 크롤러를 선택하였습니다.

This code written by Hoplin

This code is engine for command : covid19

This code return korea covid information

Scrape information from  : http://ncov.mohw.go.kr/index.jsp
Data provided from Ministry of Health and Welfare of Korea
'''


from urllib.request import Request,urlopen
from urllib.request import URLError
from urllib.request import HTTPError
from urllib.parse import quote
from bs4 import BeautifulSoup
import json
import warnings
import os



#Return total new patient of today
def todayData(html) -> int: 
    getTodayOccurrence = list(html.findAll('span',{'class' : 'data'}))
    getTodayOccurrence=[getTodayOccurrence[e].text for e in range(len(getTodayOccurrence))]
    todayOccurence=sum(list(map(int,getTodayOccurrence)))
    return todayOccurence

def totalData(html) -> list:
    getDatas=list(html.findAll('span',{'class' : 'num'}))
    getTotalDatas=[getDatas[e].text for e in range(len(getDatas))]
    return getTotalDatas

def writeInFile(dataArray) -> None:
    fp = open(os.path.dirname(os.path.realpath(__file__))+ "/covidInf.txt","w")
    for t in dataArray:
        cont = t + "\n"
        fp.write(cont)
    fp.close

try:
    defaultData = "http://ncov.mohw.go.kr/index.jsp"


    #Scrape HTML from datasource page
    html = urlopen(defaultData)
    bs = BeautifulSoup(html,'html.parser')
    statusCode = bs.status
    #scrape last data updated period
    dataRecentUpdatedPeriod=[bs.find('span',{'class' : 'livedate'}).text.replace("(","").replace(")","")]
    #Get layout HTML data : New patient occurrence today
    newTodayData=bs.find('div',{'class' : 'liveNum_today_new'})
    #Get layout HTML data : Total patient information 
    realtimeLiveData=bs.find('div',{'class' : 'liveNum'})

    todayOccure = [str(todayData(newTodayData))]
    totalDatas = totalData(realtimeLiveData)

    # Data Array : ['Recent updated period','today new Patient', 'Total patient', 'Treatment Completed','Under Treatment','Dead']
    retData = dataRecentUpdatedPeriod + todayOccure + totalDatas

    writeInFile(retData)
except URLError as e:
    erMSG="Wrong or Deleted URL. Please check again"
    data = ["Error",erMSG]
    writeInFile(data)
except HTTPError as e:
    erMSG="HTTP Error, Status Code : " + statusCode
    data = ["Error",erMSG]
    writeInFile(data)
except BaseException as e:
    erMSG="Engine Error : Something crashed or Incorrect Logic"
    data = ["Error", erMSG]
    writeInFile(data)
