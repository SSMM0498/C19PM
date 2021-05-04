import os
import re
import json
import time
import io
from PIL import Image, ImageEnhance, ImageFilter
from pytesseract import pytesseract
from fuzzywuzzy import fuzz

def getText(image):    
    # path_to_tesseract = r"/opt/homebrew/Cellar/tesseract/4.1.1/bin/tesseract"
    path_to_tesseract = "C:\\Program Files (x86)\\Tesseract-OCR\\tesseract.exe"
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
    try:
        tmp = text[text.find("services"):text.index("services")+60]
        tmp = tmp.split()
        for word in tmp:
            if (word.isdigit()):
                return word
        return "0"
    except:
        return "0"

def getCityCases(text):
    cas = []
    endToStart = text.find('patients')-7
    tmp = text[0:endToStart]
    if((tmp.find('(') == -1 or tmp.find(')') == -1)):
        beginIndex = tmp.find('-')
        tmp = tmp.replace('.',';')
        tmp = tmp.replace('et',',')
        tmp = tmp.replace('\n', '')
        tmp = tmp.replace("é","e")
        tmp = tmp.replace("è","e")
        tmp = tmp.replace("ï","i")
        try:
            beginIndex = tmp.index('regions')
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
        try:  
            endIndex = tmp.index(".")
        except:
            endIndex = -1            
        tmp = tmp[beginIndex:endIndex]
        tmp = tmp.replace("(","")
        tmp = tmp.replace(")","")
        tmp = tmp.replace("\n"," ")
        tmp = tmp.replace("et",",")
        tmp = tmp.split(',')
        print(tmp)
        for words in tmp:
            words = words.split()
            # print(words)
            i = 0
            obj = {
                'found':False,
                'lieu': '',
                'nbCas': 0
            }
            while(i < len(words)-1):
                obj['lieu'] += words[i]
                i += 1
            nbCas = words[len(words)-1]
            if(nbCas.isdigit()):
                obj['nbCas'] = int(nbCas)
            else:
                continue
            cas.append(obj)
        # print(cas)

        
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
                    if (dept["dept"] == x["localityName"]):
                        fini = True
                        break
                if(not fini):
                    departement = {
                        "localityName": dept["dept"],
                        "administrativeLevel": "dept",
                        "newCases": 0
                    }
                    for left in export["depts"]:
                        if (dept["dept"] == left["dept"]):
                            departement["newCases"] += left["Cas"]
                    finished_departements.append(departement)
                    All_Data.append(departement)
                else:
                    continue
            print(finished_departements)
            finished_regions = []
            for reg in export["regions"]:
                fini = False
                for x in finished_regions:
                    if (compare(reg["Region"],x["localityName"])):
                        fini = True
                        break
                if (not fini):
                    region = {
                        "localityName": reg["Region"],
                        "administrativeLevel": "region",
                        "newCases": reg["TotalCas"]
                    }
                    for dept in finished_departements:
                        if (compare(region["localityName"].lower(),dept["localityName"].lower())):
                            region["newCases"] += dept["newCases"]
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
    named_tuple = time.localtime() 
    data = {
        "announcementDate": date,
        "numberOfTests": nbTest,
        "numberOfNewCases": nbPositif,
        "numberOfContactCases": casCon,
        "numberOfCommunityCases": casCom,
        "numberOfHealed": gueris,
        "numberOfDeaths": deces,
        "sourceFileName": filename,
        "extractionDate": time.strftime("%m/%d/%Y", named_tuple),
        "localities": cases
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

 
def extract(images):
    # images = ["./env/image7_1.jpeg","./env/image8_1.jpeg"]

    text = ''

    # Extract the text of all images and concat them
    for image in images:
        text += getText(image)
    text = text.lower()

    # Get date
    o = getDate(text)

    jour = int(o["dayNumber"])
    mois = o["month"]
    an = o["year"]

    # get total of tests
    o = getTests(text)
    text = text[o["endIndex"]:-1]
    numbers = o['numbers']
    nombreDeTest = numbers['tests']
    nombreDePositif = numbers['positifs']
    tauxPositivite = numbers['taux']

    # get number of contact cases
    o = getCasContact(text)
    text = text[o["endIndex"] :-1]
    nombreCasContact = o['number']

    # get number of communautary cases
    o = getCasCom(text)
    text = text[o["endIndex"] :-1]
    nombreCasCommunautaire = o['number']

    # Truncate text to listing of cases per city
    try:
        text = text[text.index("comme suit") + 12 :]
        # get array of location and there number of cases
        cas = getCityCases(text)
        text = text[cas["endIndex"] :-1]

        # get healed 
        nombreDeGueris = int(getNbGueris(text))

        # get dead
        nombreDeDeces = int(getDeces(text))

        # get overall data since the begining
        # (getOverall(text))

        cases = exportIntoJson(cas["cas"])
        exportToFile(jour,mois,an,nombreDeTest,nombreDePositif,nombreCasContact,nombreCasCommunautaire,nombreDeGueris,nombreDeDeces,cases)
    except:
        try:
            text = text[text.index(":") + 1 :-1]
            # get array of location and there number of cases
            cas = getCityCases(text)
            text = text[cas["endIndex"] :-1]

            # get healed 
            nombreDeGueris = int(getNbGueris(text))

            # get dead
            nombreDeDeces = int(getDeces(text))

            # get overall data since the begining
            # (getOverall(text))

            cases = exportIntoJson(cas["cas"])
            exportToFile(jour,mois,an,nombreDeTest,nombreDePositif,nombreCasContact,nombreCasCommunautaire,nombreDeGueris,nombreDeDeces,cases)
        except:
            print('Unable to Gather More Information!')

   