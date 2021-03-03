
import DataExtractor
text = DataExtractor.getText()
print(DataExtractor.getDate(text))
print(DataExtractor.getTests(text))
print(DataExtractor.getCasContact(text))
print(DataExtractor.getCasCom(text))
# fic = {
#     "Annee": 2020,
#     "Mois": "Mars",
#     "date1" = {
#         "NbTest" : 45,
#         "NbNouveauxCas" : 20,
#         "localites" : {
#             "localite1" : 2,
#         }
#     },
#     "date2" = {
#         "NbTest" : 45,
#         "NbNouveauxCas" : 20
#     }
# }
