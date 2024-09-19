# Python Sample Application Project

A Python 3.x sample application (vs. library), intended to bootstrap new projects. Uses
[uv](https://github.com/astral-sh/uv), [pytest](https://pytest.org/),
[mypy](https://www.mypy-lang.org), [ruff](https://github.com/astral-sh/ruff), and
[safety](https://github.com/pyupio/safety) tools, and integrates with VS Code as well as a
Makefile-based cli development flow.

This repository represents my current understanding and opinion on how to best structure a
Python 3 application repository. I generally write a lot of "little Python applications"
for work and for personal use, and want them to have a good foundation.

## Prerequisites

I generally develop on macOS, though I also use Linux, FreeBSD, and sometimes
Windows. This repo is meant to support Unix-like OSes.

### Getting a Python development toolchain in place with `uv`

System-provided Python installs, as well as the Python runtimes installed by
[Homebrew](https://brew.sh) can suffer from "[dependency
hell](https://en.wikipedia.org/wiki/Dependency_hell)" problems when installing libraries
(typically because you type `pip install libxyz`). These runtimes use a _shared_ library
directory, and so can easily get into an inconsistent state. Python solved this problem
through [virtual environments](https://docs.python.org/3/tutorial/venv.html) ("venv") -
and every project, tool, etc. on your system should use its own venv. Managing the base
Python runtime and host of virtual environments can be a lot of work, so many tools exist
to support this.

As of September 2024, I believe the best solution to this is to just use `uv`
everywhere. There are several easy ways to [install
uv](https://docs.astral.sh/uv/getting-started/installation/). I just use:

```sh
$ brew install uv
```

### A diversion about tools that happen to be built with Python

If you want to install a tool like `uv`, it's just a single binary file. Most Python-based
tools are made up of many Python source-files, and will need a Python runtime and possibly
3rd party libraries in order to run. If these tools are installed in a global Python
environment, we run into the dependency conflict mentioned above. Tools like
[pipx](https://github.com/pypa/pipx) were developed to solve this problem. Each
Python-implemented tool is installed in an isolated virtual environment, and then the CLI
tools are symlinked into your `$PATH`.

`uv` supports this capability with `uv tool install ...`. Since `uv` is installed already,
`pipx` is not needed.

Let's install a couple of tools to see how it works:

```sh
$ uv tool install cowsay
$ uv tool install ruff
```

Here we've install [cowsay](https://pypi.org/project/cowsay/) and
[ruff](https://github.com/astral-sh/ruff) into their own separate Python virtual
environments. We can list the installed tools, and upgraded them individually or
collectively:

```sh
$ uv tools list
...
$ uv tool upgrade cowsay
$ uv tool upgrade --all
```

The `cowsay` and `ruff` commands are now available on your `$PATH`.

### pyproject.toml

The dependencies of the actual Python app, as well as the settings for the associated
development, testing, and deployment tools are specified in the `pyproject.toml` file at
the app-root directory, and are generally managed by the `uv` tool itself, which will
create and automatically use a local virtual-environment just for this application. The
included `Makefile` includes targets to remove and recreate this virtual environment if
needed (`make pristine` and `make boot` respectively). In addition, all of the settings
for the various other development tools, like `ruff` and `pytest` are also managed in
sections within the `pyproject.toml` file.

## Using the project

Clone this project into your own, new repository, and change the references to `sample` to
your own project name. In particular, be sure to edit `pyproject.toml`. You can then
bootstrap your development and runtime environment, and verify that the tests pass:

```sh
$ make boot
$ make test
```

(If you're logged into Github, you can alternatively click the "Use this template" button
to create a new repository based on this one.)

All of the various development tools (like `mypy`, `ruff`, etc.) are installed *inside*
the local virtual environment. Unless you've taken other steps, you will need to use
`uv` to run the tools. For example:

```sh
$ uv run pytest -v tests/test_sample.py
```

This uses `uv` to run the `pytest` command in the context of the project- (and
directory-) local virtual environment. See the `Makefile` for other examples.
