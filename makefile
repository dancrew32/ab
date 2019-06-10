venv:
	virtualenv -p python3 venv

deps:
	./venv/bin/pip3 install -r requirements.txt

test:
	./venv/bin/python -m unittest *test.py

redis_install:
	wget http://download.redis.io/redis-stable.tar.gz
	tar xvzf redis-stable.tar.gz
	cd redis-stable
	make
	cd ../
	rm redis-stable.tar.gz

redis_start:
	./redis-stable/src/redis-server

redis_cli:
	./redis-stable/src/redis-cli

stress_test_mab:
	while true; do ./venv/bin/python -m unittest mab_test.py; done

demo_mab:
	./venv/bin/python mab_demo.py
