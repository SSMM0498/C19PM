import requests
import json
import random
from bs4 import BeautifulSoup
import time


def getRandomUserAgent():
    lines = open('user-agents.txt').read().splitlines()
    return { 'User-Agent': random.choice(lines)}


def crawl_link(link, tag, class_name):
    response = requests.get(link)
    element_list = []
    if response.ok:
        soup = BeautifulSoup(response.text, "html.parser")
        element_list = soup.find_all(tag, {"class": class_name})
    return element_list


with open("Rd.json", "r") as d:
    data = json.load(d)
    array = []
    with open("Distance.json","w") as dump:
        print("Gathering Distances...")
        for i in range(0,45):
            for j in range(i+1,45):
                url = f"https://fr.distance.to/{data[i]}/{data[j]}"
                elements = crawl_link(url, "span", "value km")
                element = elements[1]
                array.append(f"{str(i+1)},{str(j+1)},{element.text}")
                print(f"{str(i+1)},{str(j+1)},{element.text}")
                time.sleep(1)
        json.dump(array,dump)
