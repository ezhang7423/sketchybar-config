sketchybar --set $NAME \
  label="Loading..." \
  icon.color=0xff5edaff

# fetch weather data
LOCATION="42.36,-71.12"

WEATHER_JSON=$(curl -s "https://wttr.in/$LOCATION?0pq&format=j1")
# Fallback if empty
if [ -z $WEATHER_JSON ]; then
  sketchybar --set $NAME label="$LOCATION"
  return
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq '.current_condition[0].FeelsLikeF' | tr -d '"')
WEATHER_DESCRIPTION=$(echo $WEATHER_JSON | jq '.current_condition[0].weatherDesc[0].value' | tr -d '"' | sed 's/\(.\{16\}\).*/\1.../')
CITY=$(echo $WEATHER_JSON | jq '.nearest_area[0].areaName[0].value' | tr -d '"')

sketchybar --set $NAME \
  label="$CITY • $TEMPERATURE$(echo '°')F • $WEATHER_DESCRIPTION"
