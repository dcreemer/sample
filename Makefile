test:
	poetry run pytest -v .

code-check:
	-ls src/*/__init__.py tests/__init__.py | xargs dirname | xargs poetry run mypy
	-find . \( -not -path ./.venv/\* \) -name "*.py" -exec poetry run pflake8 {} \;
	-poetry run safety check --bare

format-check:
	-poetry run black --diff .

run:
	PYTHONPATH=src poetry run sample

clean:
	rm -rf htmlcov
	rm -rf .coverage .pytest_cache -rf .mypy_cache
	-find . \( -not -path ./.venv/\* \) -name "__pycache__" -exec rm -rf {} \;

pristine: clean
	rm -rf .venv

boot:
	POETRY_VIRTUALENVS_IN_PROJECT=true poetry install --no-root
