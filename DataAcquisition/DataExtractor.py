import os
import re
import json
import io
from PIL import Image, ImageEnhance, ImageFilter
from pytesseract import pytesseract
from fuzzywuzzy import fuzz

# import fitz 

# Function To Get Images from a pdf file : Works if U install fitz
# def pdfToImage(pdf):
#     # File path you want to extract images from
#     file = pdf
#     # open the file
#     pdf_file = fitz.open(file)
#     images = []
#     for page_index in range(len(pdf_file)):
#         # get the page itself
#         page = pdf_file[page_index]
#         image_list = page.getImageList()
#         # printing number of images found in this page
#         # if image_list:
#         #     print(f'[+] Found a total of {len(image_list)} images in page {page_index}')
#         # else:
#         #     print("[!] No images found on page", page_index)
#         for image_index, img in enumerate(page.getImageList(), start=1):
#             # get the XREF of the image
#             xref = img[0]
#             # extract the image bytes
#             base_image = pdf_file.extractImage(xref)
#             image_bytes = base_image["image"]
#             # get the image extension
#             image_ext = base_image["ext"]
#             # load it to PIL
#             image = Image.open(io.BytesIO(image_bytes))
#             # save it to local disk
#             images.append(f"image{page_index+1}_{image_index}.{image_ext}")
#             image.save(open(f"image{page_index+1}_{image_index}.{image_ext}", "wb"))
#     return images

def getText(image):    
    path_to_tesseract = r"/opt/homebrew/Cellar/tesseract/4.1.1/bin/tesseract"
    # path_to_tesseract = <-- pathToTesseract here
    image_path = image
    img = Image.open(image_path)
    pytesseract.tesseract_cmd = path_to_tesseract
    text = pytesseract.image_to_string(img,lang='fra')
    text = text[0:-2]
    return text
    
def switch(argument):
    argument = argument.replace("é","e")
    argument = argument.replace("è","e")
    switcher = {
        "janvier":1,
        "fevrier": 2,
        "mars" : 3,
        "avril":4,
        "mai":5,
        "juin":6,
        "juillet":7,
        "aout":8,
        "septembre":9,
        "octobre":10,
        "novembre":11,
        "decembre":12
    }
    return (switcher.get(argument, "Invalid month"))

def getDate(text):
    days = ["lundi","mardi","mercredi","jeudi","vendredi","samedi","dimanche"]
    tmp = text[0:200]
    for day in days:
        if(tmp.find(day) != -1):
            tmp = tmp[tmp.find(day):-1]
            tmp = tmp.split(',')
            tmp = tmp[0]
            tmp = tmp.split()            
            obj = {
                'day' : tmp[0],
                'dayNumber' : tmp[1],
                'month' : switch(tmp[2]),
                'year' : tmp[3]
            }
            return obj
        else:
            continue

def getTests(text):
    try:
        testBeginIndex = text.index("sur")
        testEndIndex = text.index("positifs")
        tests = text[testBeginIndex:testEndIndex]
        tests = tests.split()
        result = {
            "tests": 0,
            "positifs": 0,
            "taux":0
        }
        numbers = []
        for word in tests:
            if(word.isdigit()):
                numbers.append(int(word))
        numbers.append((numbers[1] * 100) / numbers[0])
        result["tests"] = numbers[0]
        result["positifs"] = numbers[1]
        result["taux"] = numbers[2]
        return {'numbers': result, 'endIndex': testEndIndex}
    except: 
        return { 'numbers' : 0, 'endIndex':0 }

def getCasContact(text):
    try:
        casBeginIndex = 0
        casEndIndex = text.index("services")
        contact = text[casBeginIndex:casEndIndex].split() 
        for word in contact:
            if(word.isdigit()):
                number = int(word)
        return  {'number' : number,'endIndex':casEndIndex}
    except:
        return  {'number' : 0,'endIndex':0}

def getCasCom(text):
    try:
        casBeginIndex = text.index("transmission") - 30
        casEndIndex = text.index("transmission")
        contact = text[casBeginIndex:casEndIndex].split() 
        for word in contact:
            if(word.isdigit()):
                number = int(word)
        return  {'number': number,'endIndex':casEndIndex }
    except:
        return  {'number': 0,'endIndex':0 }

def getNbGueris(text):
    tmp = text[0: text.find('patients')]
    tmp = tmp.split()
    for word in tmp:
        if (word.isdigit()):
            return word

def getOverall(text):
    tmp = text[text.find('ce jour'):text.find('traitement')]
    tmp = tmp.split()
    obj = {
        "positifs": 0,
        "gueris": 0,
        "deces": 0,
        "traitement" :0
    }
    ov = []
    for word in tmp:
        if (word.isdigit()):
            ov.append(word)
    obj["positifs"] = ov[0]
    obj["gueris"] = ov[1]
    obj["deces"] = ov[2]
    obj["traitement"] = ov[3]
    return obj

def getDeces(text):
    print(text)
    tmp = text[text.find("services"):text.index("services")+60]
    tmp = tmp.split()
    for word in tmp:
        if (word.isdigit()):
            return word
    return "0"

def getCityCases(text):
    cas = []
    if(text.find('(') == -1 or text.find(')') == -1):
        beginIndex = text.find('-')
        endToStart = text.find('patients')-8
        tmp = text[beginIndex:endToStart]
        tmp = tmp.replace('.',';')
        tmp = tmp.replace('et',',')
        tmp = tmp.replace('\n','')
        try:
            beginIndex = tmp.index('régions')
            endIndex = tmp.index(':')
            tmp = tmp[0:beginIndex] + tmp[endIndex+1:]
        except:
            tmp = tmp
        m = re.split(';',tmp)
        for words in m:
            words = words.replace('-','')
            words = words.replace('aux','')
            tmp = words.split()
            if(len(tmp) != 0):
                nbCas = tmp[0]
                if(not nbCas.isdigit()):
                    nbCas = nbCas[:-1] 
                tmp[0] = nbCas
            separator = ' '
            tmp = separator.join(tmp)
            tmp = tmp.split()
            if(len(tmp) != 0):
                nbCasList = tmp[0]
                if(not nbCasList.isdigit()):
                    continue
                else:
                    tmp.pop(0)
                    tmp = separator.join(tmp)
                    tmp = tmp.replace('à','')
                    tmp = tmp.split(',')
                    for loc in tmp:
                        loc = loc.strip()
                        obj = {
                            'found':False,
                            'lieu': '',
                            'nbCas': 0
                        }
                        obj['lieu'] = loc
                        obj['nbCas'] = int(nbCasList)
                        cas.append(obj) 
    else:    
        beginIndex = 0
        endIndex = text.index(".")
        endToStart = text.find('patients')-8
        tmp = text[beginIndex:endIndex]
        tmp = tmp.replace("(","")
        tmp = tmp.replace(")","")
        tmp = tmp.replace("\n"," ")
        tmp = tmp.replace("et",",")
        tmp = tmp.split(',')
        for words in tmp:
            words = words.split()
            obj = {
                'found': False,
                'lieu': '',
                'nbCas': 0
            }
            i = 0
            while(i < len(words)-1):
                obj['lieu'] += words[i]
                i += 1
            nbCas = words[len(words)-1]
            if(nbCas.isdigit()):
                obj['nbCas'] = int(nbCas)
            else:
                continue
            cas.append(obj) 
    return {"cas": cas, 'endIndex': endToStart}
    

def compare(a, b):
    if (fuzz.ratio(a,b) >= 85):
        return True
    else:
        if fuzz.partial_ratio(a, b) > 80:
            return True
        else:
            return False

def exportIntoJson(cas):
    with open("json/tmp_export.json", "w") as export_file:
        with open("json/Senegal.json", "r") as da:
            data = json.load(da)
            export = {
                'regions': [],
                'depts':[]
            }
            for loc in cas:
                location = loc["lieu"]
                if(location != ""):
                    location = location.replace(" ","")
                    location = location.replace("-", "")
                    location = location.replace("é","e")
                    location = location.replace("è","e")
                    location = location.replace("ï","i")
                    location = location.replace("’","")
                    location = location.replace(".","")
                    for r in data:
                        if loc["found"] == True:
                            break
                        region = r["region"].lower()
                        r_export = {
                            "Region": region,
                            "TotalCas": 0 
                        }
                        region = region.replace(" ","")
                        region = region.replace("_","")
                        if (compare(location, region) and loc["found"] == False ):
                            print("Found Region:" + region)
                            loc["found"] = True
                            r_export["TotalCas"] += loc["nbCas"]
                            break
                        else:
                            for d in r["departements"]:
                                if loc["found"] == True:
                                    break
                                dept = d["departement"].lower()
                                d_export = {
                                    "region": r["region"],
                                    "dept": dept,
                                    "Cas":0
                                }
                                dept = dept.replace(" ","")    
                                dept = dept.replace("-", "")
                                if (compare(location, dept) and loc["found"] == False):
                                    print("Found Department:" + dept)
                                    loc["found"] = True
                                    d_export["Cas"] += loc["nbCas"]
                                    export["depts"].append(d_export)   
                                else:
                                    for c in d["communes"]:
                                        if loc["found"] == True:
                                            break
                                        c = c.lower()
                                        c = c.replace(" ","")
                                        c = c.replace("-", "")
                                        if (compare(location, c )and loc["found"] == False):
                                            print("Found Commune:" + c)
                                            loc["found"] = True
                                            d_export["Cas"] += loc["nbCas"]
                                            export["depts"].append(d_export)
                                            break
                                        else:
                                            for a in d["arronds"]:
                                                if loc["found"] == True:
                                                    break
                                                a = a.lower()
                                                a = a.replace(" ","")
                                                a = a.replace("-", "")
                                                if (compare(location, a )and loc["found"] == False):
                                                    print("Found arrond" + a)
                                                    loc["found"] = True
                                                    d_export["Cas"] += loc["nbCas"]
                                                    export["depts"].append(d_export)
                                                    break
                                                else:
                                                    for ca in d["comard"]:
                                                        ca = ca.lower()
                                                        ca = ca.replace(" ","")
                                                        ca = ca.replace("-", "")
                                                        if (compare(location, ca) and loc["found"] == False):
                                                            print("Found Ca:" + ca)
                                                            loc["found"] = True
                                                            d_export["Cas"] += loc["nbCas"]
                                                            export["depts"].append(d_export)
                                                            break                             
                    export["regions"].append(r_export)
                else:
                    continue
            for region in export["regions"]:
                if (region["TotalCas"] != 0):
                    print(region)
            for dept in export["depts"]:
                if (dept["Cas"] != 0):
                    print(dept)
            for lieu in cas:
                if(not lieu["found"]):
                    print("Not Found " + lieu["lieu"])
            All_Data = []
            finished_departements = []
            for dept in export["depts"]:
                fini = False
                for x in finished_departements:
                    if (dept["dept"] == x["dept"]):
                        fini = True
                        break
                if(not fini):
                    departement = {
                        "region": dept["region"],
                        "dept": dept["dept"],
                        "TotalCas": 0
                    }
                    for left in export["depts"]:
                        if (dept["dept"] == left["dept"]):
                            departement["TotalCas"] += left["Cas"]
                    print(departement)
                    finished_departements.append(departement)
                    All_Data.append(departement)
                else:
                    continue
            print(finished_departements)
            finished_regions = []
            for reg in export["regions"]:
                fini = False
                for x in finished_regions:
                    if (compare(reg["Region"],x["region"])):
                        fini = True
                        break
                if (not fini):
                    region = {
                        "region": reg["Region"],
                        "TotalCas": reg["TotalCas"]
                    }
                    for dept in finished_departements:
                        if (compare(region["region"].lower(),dept["region"].lower())):
                            region["TotalCas"] += dept["TotalCas"]
                        else:
                            continue
                    finished_regions.append(region)
                    All_Data.append(region)
                else:
                    continue
            print(finished_regions)
        json.dump(All_Data, export_file, ensure_ascii=False)
        return All_Data

def exportToFile(date, month, year, nbTest, nbPositif, casCon, casCom,gueris,deces,cases):
    filename = str(year) + '-' + str(month)
    filepath = "json/data/" + filename + ".json"
    export = []
    data = {
        "Date": date,
        "NbTest": nbTest,
        "NbDePositif": nbPositif,
        "NbCasContact": casCon,
        "NbCasComm": casCom,
        "NbGueris": gueris,
        "NbDeces": deces,
        "RepCas": cases
    }
    export.append(data)
    if not os.path.isfile(filepath):
        with open(filepath, "w") as export_file:
            json.dump(export, export_file, ensure_ascii=False)
    else:
        with open(filepath, "r") as input_file:
            feeds = json.load(input_file)
        feeds.append(data)
        with open(filepath, "w") as export_file:
            json.dump(feeds, export_file, ensure_ascii=False)