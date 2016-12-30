VIRTUALENV_PATH=./venv

.PHONY: clean virtualenv check test watchtest deepclean

all: watchtest

virtualenv: deepclean
	virtualenv -p python3 ${VIRTUALENV_PATH}
	${VIRTUALENV_PATH}/bin/pip install -U pip
	${VIRTUALENV_PATH}/bin/pip install -r requirements.txt

check:
	${VIRTUALENV_PATH}/bin/pyflakes src

test: check
	${VIRTUALENV_PATH}/bin/pytest src --cov src/

watchtest:
	env PATH=${VIRTUALENV_PATH}/bin:${PATH} ${VIRTUALENV_PATH}/bin/ptw src -- --cov src/

clean:
	find . -name "*.py[co]" -delete
	find . -name "__pycache__" -delete

deepclean: clean
	rm -fr ${VIRTUALENV_PATH}
