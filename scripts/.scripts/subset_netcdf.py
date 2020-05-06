#!/usr/local/bin/python3

import xarray as xr
import sys

org_lnk = sys.argv[1]
rt_lnk = sys.argv[2]
output_file = sys.argv[3]

org_rt = xr.open_dataset(org_lnk)
rt = xr.open_dataset(rt_lnk)

max_lat = max(org_rt.lat.values)
min_lat = min(org_rt.lat.values) - 0.0001
max_lon = max(org_rt.lon.values) + 0.0001
min_lon = min(org_rt.lon.values)

# print(rt.variables)
new_rt = rt.where((rt.lat >= min_lat) & (rt.lat <= max_lat) & (rt.lon >= min_lon) & (rt.lon <= max_lon), drop=True)
# print(new_rt.variables)

new_rt.to_netcdf(output_file)
# -87.59833,-87.26391,34.20192,34.49317
