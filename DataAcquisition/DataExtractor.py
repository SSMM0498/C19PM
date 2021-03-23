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

def getDate(text):
    days = ["lundi","mardi","mercredi","jeudi","vendredi","samedi","dimanche"]
    for day in days:
        try:
            dateBeginIndex = text.find(day)
            dateEndIndex = text.index("2021") + 4
            date = text[dateBeginIndex:dateEndIndex]
            return { 'date':date,'endIndex':dateEndIndex }
        except:
            continue

def getTests(text):
    try:
        testBeginIndex = text.index("sur")
        testEndIndex = text.index("positifs")
        tests = text[testBeginIndex:testEndIndex]
        tests = tests.split()
        numbers = []
        for word in tests:
            if(word.isdigit()):
                numbers.append(int(word))
        numbers.append((numbers[1]*100)/numbers[0])      
        return { 'numbers' : numbers, 'endIndex':testEndIndex }
    except: 
        return { 'numbers' : 0, 'endIndex':0 }

def getCasContact(text):
    try:
        casBeginIndex = text.index("comme suit :")
        casBeginIndex += 13
        casEndIndex = text.index("services ;")
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

def getCityCases(text):
    cas = []
    if(text.find('(') == -1 or text.find(')') == -1):
        beginIndex = text.find('-')
        text = text[beginIndex:text.find('patients')-8]
        text = text.replace('.',';')
        text = text.replace('et',',')
        text = text.replace('\n','')
        try:
            beginIndex = text.index('régions')
            endIndex = text.index(':')
            text = text[0:beginIndex] + text[endIndex+1:]
        except:
            text = text
        
        m = re.split(';',text)
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
        text = text[beginIndex:endIndex]
        text = text.replace("(","")
        text = text.replace(")","")
        text = text.replace("\n"," ")
        text = text.replace("et",",")
        text = text.split(',')
        for words in text:
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
    return cas

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
            # for region in export["regions"]:
            #     if (region["TotalCas"] != 0):
            #         print(region)
            # for dept in export["depts"]:
            #     if (dept["Cas"] != 0):
            #         print(dept)
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
                    # print(departement)
                    finished_departements.append(departement)
                    All_Data.append(departement)
                else:
                    continue
            print(finished_departements)
            finished_regions = []
            for reg in export["regions"]:
                fini = False
                for x in finished_regions:
                    if (reg["Region"] == x["region"]):
                        fini = True
                        break
                if (not fini):
                    region = {
                        "region": reg["Region"],
                        "TotalCas": reg["TotalCas"]
                    }
                    for dept in finished_departements:
                        if (dept["region"].lower() == region["region"].lower()):
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

def exportToFile(date, month, year, nbTest, casCon, casCom,cases):
    filename = str(year) + '-' + str(month)
    filepath = "json/" + filename + ".json"
    export = []
    data = {
            "Date": date,
            "NbTest": nbTest,
            "NbCasContact": casCon,
            "NbCasComm": casCom,
            "RepCas": cases
        }
    export.append(data)
    if not os.path.isfile(filepath):
        with open(filepath, "w") as export_file:
            json.dump(export, export_file, ensure_ascii=False)
    else:
        with open(filepath, "r") as input_file:
            feeds = json.load(input_file)
        # feeds.append(data)
        # # print(feeds)
        feeds.append(data)
        with open(filepath, "w") as export_file:
            json.dump(feeds, export_file, ensure_ascii=False)
        
        

            
