import json
import requests;
import xmltodict;
import datetime;
import csv;

limit=100
offset = 0
sDate = 20240820
eDate = 20241117
print(type(sDate))
Engine= 'google'
device= ['d','m']

all_calls = []


# Set with an initial value to enter the loop below.
results_len = 0

# We loop until we get no results.
while results_len == 0:

    # Set the parameters in the URL.
    params= {'access_token':'158d065d-96f2-44c4-aa49-565944c67b38','sDate': sDate,'eData':eDate,'Limit':limit,'Offset':offset,'Market':'en-us', 'Engine' : Engine, 'device':device}

    # Make the request combining the endpoint, headers and params above.
    r = requests.get('http://api.seoclarity.net/seoClarity/keyword?access_token=158d065d-96f2-44c4-aa49-565944c67b38&sDate=20240820&eDate=20240820&Engine=google&Market=en-us&limit=2&offset='+str(offset))

    # Capture the results
    print ("Getting results for" + r.url)
    xml_dict = xmltodict.parse(r.content)
    json_string = json.loads(json.dumps(xml_dict))
    if ((json_string is not None ) and (json_string['keywords'] is not None)) :
        results = json_string['keywords']['keyword']
        for result in results:
            print(result)
            result.setdefault('device', 'm')
            result.setdefault('engine', 'google')
            print(result)
            all_calls.append(result)
    else:
        results={};

    # We append all the results to the all_calls array.


    # Set the next limit.
    offset = limit + offset

    # If this is 0, we'll exit the while loop.
    results_len = len(results) 
    print('results'+ str(results_len))
# Once we've exited the loop, dump all_calls to a CSV.
print(all_calls)
# These are all of the field values from the response. CSV.DictWriter will use
# them to populate the data in the CSV.
fieldnames=['name', 'date', 'highestTrueRank', 'highestWebRank', 'highestRankUrl', 'highestLocalRank', 'highestNewsRank', 'highestImageRank', 'highestVideoRank', 'avgSearchVolume', 'competitors','engine','device']

# Here we write the CSV by iterating through the rows after writing the header.
with open('all_calls.csv', 'w') as csvFile:
    writer = csv.DictWriter(csvFile, fieldnames=fieldnames)
    writer.writeheader()
    for call in all_calls:
        writer.writerow(call)

# Close the file.
csvFile.close()

print ("wrote "+str(len(all_calls)))
