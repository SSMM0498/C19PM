# Programme pour lire le fichier1 JSON et le transformer en XML

# Import des modules de json et xml en python
import json as JS
import xml.etree.ElementTree as ET

# Ouverture du fichier JSON en lecture

def jsonToXml(file):
    with open(file, "r") as json_file:
        # chargement données du fichier json dans la variable data
        data = JS.load(json_file)
        root = ET.Element("fichier1")
        # Building subelement of branches
        i = 1
        for day in data:
            brancheName = "branche" + str(i)
            i += 1
            branche = ET.SubElement(root,brancheName)
            ET.SubElement(branche, "announcementDate").text = str(day["annoucementDate"])
            ET.SubElement(branche, "Nombre de Test").text = str(day["numberOfTests"])
            ET.SubElement(branche, "Nombre de nouveaux Cas").text = str(day["numberOfNewCases"])
            ET.SubElement(branche, "Nombre de Cas contacts").text = str(day["numberOfContactCases"])
            ET.SubElement(branche, "Nombre de Cas Communautaires").text = str(day["numberOfCommunityCases"])
            ET.SubElement(branche, "Nombre de Guéris").text = str(day["numberOfHealed"])
            ET.SubElement(branche, "Nombre de Décès").text = str(day["numberOfDeaths"])
            ET.SubElement(branche, "Nom Fichier Source").text = day["sourceFileName"]
            ET.SubElement(branche, "DateHeureExtraction").text = day["extractionDate"]
            Locality = ET.SubElement(branche, "Localities")
            for locality in day["localities"]:
                ET.SubElement(Locality, "localityName").text = locality["localityName"]
                ET.SubElement(Locality, "administrativeLevel").text = locality["administrativeLevel"]
                ET.SubElement(Locality, "newCases").text = str(locality["newCases"])
           
        # Building the tree of the xml
        tree = ET.ElementTree(root)
        # Writing the xml to output file
        file = file.replace(".json",".xml")
        tree.write(file)

jsonToXml("2020-9.json")
