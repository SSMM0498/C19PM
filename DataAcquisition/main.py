from PIL import Image
import DataExtractor
#  export TESSDATA_PREFIX=/Users/bemax/Documents/DIC2/SEM1/Sgbd/tessdata
# images = DataExtractor.pdfToImage('fic7.pdf') <-- works if you have fitz
images = ["./env/image1_1.png","./env/image2_1.png"]
# images = ["./env/image3_1.jpeg","./env/image4_1.jpeg"]
# images = ["./env/image7_1.jpeg","./env/image8_1.jpeg"]
# images = ["./env/image5_1.jpeg"]
# images = ["./env/image6_1.jpeg"]

# initialize empty  text
text = ''

# Extract the text of all images in a pdf file and concat them
for image in images:
    text += DataExtractor.getText(image)
text = text.lower()

# Get and print date
o = DataExtractor.getDate(text)

jour = int(o["dayNumber"])
mois = o["month"]
an = o["year"]

# get and print total of tests
o = DataExtractor.getTests(text)
text = text[o["endIndex"]:-1]
numbers = o['numbers']
nombreDeTest = numbers['tests']
nombreDePositif = numbers['positifs']
tauxPositivite = numbers['taux']

# get and print number of contact cases
o = DataExtractor.getCasContact(text)
text = text[o["endIndex"] :-1]
nombreCasContact = o['number']

# get and print number of communautary cases
o = DataExtractor.getCasCom(text)
text = text[o["endIndex"] :-1]
nombreCasCommunautaire = o['number']

# Truncate text to listing of cases per city
try:
    text = text[text.index("comme suit")+12:]
except:
    try:
        text = text[text.index(":")+1:-1]
    except:
        print('Unable to Gather More Information!')

# get and print array of location and there number of cases
cas = DataExtractor.getCityCases(text)
text = text[cas["endIndex"] :-1]
nombreDeGueris = int(DataExtractor.getNbGueris(text))
nombreDeDeces = int(DataExtractor.getDeces(text))

# get overall data since the begining
# (DataExtractor.getOverall(text))

cases = DataExtractor.exportIntoJson(cas["cas"])

DataExtractor.exportToFile(jour,mois,an,nombreDeTest,nombreDePositif,nombreCasContact,nombreCasCommunautaire,nombreDeGueris,nombreDeDeces,cases)