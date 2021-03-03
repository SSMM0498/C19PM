import re
import fitz 
import io
from PIL import Image
from pytesseract import pytesseract


def pdfToImage(pdf):
    # File path you want to extract images from
    file = "fic.pdf"
    # open the file
    pdf_file = fitz.open(file)
    for page_index in range(len(pdf_file)):
        # get the page itself
        page = pdf_file[page_index]
        image_list = page.getImageList()
        # printing number of images found in this page
        if image_list:
            print(f"[+] Found a total of {len(image_list)} images in page {page_index}")
        else:
            print("[!] No images found on page", page_index)
        for image_index, img in enumerate(page.getImageList(), start=1):
            # get the XREF of the image
            xref = img[0]
            # extract the image bytes
            base_image = pdf_file.extractImage(xref)
            image_bytes = base_image["image"]
            # get the image extension
            image_ext = base_image["ext"]
            # load it to PIL
            image = Image.open(io.BytesIO(image_bytes))
            # save it to local disk
            image.save(open(f"image{page_index+1}_{image_index}.{image_ext}", "wb"))

def getText():    
    path_to_tesseract = r"C:\\Program Files (x86)\\tesseract.exe"
    image_path = 'image1_1.png'
    img = Image.open(image_path)

    pytesseract.tesseract_cmd = path_to_tesseract

    text = pytesseract.image_to_string(img)
    
    return text 

def getDate(text):
    days = ["Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi","Dimanche"]
    for day in days:
        try:
            dateBeginIndex = text.index(day)
            dateEndIndex = text.index("2021") + 4
            date = text[dateBeginIndex:dateEndIndex]
            return date
        except:
            continue

def getTests(text):
    testBeginIndex = text.index("Sur")
    testEndIndex = text.index("%.")
    tests = text[testBeginIndex:testEndIndex]
    tests = tests.split()
    numbers = []
    for word in tests:
        if(word.isdigit()):
            numbers.append(int(word))
    numbers.append((numbers[1]*100)/numbers[0])      
    return numbers

def getCasContact(text):
    casBeginIndex = text.index("comme suit :")
    casBeginIndex += 13
    casEndIndex = text.index("services ;")
    contact = text[casBeginIndex:casEndIndex].split() 
    for word in contact:
        if(word.isdigit()):
            number = int(word)
    return  number

def getCasCom(text):
    casBeginIndex = text.index("transmission") - 30
    casEndIndex = text.index("transmission")
    contact = text[casBeginIndex:casEndIndex].split() 
    for word in contact:
        if(word.isdigit()):
            number = int(word)
    return  number
