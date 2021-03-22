from PIL import Image
import DataExtractor
#  export TESSDATA_PREFIX=/Users/bemax/Documents/DIC2/SEM1/Sgbd/tessdata
# images = DataExtractor.pdfToImage('fic7.pdf') <-- works if you have fitz
# images = ["./env/image1_1.png","./env/image2_1.png"]

# # initialize empty  text
# text = ''

# # Extract the text of all images in a pdf file and concat them
# for image in images:
#     text += DataExtractor.getText(image)
# text = text.lower()

# # Get and print date
# o = DataExtractor.getDate(text)
# text = text[o["endIndex"]:-1]
# print(o['date'])

# # get and print total of tests
# o = DataExtractor.getTests(text)
# print(o['numbers'])
# text = text[o["endIndex"]:-1]

# # get and print number of contact cases
# o = DataExtractor.getCasContact(text)
# print(o['number'])
# text = text[o["endIndex"]:-1]

# # get and print number of communautary cases
# o = DataExtractor.getCasCom(text)
# print(o['number'])
# text = text[o["endIndex"]:-1]

# # Truncate text to listing of cases per city
# try:
#     text = text[text.index("comme suit")+12:]
# except:
#     try:
#         text = text[text.index(":")+1:-1]
#     except:
#         print('Unable to Gather More Information!')

# get and print array of location and there number of cases
# cas = DataExtractor.getCityCases(text)
# print(cas)
cas = [{'lieu': 'maristes', 'nbCas': 9}, {'lieu': 'ouakam', 'nbCas': 7}, {'lieu': 'pikine', 'nbCas': 7}, {'lieu': 'nordfoire', 'nbCas': 5}, {'lieu': 'dakarplateau', 'nbCas': 4}, {'lieu': 'dieuppeul', 'nbCas': 4}, {'lieu': 'ngor', 'nbCas': 4}, {'lieu': 'almadies', 'nbCas': 3}, {'lieu': 'mermoz', 'nbCas': 3}, {'lieu': 'sacrécœur 1', 'nbCas': 3}, {'lieu': 'diamniadio', 'nbCas': 3}, {'lieu': 'guédiawaye', 'nbCas': 3}, {'lieu': 'sicap karak', 'nbCas': 2}, {'lieu': 'ouestfoire', 'nbCas': 2}, {'lieu': 'parcellesassainies', 'nbCas': 2}, {'lieu': '', 'nbCas': 2}, {'lieu': 'sacrécœur 3', 'nbCas': 2}, {'lieu': 'gibraltar', 'nbCas': 1}, {'lieu': 'fann résidence', 'nbCas': 1}, {'lieu': 'fann hock', 'nbCas': 1}, {'lieu': 'castors', 'nbCas': 1}, {'lieu': 'ouagou niaye', 'nbCas': 1}, {'lieu': 'liberté 6', 'nbCas': 1}, {'lieu': 'cité horizon', 'nbCas': 1}, {'lieu': 'cité apecsy', 'nbCas': 1}, {'lieu': 'cité soprim', 'nbCas': 1}, {'lieu': 'keur massar', 'nbCas': 1}, {'lieu': 'cap desbiches', 'nbCas': 1}, {'lieu': 'zac mbao', 'nbCas': 1}, {'lieu': 'thiaroye', 'nbCas': 1}, {'lieu': 'niague', 'nbCas': 1}, {'lieu': 'tivaouane peulh', 'nbCas': 1}, {'lieu': 'bambilor', 'nbCas': 1}, {'lieu': 'saintlouis', 'nbCas': 17}, {'lieu': 'mbour', 'nbCas': 16}, {'lieu': 'saly', 'nbCas': 5}, {'lieu': 'khombole', 'nbCas': 5}, {'lieu': 'thiès', 'nbCas': 4}, {'lieu': 'mékhé', 'nbCas': 3}, {'lieu': 'ngaparou', 'nbCas': 2}, {'lieu': 'richardtoll', 'nbCas': 2}, {'lieu': 'touba', 'nbCas': 2}, {'lieu': 'kaolack', 'nbCas': 2}, {'lieu': 'kolda', 'nbCas': 2}, {'lieu': 'passy', 'nbCas': 1}, {'lieu': 'sédhiou', 'nbCas': 1}, {'lieu': 'dahra', 'nbCas': 1}, {'lieu': 'dioffior', 'nbCas': 1}, {'lieu': 'kaffrine', 'nbCas': 1}, {'lieu': 'kébémer', 'nbCas': 1}, {'lieu': 'louga', 'nbCas': 1}, {'lieu': 'matam', 'nbCas': 1}]
print(cas)
DataExtractor.exportIntoJson(cas)
