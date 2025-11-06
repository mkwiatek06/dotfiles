import requests
import json
import sys
import time

url = "https://api.weatherapi.com/v1/"
cat = "current"
ret = "json"
key = "259cb36f21d84cbdaa3140729250103"
loc = "Staszow"
air = "yes"

outputArray = {}

def get_weather(url, cat, ret, key, loc, air):

    apiCall = url + cat + "." + ret + "?key=" + key + "&q=" + loc + "&aqi=" + air
    response = requests.get(apiCall)

    if response.status_code == 200:
        data = response.json()
        return data
    else:
        return None


# for x in "MEOW":
# time.sleep(5)
result = get_weather(url, cat, ret, key, loc, air)
if result is not None:

    # "Inspired" by ChatGPT
    text = str(result['current']['temp_c']) + "°C"

    aqi_defra = result['current']['air_quality']['gb-defra-index']
    if aqi_defra is not None:
        if aqi_defra <= 3:
            aqi = "Good"
        elif aqi_defra <= 6:
            aqi = "OK"
        elif aqi_defra <= 9:
            aqi = "Bad"
        elif aqi_defra >= 10:
            aqi = "Very Bad"
    else:
        aqi = "Unknown"

    wind_kph = result['current']['wind_kph']
    wind_dir = result['current']['wind_dir']
    pressure_mb = result['current']['pressure_mb']
    precip_mm = result['current']['precip_mm']
    humidity = result['current']['humidity']
    cloud = result['current']['cloud']
    feelslike_c = result['current']['feelslike_c']
    vis_km = result['current']['vis_km']

    tooltip = ("Air Quality: " + aqi + " (" + str(aqi_defra) + ")" + "\n" +
    "Wind: " + str(wind_kph) + " km/h " + wind_dir + "\n" +
    "Pressure: " + str(pressure_mb) + " hPa" + "\n" +
    "Rain: " + str(precip_mm) + " mm" + "\n" +
    "Humidity: " + str(humidity) + " %" + "\n" +
    "Visibility: " + str(vis_km) + " km")

    alt = ("App.: " + str(feelslike_c) + "°C, " + str(cloud) + "% Cloudy")

    outputArray['text'] = text
    outputArray['tooltip'] = tooltip
    outputArray['alt'] = alt

else:
    outputArray['text'] = "API Error"

sys.stdout.write(json.dumps(outputArray) + "\n")
sys.stdout.flush()
