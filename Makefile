install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

.PHONY: test

test:
	export PYTHONPATH=$$PYTHONPATH:$(PWD); \
	pytest --cov=main tests
	coverage report -m
	coverage html


format:
	black *.py

run:
	python main.py

run-uvicorn:
	uvicorn main:app --reload

killweb:
	sudo killall uvicorn

lint:
	pylint --disable=R,C main.py

all: install lint