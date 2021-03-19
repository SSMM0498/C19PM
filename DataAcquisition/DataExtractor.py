import re
import io
from PIL import Image, ImageEnhance, ImageFilter
from pytesseract import pytesseract
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

