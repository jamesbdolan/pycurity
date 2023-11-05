# your dev venv should already be created and activated
# i.e. run "pyenv virtualenv 3.10.13 pycurity-dev && pyenv activate pycurity-dev"

## I got these lines from [here](https://hynek.me/articles/python-app-deps-2018/)
## Read the man if [unclear](https://pip-tools.readthedocs.io/en/latest/cli/pip-compile/)
update-deps:
	pip install --upgrade pip-tools pip setuptools
	pip-compile --allow-unsafe --upgrade --build-isolation --generate-hashes --output-file requirements/requirements.txt requirements/main.in
	pip-compile --allow-unsafe --upgrade --build-isolation --generate-hashes --output-file requirements/requirements-dev.txt requirements/dev.in

init:
	pip install --editable .
	pip install --upgrade -r requirements/requirements.txt  -r requirements/requirements-dev.txt
	rm -rf .tox

update: update-deps init

.PHONY: update-deps init update