FROM python:3.11-slim

# install python
RUN apt update && \
    apt install --no-install-recommends -y build-essential gcc && \
    apt clean && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

COPY pyproject.toml pyproject.toml
COPY main.py main.py
WORKDIR /
RUN uv sync --no-cache-dir

ENTRYPOINT ["uv", "run", "python", "-u", "main.py"]