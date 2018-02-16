#!/bin/bash -eu


echo "Checking UAT Service availability"

curl -k -H "Content-Type: application/json" -X POST -d '{
    "mediation": {
        "clientHeader": {
            "clientName": "newyorkandcompany",
            "correlationData": "",
            "timeStamp": "Apr 1, 2015 9:00:00 AM",
            "version": "1.0.0"
        },
        "credentials": {
             "username": "180SL87zqi0f2fw"
        }
    },
    "request": {
        "accountIdentifier": {
            "clientName": "newyorkandcompany",
            "deviceId": "127.0.0.1"
        }
    }
}' https://retailuat.alldata.net/axes103/rest/loginservice1x/loginservice10/logout -o logout.txt
nac_service_response=$(<logout.txt)
 
if [[ $nac_service_response != *"01900"* ]]
      then
          printf "\\n\\n\\n!!!!!!!!!!!!!!!!!!!!!!!!\\n NAC Service ERROR\\nResponse = $nac_service_response \\n!!!!!!!!!!!!!!!!!!!!!!!!\\n\\n"
          exit -1
      else
          echo NAC Service Success
fi 
    
curl -k -L https://retailuat1.alldata.net/services/propertyservice/properties/client/newyorkandcompany -o properties.txt
nac_prop_response=$(<properties.txt)
 
if [[ $nac_prop_response != *"16000"* ]]
      then
          printf "\\n\\n\\n!!!!!!!!!!!!!!!!!!!!!!!!\\n Property Service ERROR\\nResponse = $nac_prop_response \\n!!!!!!!!!!!!!!!!!!!!!!!!\\n\\n"
          exit -1
      else
          echo Property Service Success
fi


