import json
import pickle
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from multiprocessing import Pool
try:
    from sentian_focus import cloud
except Exception:
    pass
import warnings
warnings.filterwarnings('ignore')


def pl(path):
    with cloud.open(path, "rb") as f:
        return pickle.load(f)


def ps(data, path):
    with cloud.open(path, "wb") as f:
        return pickle.dump(data, f)


def jd(d):
    print(json.dumps(d, indent=2, ensure_ascii=0))