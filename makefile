make:
	vim makefile

venv:
	virtualenv -p python3 venv

deps:
	./venv/bin/pip3 install -r requirements.txt

test:
	./venv/bin/python -m unittest discover -p *_test.py
