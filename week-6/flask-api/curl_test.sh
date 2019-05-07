#!/bin/bash

curl http://localhost:5000/

curl -H "Content-Type: application/json" -X POST -d '{"grade":"10.0","lat":"47.5396","long":"-122.073","sqft_living":"4495.0","waterfront":"0.0","yr_built":"2007.0"}' "http://localhost:5000/predict_price"
