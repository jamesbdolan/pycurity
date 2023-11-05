env:
	python3 -m venv env/
	env/bin/pip3 install --upgrade pip==23.1
	env/bin/pip3 install pip-tools
	env/bin/pip-compile --allow-unsafe requirements.in
	env/bin/pip-sync

env-dev: env
	env/bin/pip-compile --allow-unsafe requirements-dev.in
	env/bin/pip-sync requirements.txt requirements-dev.txt

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