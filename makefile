make:
	vim makefile

up:
	docker-compose up --build

venv:
	virtualenv -p python3 venv

deps:
	./venv/bin/pip3 install -r requirements.txt

test:
	./venv/bin/python -m unittest ab/*test.py

stress_test_mab:
	while true; do ./venv/bin/python -m unittest ab/mab_test.py; done

demo_mab:
	./venv/bin/python ab/mab_demo.py

checkin: test
	git add -A && git commit && git push

setup:
	./venv/bin/python setup.py sdist upload
