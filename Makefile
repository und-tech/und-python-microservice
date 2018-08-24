.PHONY: clean-pyc clean-build test

IMAGE =			und-python-microservice
BASE_BASH = 	IMAGE=${IMAGE} ./task.sh bash
BASE_SETUP =	IMAGE=${IMAGE} ./task.sh setup
BASE_PYTHON = 	IMAGE=${IMAGE} ./task.sh python
S3_PATH ?= 		infraestructura.dev/resources/python/

clean: clean-build clean-pyc

clean-build:
	$(BASE_BASH) "rm -fr build/"
	$(BASE_BASH) "rm -fr dist/"
	$(BASE_BASH) "rm -fr *.egg-info"

clean-pyc:
	$(BASE_BASH) "find . -name '*.pyc' -exec rm -f {} +"
	$(BASE_BASH) "find . -name '*.pyo' -exec rm -f {} +"
	$(BASE_BASH) "find . -name '*~' -exec rm -f {} +"

release: clean
	$(BASE_SETUP) "sdist bdist_wheel"
	$(BASE_BASH) "twine upload dist/*"


release_test: clean
	$(BASE_SETUP) "sdist bdist_wheel"
	$(BASE_BASH) "twine upload dist/* -r testpypi --skip-existing"

sdist: clean
	$(BASE_SETUP) sdist
	ls -l dist

test:
	pip install -e .
	flake8 .
	py.test tests/

coverage:
	coverage run --source=dotenv --omit='*tests*' -m py.test tests/ -v --tb=native
	coverage report

coverage-html: coverage
	coverage html

build-image:
	docker build -f docker/Dockerfile -t und-python-microservice .

setup:
	$(BASE_SETUP) install

lint:
	$(BASE_BASH) pylint und_microservice

active_env:
	@maksource ENV/bin/activate
	@pip3 install -r app/requirements.txt

sync_pypirc:
	rm .pypirc
	aws s3 cp s3://$(S3_PATH).pypirc .pypirc

update_pypirc:
	aws s3 cp .pypirc s3://$(S3_PATH).pypirc
