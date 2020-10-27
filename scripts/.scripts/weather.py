#!/usr/bin/env python3

import requests
import json
import re
from typing import List, Tuple
from pathlib import Path

"""Retrieve weather information using your current location"""

LOCATION_URL = "http://ip-api.com/json/?fields=lat,lon"
API_KEY_REGEX = re.compile("apiKey=[A-z0-9]*")

API_KEY_BASE_URL = "https://www.wunderground.com/history/daily/us/ny/ithaca/KITH/date/2020-7-11"

PWS_LOCATION_API_URL = (
    "https://api.weather.com/v3/location/near?format=json&product=pws"
)
CURRENT_CONDITIONS_API_BASE_URL = "https://api.weather.com/v2/pws/observations/current?format=json&units=e&numericPrecision=decimal"


def get_api_key(base_url: str, regex: re.Pattern) -> str:
    response = requests.get(base_url)
    re_return = regex.search(response.text).group()
    if not re_return:
        raise ValueError(
            "Could not find the api key you were looking for."
        )

    return re_return[7:]


def get_nearest_pws(
    api_base_url: str, api_key: str, lat: float, lon: float
) -> List[str]:
    req = api_base_url + f"&geocode={lat},{lon}" + f"&apiKey={api_key}"
    res = requests.get(req)
    return res.json()["location"]["stationId"]


def get_current_conditions(
    api_base_url: str, api_key: str, stations: List[str]
) -> str:
    for station in stations:
        req = (
            api_base_url
            + f"&stationId={station}"
            + f"&apiKey={api_key}"
        )
        res = requests.get(req)
        if res.status_code != 200:
            continue
        temp = res.json()["observations"][0]["imperial"]["temp"]
        if temp:
            return temp


def get_location(api_base_url: str) -> Tuple[float, float]:
    location_req = requests.get(api_base_url)

    if location_req.status_code < 300:

        location = location_req.json()
        lat, lon = location["lat"], location["lon"]
        return lat, lon

    raise ConnectionError(
        "Please check internet connection, location from ip returned > 300"
    )


def main():
    lat, lon = get_location(LOCATION_URL)
    api_key = get_api_key(API_KEY_BASE_URL, API_KEY_REGEX)
    nearest_stations = get_nearest_pws(
        PWS_LOCATION_API_URL, api_key, lat, lon
    )
    current_temp = get_current_conditions(
        CURRENT_CONDITIONS_API_BASE_URL, api_key, nearest_stations
    )
    if current_temp:
        print(current_temp)


if __name__ == "__main__":
    main()
# WEATHER_URL = f"https://api.weather.gov/points/{lat},{lon}/stations"

# weather_req = requests.get(WEATHER_URL)

# weather = weather_req.json()

# closest_station = weather["observationStations"][0]

# observation_req = requests.get(
#     f"{closest_station}/observations/latest"
# ).json()

# observation_req = observation_req["properties"]

# condition_description = observation_req["textDescription"]
# temperature = int(
#     round((observation_req["temperature"]["value"] * 1.8) + 32, 0)
# )
# precipitation = (
#     observation_req["precipitationLastHour"]
#     if observation_req["precipitationLastHour"]["value"]
#     else ""
# )

# print(f"{condition_description} {temperature} {precipitation}")
