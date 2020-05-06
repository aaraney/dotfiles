#!/usr/bin/env python3

import sys
from pprint import pprint
import xarray as xr

if len(sys.argv) > 2:
    pprint(xr.open_mfdataset(*sys.argv[1:]))

else:
    pprint(xr.open_dataset(sys.argv[1]))
