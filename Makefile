test:
	poetry run pytest -v .

code-check:
	-ls */__init__.py | xargs dirname | xargs poetry run mypy
	-find . \( -not -path ./.venv/\* \) -name "*.py" -exec poetry run pflake8 {} \;
	-poetry run safety check --bare

format-check:
	-poetry run autopep8 --diff -r .
	-poetry run black --diff -t py39 .

run:
	poetry run main

clean:
	rm -rf htmlcov
	rm -rf .coverage .pytest_cache -rf .mypy_cache
	-find . \( -not -path ./.venv/\* \) -name "__pycache__" -exec rm -rf {} \;

pristine: clean
	rm -rf .venv

boot:
	POETRY_VIRTUALENVS_IN_PROJECT=true poetry install --no-root
