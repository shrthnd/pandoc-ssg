---
domain: localhost
---
# Greetings!

Lorem ipsum dolor sit amet.

## Veggies es bonus vobis, **proinde vos postulo essum magis kohlrabi** welsh onion daikon amaranth tatsoi tomatillo melon azuki bean garlic.

Gumbo beet greens corn soko endive gumbo gourd. Parsley shallot courgette tatsoi pea sprouts fava bean collard greens dandelion okra wakame tomato. Dandelion cucumber earthnut pea peanut soko zucchini. 

## Turnip greens yarrow ricebean rutabaga endive cauliflower 

Sea lettuce kohlrabi amaranth water spinach avocado daikon napa cabbage asparagus winter purslane kale. Celery potato scallion desert raisin horseradish spinach carrot soko. 

### Lotus root water spinach fennel 

Kombu maize bamboo shoot green bean swiss chard seakale pumpkin onion chickpea gram corn pea. Brussels sprout coriander water chestnut gourd swiss chard wakame kohlrabi beetroot carrot watercress. Corn amaranth salsify bunya nuts nori azuki bean chickweed potato bell pepper artichoke. 

```bash
#!/bin/bash
DIR=$PWD
IN=content
OUT=build

function parse {
  local LIN=$1
  local LOUT=$2
  for FILE in $LIN/*
    do
      [ ! -d $OUT/$LOUT ] && mkdir -v $OUT/$LOUT
      if [ -f $FILE ];
        then
          local NAME=$(basename $FILE .md)
          echo "Transforming $FILE"
          pandoc -d ./Defaults -s -f markdown -t html5 $FILE -o $OUT/$LOUT/$NAME.html
      fi
      if [ -d $FILE ];
        then
          parse $FILE $(basename $FILE)
      fi
    done
}

function build {
  # loop $1=input $2=output
  parse $1 $2

  # todo:
  # - watch scss -> $OUT/*.css
  # - watch scripts  -> $OUT/*.js

  # copy these files if they exist
  [ -f src/theme.css ] && cp src/theme.css $OUT/theme.css
  [ -f src/app.js ] && cp src/app.js $OUT/app.js
}

echo "Initializing static-site generation..."
build $DIR/$IN
echo "Static-site generation complete."
```