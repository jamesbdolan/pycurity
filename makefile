env:
	pyenv virtualenv 3.10.13 pycurity-dev
	pip install --upgrade pip==23.1 pip-tools
	pip-compile --allow-unsafe requirements.in
	pip-sync

env-dev: env
	pip-compile --allow-unsafe requirements-dev.in
	pip-sync requirements.txt requirements-dev.txt

run:
	python src/main.py

.PHONY: env


## this came from here - https://hynek.me/articles/python-app-deps-2018/
update-deps:
	pip install --upgrade pip-tools pip setuptools
	pip-compile --upgrade --build-isolation --generate-hashes --output-file requirements/main.txt requirements/main.in
	pip-compile --upgrade --build-isolation --generate-hashes --output-file requirements/dev.txt requirements/dev.in

init:
	pip install --editable .
	pip install --upgrade -r requirements/main.txt  -r requirements/dev.txt
	rm -rf .tox

update: update-deps init

.PHONY: update-deps init update