import twint
import sys
import json
import os
import requests

class Image:
    def  __init__(self, filename, url):
        self.filename = filename
        self.url = url


def createDirectory(directoryName):
    path = os.getcwd()+"\\assets\\"+directoryName
    try:
        os.mkdir(path)
    except OSError:
        print ("Creation of the directory %s failed" % path)
    else:
        print ("Successfully created the directory %s " % path)

def downloadPhotos(image):
    if(type(image) is dict):
        filename = image["filename"]
        url = image["url"]
        path = os.getcwd()+"\\assets\\"+filename+"\\"+filename+".jpg"
        print(path)
        if(len(url) == 1):
            try:
                print("downloading"+filename+" ...")
                url = url[0]
                response = requests.get(url)
                file = open(path, "wb")
                file.write(response.content)
                file.close()
            except:
                print ("Erreu while downloading"+filename)
            else:
                print (filename +" download ✅✅")
        else:
            print('no url')

def flatten_list(list):
    flatten_list = []
    for sublist in list:
        for item in sublist:
            flatten_list.append(item)
    return flatten_list

def isvalidDate(date_string):
    isvalid = False
    date_list = date_string.split(sep="-")
    isvalid = (len(date_list) == 3 and len(date_list[0]) == 4 and  len(date_list[1]) == 2 and  len(date_list[2]) == 2)
    return isvalid

def getLimit(limit_string):
    limit = False
    if(limit_string == '-l' or limit_string == '-L' or limit_string == '--limit_string' or limit_string == '--limit'):
        limit = True
    return limit

def getCommunique(date="2020-02-28", interval= False):
    print('Récupération des tweets ...')
    try:
        config = twint.Config()
        config.Username = "MinisteredelaS1"
        config.Search = "Communiqué"
        config.Since = date
        config.Media = True
        config.Output = "result.json"
        config.Store_json = True
        if(interval):
            config.Limit = 1
        twint.run.Search(config)
        print(config.Limit)
        print('Tweets récupérer avec succés')
    except:
        print("Erreur lors de la récupération de tweets")


def loadResutl():
    with open('result.json') as json_file:
        payload = json.load(json_file)
        images = formatFileNames(payload)
        for image in images:
            createDirectory(directoryName=image['photos'][0])
            if(type(image) is dict):
                downloadPhotos(image)
            if(type(image) is list):
                for i in image:
                    downloadPhotos(i)
            
            

def formatFileNames(payload):
    images = []
    tweets = payload['data']
    for tweet in tweets:
        if (len(tweet['photos']) > 1):
            filenames= []
            i=0
            for photo in tweet['photos']:
                image = {
                    "filename":"",
                    "url": photo
                }
                if(i > 0):
                    image["filename"] = tweet["date"] +"(suite 0"+str(i) +")"
                else:
                    image["filename"] = tweet["date"]
                filenames.append(image)
                i+=1
            images.append(filenames)
        else:
            url = tweet["photos"]
            # if isinstance(url, list):
            #     url = flatten_list(url)
            image = {
                "filename": tweet["date"],
                "url":  url
            }
            images.append(image)
    return images


def Main():
    if(len(sys.argv) == 2):
        if(isvalidDate(sys.argv[1])):
            getCommunique(sys.argv[1])
        else:
            print("Le format de la date est incorrect. Réessayer avec  ce format: YYYY-MM-DD")

    if(len(sys.argv) == 3):
        if(isvalidDate(sys.argv[1]) and getLimit(sys.argv[2])):
            getCommunique(sys.argv[1], getLimit(sys.argv[2]))
        else:
            print("Le format de la date est incorrect. Réessayer avec  ce format: YYYY-MM-DD")
            print("Ou bien le format de la limite")

loadResutl()