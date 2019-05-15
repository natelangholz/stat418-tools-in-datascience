#!/usr/bin/env python3

def predict(dict_values):
    x1 = float(dict_values["x"])
    y_pred = 2**x1
    return y_pred
