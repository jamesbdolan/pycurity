env:
	python3 -m venv env/
	env/bin/pip install --upgrade pip pip-tools
	env/bin/pip-compile requirements.in
	env/bin/pip-sync

env-dev: env
	env/bin/pip-compile requirements-dev.in
	env/bin/pip-sync requirements.txt requirements-dev.txt

run:
	python src/main.py

.PHONY: env