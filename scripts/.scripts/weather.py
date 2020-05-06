#!/usr/bin/env python3

import requests
from pathlib import Path

"""Retrieve weather information using your current location"""

LOCATION_URL = "http://ip-api.com/json/?fields=lat,lon"

location_req = requests.get(LOCATION_URL)

if location_req.status_code < 300:

    location = location_req.json()
    lat, lon = location['lat'], location['lon']

else:
    raise IOError('Please check internet connection, location from ip returned > 300')

WEATHER_URL = f"https://api.weather.gov/points/{lat},{lon}/stations"

weather_req = requests.get(WEATHER_URL)

weather = weather_req.json()

closest_station = weather["observationStations"][0]

observation_req = requests.get(f"{closest_station}/observations/latest").json()

observation_req = observation_req["properties"]

condition_description = observation_req["textDescription"]
temperature = int(round((observation_req["temperature"]["value"] * 1.8) + 32,0))
precipitation = observation_req["precipitationLastHour"] if observation_req["precipitationLastHour"]["value"] else ''

print(f"{condition_description} {temperature} {precipitation}")
