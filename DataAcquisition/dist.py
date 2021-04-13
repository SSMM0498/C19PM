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


# // ("dakar",934498),
# // ("guédiawaye",155279),
# // ("pikine",773494),
# // ("rufisque",688808),
# // ("bambey",664383),
# // ("diourbel",922148),
# // ("mbacké",94691),
# // ("fatick",513367),
# // ("foundiougne",10118),
# // ("gossas",415224),
# // ("kaffrine",166659),
# // ("birkilane",143479),
# // ("koungheul",430154),
# // ("malem hoddar",349777),
# // ("guinguinéo",111222),
# // ("kaolack",598377),
# // ("nioro du rip",915994),
# // ("kédougou",10056),
# // ("salémata",17501),
# // ("saraya",29484),
# // ("kolda",676455),
# // ("médina yoro foulah",148268),
# // ("vélingara",61835),
# // ("kébémer",741693),
# // ("linguère",712343),
# // ("louga",851889),
# // ("kanel",953308),
# // ("matam",241231),
# // ("ranérou ferlo",25426),
# // ("dagana",498771),
# // ("podor",493472),
# // ("saint-louis",771323),
# // ("bounkiling",591804),
# // ("goudomp",683051),
# // ("sédhiou",283218),
# // ("bakel",216972),
# // ("goudiry",691342),
# // ("koumpentoum",625333),
# // ("tambacounda",341645),
# // ("m'bour",675545),
# // ("thiès",353359),
# // ("tivaouane",200501),
# // ("bignona",260215),
# // ("oussouye",10805),
# // ("ziguinchor",343291)