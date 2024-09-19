test:
	uv run pytest -v tests

code-check:
	-uv run mypy src tests
	-uv run ruff check .
	@ # ignore is for the Jijna2 warning, which is brought in by safety itself
	-uv run safety --disable-optional-telemetry check --bare --ignore 70612

format-check:
	uv run ruff format --diff .

run:
	uv run src/main.py

clean:
	rm -rf htmlcov
	rm -rf .coverage .pytest_cache .mypy_cache .ruff_cache
	-find . \( -not -path ./.venv/\* \) -name "__pycache__" -exec rm -rf {} \; 2>/dev/null || true

pristine: clean
	rm -rf .venv

upgrade:
	uv sync --upgrade

boot:
	uv sync -q --prerelease=allow
