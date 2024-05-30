# Python Sample Project

A Python 3.x sample project, intended to bootstrap new projects. Uses poetry, pytest, mypy,
[ruff](https://github.com/charliermarsh/ruff), black, and safety tools, and integrates with VS Code as
well as a Makefile-basec cli development flow.

This repository represents my current understanding and opinion on how to best structure a Python 3
application repository. I generally write a lot of "little Python applications" for work and for
personal use, and want them to have a good foundation.

## Prerequisites

I generally develop on macOS, though I also use Linux, FreeBSD, and sometimes Windows. This repo is
meant to support Unix-like OSes.

### Pyenv and Pipx

I *never* install anything into the system-provided Python runtime -- I believe it is there for use
by other system services and tools. To bootstrap my own Python runtime, I use `pyenv` to install a
modern version of Python 3 (Python 3.9+), and then set that as my personal global runtime. The
system Python runtime uses a _shared_ directory for all `pip install`ed packages. If two
Python-based applications depend on different versions of a common library, one will see an
untested and potentially incompatible version (this is sometimes called "[dependency
hell](https://en.wikipedia.org/wiki/Dependency_hell)"). Python can easily avoid this problem
through [virtual environments](https://docs.python.org/3/tutorial/venv.html) - but we have to
choose a strategy for managing them. In addition, we have to consider that the system Python
runtime (as install by "apt" for example) is likely to be different from the runtime we want
(python-3.8.1 vs. python 3.10.2). `Pyenv` manages different user-installed runtimes so that we can
control this too.


To install `pyenv`, I will typically do something like this:

```sh
$ sudo apt install build-essential libsqlite3-dev   # on Linux
$ brew install pyenv                                # on macOS
$ pyenv install 3.10.6
$ pyenv global 3.10.6
```

Be sure to read the [instructions](https://github.com/pyenv/pyenv#installation) on integrating
`pyenv` with your shell.

Now you have `pyenv` and your own Python runtime installed. The next step is to install tools into
your user-global runtime using `pip install`. Here again we face the same problem: we need a way to
nicely install "global" Python-based tools into isolated virtual environments so that they don't
step on each other. This is the roll of [pipx](https://github.com/pypa/pipx). `Pipx` automates the
creation and management of isolated Python virtual-environments for each globally installed tool.
It's a bit like static-linking a program. Let's install `pipx` and then use it to install a couple
tools:

```sh
$ pip install -U pip pipx   # ensure both pip and pipx are installed and up to date
$ pipx install poetry
$ pipx install tqdm
```

Here we've install [poetry](https://python-poetry.org/) and [tqdm](https://tqdm.github.io/) (a
handy little progress bar tool) into their own separate python virtual environments. We can list
the installed tools, and upgraded them individually or collectively:

```sh
$ pipx list
$ pipx upgrade tqdm
$ pipx upgrade-all
```

If I'm on a deployment only environment, or for a very seldom-used system, I may install Poetry
directly into the `pyenv`-installed global environment -- and skip the `pipx` phase.

```sh
$ pip install -U poetry
```

### Poetry

The dependencies of the actual Python app, as well as the settings for the associated
development, testing, and deployment tools are specified in the `pyproject.toml` file at the app-root
directory, and are generally managed by [poetry](https://python-poetry.org/). Among other things,
`poetry` will create and automatically use a local virtual-environment just for this application.
There are three [make targets](https://github.com/dcreemer/sample/blob/main/Makefile#L24-L25)
included to bootstrap, clean, and remove this virtual env.

## Using the project

Clone this project into your own, new repository, and change the references to `sample` to your
own project name. In particular, be sure to edit `pyproject.toml`. You can then bootstrap your
development and runtime environment, and verify that the tests pass:

```sh
$ make boot
$ make test
```

(If you're logged into Github, you can alternatively click the "Use this template" button to create
a new repository based on this one.)

All of the various development tools (like `mypy`, `ruff`, etc.) are installed *inside* the local
virtual environment. Unless you've taken other steps, you will need to use `poetry` to run the tools.
For example:

```sh
$ poetry run pytest -v tests/test_sample.py
```

This uses poetry to run the `pytest` command in the context of the project- (and directory-) local
virtual environment.
