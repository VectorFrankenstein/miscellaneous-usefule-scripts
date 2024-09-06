import argparse

import os

import sys

# Create an ArgumentParser object
parser = argparse.ArgumentParser(description='A simple argparse example.')

# Add an argument named 'input'
parser.add_argument('--one', help='What is the path to the first directory that you want analyzed?')

parser.add_argument('--another',help='What is the path to the other directory that you want analyzed?')

parser.add_argument('--ignore_extensions',type=bool,nargs="?",default=False,help="Should files be listed without extensions?")

args = parser.parse_args()

if not (os.path.exists(f"{args.one}") & os.path.exists(f"{args.another}")):
    print("Either one or two of the two paths you provided do not exist or are not supplied properly, please check and re-supply!")
    sys.exit()    
# Parse the command-line arguments

def set_differentials(one:set,another:set):

    one_minus_another = list(one - another)

    another_minus_one = list(another - one)

    return one_minus_another,another_minus_one

def main():

    one = os.listdir(f"{args.one}")

    another = os.listdir(f"{args.another}")

    if args.ignore_extensions:

        one = [i.split('.')[0] for i in one]

        another = [i.split('.')[0] for i in another]

    one_minus_another, another_minus_one = set_differentials(set(one),set(another))

    print(f"Files in {args.one} but not in {args.another}:{one_minus_another}")

    print(f"File in {args.another} but not in {args.one}:{another_minus_one}")

main()
