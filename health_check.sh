#!/bin/bash

URL="http://127.0.0.1:7860"

if curl -fsS --max-time 10 "$URL" > /dev/null; then
    echo "HEALTHY: AI Meal Planner is responding at $URL"
    exit 0
else
    echo "UNHEALTHY: AI Meal Planner is not responding at $URL"
    exit 1
fi
