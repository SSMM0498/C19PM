from PIL import Image
import DataExtractor
#  export TESSDATA_PREFIX=/Users/bemax/Documents/DIC2/SEM1/Sgbd/tessdata
# images = DataExtractor.pdfToImage('fic7.pdf') <-- works if you have fitz
images = ["./env/image1_1.png","./env/image2_1.png"]
# images = ["./env/image5_1.jpeg"]

# initialize empty  text
text = ''

# Extract the text of all images in a pdf file and concat them
for image in images:
    text += DataExtractor.getText(image)
text = text.lower()

# Get and print date
o = DataExtractor.getDate(text)
text = text[o["endIndex"]:-1]
print(o['date'])

# get and print total of tests
o = DataExtractor.getTests(text)
print(o['numbers'])
text = text[o["endIndex"]:-1]

# get and print number of contact cases
o = DataExtractor.getCasContact(text)
print(o['number'])
text = text[o["endIndex"]:-1]

# get and print number of communautary cases
o = DataExtractor.getCasCom(text)
print(o['number'])
text = text[o["endIndex"]:-1]

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
print(cas)
# cas = [{"found":False,'lieu': 'maristes', 'nbCas': 9}, {"found":False,'lieu': 'ouakam', 'nbCas': 7}, {"found":False,'lieu': 'pikine', 'nbCas': 7}, {"found":False,'lieu': 'nordfoire', 'nbCas': 5}, {"found":False,'lieu': 'dakarplateau', 'nbCas': 4}, {"found":False,'lieu': 'dieuppeul', 'nbCas': 4}, {"found":False,'lieu': 'ngor', 'nbCas': 4}, {"found":False,'lieu': 'almadies', 'nbCas': 3}, {"found":False,'lieu': 'mermoz', 'nbCas': 3}, {"found":False,'lieu': 'sacrécœur 1', 'nbCas': 3}, {"found":False,'lieu': 'diamniadio', 'nbCas': 3}, {"found":False,'lieu': 'guédiawaye', 'nbCas': 3}, {"found":False,'lieu': 'sicap karak', 'nbCas': 2}, {"found":False,'lieu': 'ouestfoire', 'nbCas': 2}, {"found":False,'lieu': 'parcellesassainies', 'nbCas': 2}, {"found":False,'lieu': '', 'nbCas': 2}, {"found":False,'lieu': 'sacrécœur 3', 'nbCas': 2}, {"found":False,'lieu': 'gibraltar', 'nbCas': 1}, {"found":False,'lieu': 'fann résidence', 'nbCas': 1}, {"found":False,'lieu': 'fann hock', 'nbCas': 1}, {"found":False,'lieu': 'castors', 'nbCas': 1}, {"found":False,'lieu': 'ouagou niaye', 'nbCas': 1}, {"found":False,'lieu': 'liberté 6', 'nbCas': 1}, {"found":False,'lieu': 'cité horizon', 'nbCas': 1}, {"found":False,'lieu': 'cité apecsy', 'nbCas': 1}, {"found":False,'lieu': 'cité soprim', 'nbCas': 1}, {"found":False,'lieu': 'keur massar', 'nbCas': 1}, {"found":False,'lieu': 'cap desbiches', 'nbCas': 1}, {"found":False,'lieu': 'zac mbao', 'nbCas': 1}, {"found":False,'lieu': 'thiaroye', 'nbCas': 1}, {"found":False,'lieu': 'niague', 'nbCas': 1}, {"found":False,'lieu': 'tivaouane peulh', 'nbCas': 1}, {"found":False,'lieu': 'bambilor', 'nbCas': 1}, {"found":False,'lieu': 'saintlouis', 'nbCas': 17}, {"found":False,'lieu': 'mbour', 'nbCas': 16}, {"found":False,'lieu': 'saly', 'nbCas': 5}, {"found":False,'lieu': 'khombole', 'nbCas': 5}, {"found":False,'lieu': 'thiès', 'nbCas': 4}, {"found":False,'lieu': 'mékhé', 'nbCas': 3}, {"found":False,'lieu': 'ngaparou', 'nbCas': 2}, {"found":False,'lieu': 'richardtoll', 'nbCas': 2}, {"found":False,'lieu': 'touba', 'nbCas': 2}, {"found":False,'lieu': 'kaolack', 'nbCas': 2}, {"found":False,'lieu': 'kolda', 'nbCas': 2}, {"found":False,'lieu': 'passy', 'nbCas': 1}, {"found":False,'lieu': 'sédhiou', 'nbCas': 1}, {"found":False,'lieu': 'dahra', 'nbCas': 1}, {"found":False,'lieu': 'dioffior', 'nbCas': 1}, {"found":False,'lieu': 'kaffrine', 'nbCas': 1}, {"found":False,'lieu': 'kébémer', 'nbCas': 1}, {"found":False,'lieu': 'louga', 'nbCas': 1}, {"found":False,'lieu': 'matam', 'nbCas': 1}]
# print(cas)
cases = DataExtractor.exportIntoJson(cas)

DataExtractor.exportToFile(12,2,2020,1342,32,122,cases)
DataExtractor.exportToFile(12,3,2020,1342,32,122,cases)
DataExtractor.exportToFile(12,3,2020,1342,32,122,cases)