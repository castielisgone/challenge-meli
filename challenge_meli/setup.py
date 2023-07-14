from setuptools import setup, find_packages

__version__ = "0.1.0"

with open("README.md") as description_file:
    readme = description_file.read()

with open("requirements.txt") as requirements_file:
    requirements = [line for line in requirements_file]

setup(
    name="challenge_meli",
    version=__version__,
    author="Luis Fillype",
    description="Data Engineering Challenge: MELI",
    long_description=readme,
    url="https://github.com/castielisgone/challenge-meli",
    install_requires=requirements,
    packages=find_packages(),
)