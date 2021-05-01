import twint
import sys
import json
import os
import requests
# import csv
import platform
import DataExtractor

# def createDirectory(directoryName):
#     path = os.getcwd()+"\\assets\\"+directoryName
#     try:
#         os.mkdir(path)
#     except OSError:
#         print ("Creation of the directory %s failed" % path)
#     else:
#         print ("Successfully created the directory %s " % path)

def downloadImage(image):
    path = ""
    if(type(image) is dict):
        filename = image["filename"]
        url = image["url"]
        if(platform.system() == 'Linux'):
            path = os.getcwd()+"/assets/"+filename+".jpg"

        if(platform.system() == 'Windows'):
            path = os.getcwd()+"\\assets\\"+filename+".jpg"
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
                # extract data
        else:
            print('no url')
        
    return path

def downloadPhotos(images):
    pathList = []
    if(type(images) is dict):
        pathList.append(downloadImage(images))
    else:
    # if(type(image) is list):
        for image in images:
            pathList.append(downloadImage(image))

    print(pathList)
    #extract data


# def flatten_list(list):
#     flatten_list = []
#     for sublist in list:
#         for item in sublist:
#             flatten_list.append(item)
#     return flatten_list

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

def correctJson():
    filename = "data.json"
    result= "result.json"
    with open(filename, 'r') as myfile:
        data = myfile.read().replace('"trans_dest": ""}', '"trans_dest": ""},')
        data = data[:-1]

    correct = "["+data+"]"
    correct = correct.replace('"trans_dest": ""},]', '"trans_dest": ""}]')
    with open(result, 'w') as myfile:
        myfile.write(correct)

def getCommunique(date="2020-02-28", interval= False):
    print('Récupération des tweets ...')
    try:
        config = twint.Config()
        config.Username = "MinisteredelaS1"
        config.Search = "Communiqué"
        config.Since = date
        config.Media = True
        config.Output = "data.json"
        config.Store_json = True
        # config.Store_csv = True
        # config.Output = "data.csv"
        if(interval):
            config.Limit = 1
        twint.run.Search(config)
        print('Tweets récupérer avec succés')
    except:
        print("Erreur lors de la récupération de tweets")


def loadResutl():
    with open('result.json') as json_file:
        payload = json.load(json_file)
        images = formatFileNames(payload)
        for image in images:
            downloadPhotos(image)
            # if(type(image) is dict):
            #     downloadPhotos(image)
            # if(type(image) is list):
            #     for i in image:
            #         downloadPhotos(i)

# def loadCvResult():
#     with open('data.csv', newline='') as csvfile:
#         tweets = csv.DictReader(csvfile)
#         tweetList = []
#         for tweet in tweets:
#             tweetList.append(tweet)
#         data = {
#             "data": tweetList
#         }

#     with open('data.json', 'w') as jsonFile:
#         jsonFile.write(json.dumps(data, indent=4))
#     print('Tweets are saved in json and csv format')

def formatFileNames(payload):
    images = []
    tweets = payload
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
            correctJson()
            loadResutl()
        else:
            print("Le format de la date est incorrect. Réessayer avec  ce format: YYYY-MM-DD")
    else:
        getCommunique()
        correctJson()
        loadResutl()

Main()