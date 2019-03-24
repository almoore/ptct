==================================
Python Temperature Conversion Test
==================================


.. image:: https://img.shields.io/pypi/v/ptct.svg
        :target: https://pypi.python.org/pypi/ptct

.. image:: https://img.shields.io/travis/almoore/ptct.svg
        :target: https://travis-ci.org/almoore/ptct

.. image:: https://readthedocs.org/projects/ptct/badge/?version=latest
        :target: https://ptct.readthedocs.io/en/latest/?badge=latest
        :alt: Documentation Status




Python program to convert temperature between Kelvin, Celsius, Fahrenheit, and Rankine to check students calcuations


* Free software: Apache Software License 2.0
* Documentation: https://ptct.readthedocs.io.


Intallation
-----------

.. code-block:: console

    $ pip install ptct


Features
--------

Takes the following inputs:

  - An input temperature
  - An input unit of measure
  - A target unit of measure
  - An optional numeric response

The student’s response must match an authoritative answer after both the student’s response and authoritative answer are rounded to the ones place. The system indicates that the response is correct, incorrect, or invalid. 

When given no response it will retrun the conversion result.

Basic Usage
-----------

.. code-block:: console

   usage: ptct [-h] [-r RESPONSE] [-v] [-d] input units target

   positional arguments:
     input                 The value to convert
     units                 The input units <K/R/F/C> long names also supported
     target                The targeted units <K/R/F/C> long names also supported

   optional arguments:
     -h, --help            show this help message and exit
     -r RESPONSE, --response RESPONSE
                           The student response to check
     -v, --verbose         Verbose logging
     -d, --debug           Debug logging


Examples
--------

.. code-block:: console

   $ ptct 23 F C
   -5.0
   $ ptct 20 F C --response -6
   correct
   $ ptct 40 C F --response 100
   incorrect

    
Credits
-------

This package was created with Cookiecutter_ and the `audreyr/cookiecutter-pypackage`_ project template.

.. _Cookiecutter: https://github.com/audreyr/cookiecutter
.. _`audreyr/cookiecutter-pypackage`: https://github.com/audreyr/cookiecutter-pypackage
