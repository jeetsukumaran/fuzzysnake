# !/usr/bin/env python

import os
from setuptools import setup

def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

setup(name="fuzzysnake",
      version="0.1.2.0",
      description="Pure-Python fuzzy find for the terminal",
      url="TBA",
      license="LICENSE",
      scripts=["bin/fz"],
      author="Jeet Sukumaran",
      author_email="Jeet Sukumaran",
      long_description=read('README.rst'),
      classifiers=[
       "License :: OSI Approved :: Apache Software License",
       "Programming Language :: Python :: 2.7",
       "Programming Language :: Python :: 3.4",
       "Operating System :: OS Independent"
      ])
