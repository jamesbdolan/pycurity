# Python Tooling

What pushed me away from Python for years has been the tooling, it seemed to be full of tools with overlapping functionality.

What are the *necessary* bits, what are *conventional* bits?

## Breakdown

Some details are coming from [Serious Python](https://nostarch.com/seriouspython)

- Modules explanation by [Stackoverflow](https://stackoverflow.com/a/62923810)
  - Code modules: most common type of code module is a *.py file
  - Package modules: most common type of package module is a directory containing an `__init__.py` file.
    - if one executes a package module via python `<filename>` then `<filename>/__main__.py` will be executed
    - if one executes that same package module via import `<modulename>` then only the package's `__init__.py` will be executed.

- Environments

  - virtualenv aka venv
    - `$ python3 -m venv myvenv` runs the module `venv` where 'myenv' is the directory target
    - `myenv/pyvenv.cfg` can then configure the env to accept system packages
    - for scripting the local creation of venvs for development
      - *bash*: the initial go-to for creating a venv
      - *makefile*: the example I saw was quite self explanatory, [but here's a tutorial](https://makefiletutorial.com/)

        <details>
        <summary>example makefile</summary>

        ```make
        env:
          python3 -m venv env/
          env/bin/pip install --upgrade pip
          env/bin/pip install -U pip wheel setuptools
          env/bin/pip install -r requirements.txt

        env-dev: env
          env/bin/pip install -r requirements-dev.txt

        test:
          pytest tests/tests.py

        test-int:
          python -m pytest tests/integration_tests.py --verbose

        run:
          python src/main.py

        .PHONY: env test
        ```

        </details>

      - [*doit*](https://pydoit.org/): a python makefile tool for running tasks
      - [*just*](https://github.com/casey/just): an upgrade on makefile
      - [*taskfile*](https://taskfile.dev/): this tool spiked an enlightening [debate](https://news.ycombinator.com/item?id=36744450)
    - *poetry*, *pipenv* and *conda* are covered [here](https://modelpredict.com/python-dependency-management-tools)
    - [pyenv](https://github.com/pyenv/pyenv) manages python versions and [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) is a plugin to handle venvs
      - what is really nice is that I no longer need an "env/" dir in my project
      - pyenv is outside of any other python tooling, therefore it is not installed with `pip`

        <details>
        <summary>how I installed and configured them</summary>

        ```sh
        brew install pyenv
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
        echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
        echo 'eval "$(pyenv init -)"' >> ~/.zshrc
        brew install pyenv-virtualenv
        echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
        # tools required for installing python versions
        brew install openssl readline sqlite3 xz zlib tcl-tk
        # installing python version 3.10
        pyenv install 3.10
        ```

        </details>

  - requirements.txt [is not enough](https://modelpredict.com/wht-requirements-txt-is-not-enough)
    - this only lists 1st degree deps, 2nd degree deps are not locked down
    - create requirements.in and dev-requirements.in
    - pip-compile (a program of pip-tools) will create a requirements.txt, pip-sync will sync all packages based off requirements.txt, here's [a helpful article](https://www.mslinn.com/django/400-pip-tools.html) showing this
    - [an interesting article](https://hynek.me/articles/python-app-deps-2018/) about pip-tools, pipenv and poetry
    - [an article](https://lil.law.harvard.edu/blog/2019/05/20/improving-pip-compile-generate-hashes/) on why we should use hashes in our requirements.txt file, bit of a scary story really

  - common packages
    - black
    - isort
    - flake8

  - tox
    - seems to only be used for testing
    - if using .travis.yml, tox can be called which means the local and ci workflows would have same workflow

- Python package configuration
  - I don't believe this stuff is necessary unless you expect someone to be importing your package in their python app.
  - [This blog](https://zhauniarovich.com/post/2020/2020-04-starting-new-python-project/#final-configuration) could be helpful
  - setup.py & setup.cfg
    - contains project config - a script could potentially read from setup.cfg when activating dev venv with pyenv?
    - can contain wheel and sphinx config also

  - entry points
    - epi (Entry Point Inspector) for shell level investigation
    - console scripts
    - plugins and drivers
  - setuptools
    - sdist
    - pbr (Python Build Reasonableness)
    - egg is just a zip file
    - wheel
      - bdist_wheel
        - creates a `.whl` file in _dist_ dir
  - .pypirc - with this file you can configure the PyPi publishing, here we are testing the publish on PyPi's test env
    - `$ python setup.py register           -r testpypi`
    - `$ python setup.py bdist_wheel upload -r testpypi`
    - `$ python setup.py sdist       upload -r testpypi`
    - `$ pip install -i https://testpypi.python.org/pypi your_package`
