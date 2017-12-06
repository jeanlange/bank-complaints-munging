## What is it
A program for converting one giant JSON file into many small JSON files, one per record of the original JSON.

`small.json` is an extracted bit of the first few records from the full JSON file. You can get the full file from https://www.consumerfinance.gov/data-research/consumer-complaints/

This works on my super specific data where it expects the data in an array under "data" and the column names under "meta" > "view" > "columns" > "name". Listen. You can change it to work for your stuff. I don't have a generalized case.

The intent is that I'm going to ingest these files into Discovery next.

## How do I run it
1. Get rid of old data in your `json_output` directory: `rm -rf json_output/*`
1. Run the program, giving it a file to work on: `./convert.rb big.json`
  * If you don't give it a filename, it'll look for a 'small.json'. If that doesn't exist, it'll crash
1. Look in `json_output` for your output file[s].