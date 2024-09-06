# Dirsets.py

## Usecase

When working with pipelines, fairly often, I run into a situation where all the contents of an `<input>` folder are fed through a program to a `<output>` folder. In an ideal outcome, each item in the input folder goes through the schema well to produce the propriate number of output folders. But sometimes, some input items fail to go throgh the program. We then are left with the task of finding out which items in the input failed. This is the usecase for `dirsets.py`.

## Dependencies

1.  `os`
2.  `sys`
3.  `argparse`

## Input

### Mandatory

1.`--one`

Path to the first directory that needs to be compared to the second one.

2.`--another`

Path to the second directory that needs to be compared with the first one.

### Optional input

1.`--ignore~extensions~`

Should the list comparision be done with only the files' basenames?

Default value = False

## Output

The program will write to `STDOUT` in the following format:

Files in <--one> but not in <--another>: [] (list of files here)

Files in <--another> but not in <--one>: [] (list of files here)

## Sample run

`python dirsets.py --one /path/to/one --another /path/to/another --ignore~extension~ True`