# -*- coding: utf-8 -*-

"""Console script for ptct."""
import sys
import argparse
import logging
import ptct


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('input', help='The value to convert')
    parser.add_argument('units', help='The input units <K/R/F/C>')
    parser.add_argument('target', help='The targeted units <K/R/F/C>')
    parser.add_argument('-r', '--response', help='The student response to check')
    parser.add_argument('-v', '--verbose', action='store_true', help='Verbose logging')
    parser.add_argument('-d', '--debug', action='store_true', help='Debug logging')
    return parser.parse_args()


def main():
    args = parse_args()
    logger = logging.getLogger()
    loghandler = logging.StreamHandler()
    loghandler.setFormatter(logging.Formatter('ptct: %(levelname)s: %(message)s'))
    logger.addHandler(loghandler)
    if args.debug:
        logger.setLevel(logging.DEBUG)
    elif args.verbose:
        logger.setLevel(logging.INFO)
    logger.info("Given the value:   {} {}".format(args.input, args.units))
    result = ptct.convert(args.input, args.units, args.target)
    output = ""
    if result is None:
        output = "invalid"
    else:
        logger.info("Converts to value: {} {}".format(result, args.target))
        if args.response:
            output = "correct" if int(args.response) == int(result) else "incorrect"
            logger.info("Output: {}".format(output))
        else:
            print("Result: {} {}".format(result, args.target))
    print(output)
    return 0


if __name__ == "__main__":
    sys.exit(main())  # pragma: no cover
