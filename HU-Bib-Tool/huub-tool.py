#!/bin/env python3

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from getpass import getpass
import time
import datetime
from os.path import expanduser

# only python-selenium needed and chromewebview needed

## virtualdisplay so we dont get annoying messages
# deps pyvirtualdisplay from pip and xvfb
from pyvirtualdisplay import Display
display = Display(visible=0, size=(1024, 768))
display.start()

def elemInsert(element, text):
    element.clear()
    element.send_keys(text)
    return

def writeDate(dateList):
    # only get most recent date
    timeList = []
    for d in dateList:
        time = datetime.datetime.strptime(d.text, '%d.%m.%Y').timestamp()
        timeList.append(int(time))
    minimalDate = min(timeList)
    print("soonest Date is {}".format(minimalDate))
    home = expanduser("~")
    home += "/.bib.epoch"
    with open(home, 'w') as dateFile:
        dateFile.write(str(minimalDate))

def noLend():
    home = expanduser("~")
    home += "/.bib.epoch"
    with open(home, 'w') as dateFile:
        dateFile.write(str(-1))

driver = webdriver.Chrome()
driver.get("https://www.ub.hu-berlin.de/de")
assert "Berlin" in driver.title
username = driver.find_element_by_name("bor_id")
password = driver.find_element_by_name("bor_verification")
pw = getpass(prompt="Insert your HU Password: ")
elemInsert(username, "HUCH02207120")
elemInsert(password, pw)
password.send_keys(Keys.RETURN)
assert "PRIMUS" in driver.title
kontoLink = driver.find_element_by_link_text('Mein Konto')
kontoLink.click()
ddObjList = []
ddObjList = driver.find_elements_by_css_selector("[id^='dueDate']")
if ddObjList == []:
    print("No books currently lended.")
    noLend()
    raise SystemExit(0)
writeDate(ddObjList)
print("Due dates for your HU Books")
for r in ddObjList:
    print(r.text)
# check if we want to prolong lend times
lendCheck = input("Increase time [y/n]: ")
if lendCheck == "y":
    lendButton = driver.find_element_by_link_text("Alle verlängern")
    lendButton.click()
    driver.implicitly_wait(1)
    lendResponse = driver.find_element_by_id('EXLMyAccountFeedbacMsg')
    time.sleep(1)
    print(lendResponse.text)
    ddObjList = []
    ddObjList = driver.find_elements_by_css_selector("[id^='dueDate']")
    print("New due dates for your HU Books")
    writeDate(ddObjList)
    for r in ddObjList:
        print(r.text)
driver.close()
display.stop()
