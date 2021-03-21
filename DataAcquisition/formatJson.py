import json

with open("decoupage-administratif.json", "r") as read_file:
    data = json.load(read_file)
    regions = []
    for obj in data:
        if (obj["REGION"] in regions):
            continue
        else:
            regions.append(obj["REGION"])
    # print(regions)
    departements = []
    for region in regions:
        r = {
            "region": region,
            "departements": []
        }
        for obj in data:
            if ((obj["REGION"] == region) and (obj["DEPARTEMENTS"] not in r["departements"])):
                r["departements"].append(obj["DEPARTEMENTS"])
            else:
                continue
        departements.append(r)
    # print(departements)
    communes = []
    for departement in departements:
        r = {
            "region": departement["region"],
            "departements": []
        }
        for dept in departement["departements"]:
            d = {
                "departement": dept,
                "communes": []
            }
            for obj in data:
                if ((obj["REGION"] == r["region"]) and (obj["DEPARTEMENTS"] == dept) and (obj["COMMUNES"] not in d["communes"])):
                    d["communes"].append(obj["COMMUNES"])
                else:
                    continue
            r["departements"].append(d)
        communes.append(r)
    # print(communes)
    arrond = []

    for commune in communes:
        r = {
            "region": commune["region"],
            "departements": []
        }
        for dept in commune["departements"]:
            d = {
                "departement": dept["departement"],
                "communes": []
            }
            for comm in dept["communes"]:
                c = {
                    "commune": comm,
                    "arrondissements": []
                }
                for obj in data:
                    if ((obj["REGION"] == r["region"]) and (obj["DEPARTEMENTS"] == d["departement"]) and (obj["COMMUNES"] == comm) and (obj["ARRONDISSEMENTS"] not in c["arrondissements"])):
                        c["arrondissements"].append(obj["ARRONDISSEMENTS"])
                    else:
                        continue
                d["communes"].append(c)    
            r["departements"].append(d)
        arrond.append(r)
    # print(arrond)
    comard = []
    for arr in arrond:
        r = {
            "region": arr["region"],
            "departements": []
        }
        for dept in arr["departements"]:
            d = {
                "departement": dept["departement"],
                "communes": []
            }
            for comm in dept["communes"]:
                c = {
                    "commune": comm["commune"],
                    "arrondissements": []
                }
                for arr in comm["arrondissements"]:
                    a = {
                       "arrond": arr,
                       "comard": []
                    }
                    for obj in data:
                        if ((obj["REGION"] == r["region"]) and (obj["DEPARTEMENTS"] == d["departement"]) and (obj["COMMUNES"] == c["commune"]) and (obj["ARRONDISSEMENTS"] == arr) and (obj["C0MMUNESARRDT"] not in a["comard"])):
                            a["comard"].append(obj["C0MMUNESARRDT"])
                        else:
                            continue
                    c["arrondissements"].append(a)    
                d["communes"].append(c)
            r["departements"].append(d)
        comard.append(r)
    print(comard)

with open("data_file.json", "w") as write_file:
    json.dump(comard, write_file,ensure_ascii=False)
        

