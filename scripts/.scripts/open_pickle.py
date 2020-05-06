#/usr/bin/env python3

import sys
import pickle as pkl
from pprint import pprint

for file in sys.argv[1:]:
  with open(file, 'rb') as f:
    pprint(pkl.dump(f))

    if len(sys.argv) > 2:
      print('<'*65)
