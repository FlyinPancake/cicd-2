FROM python:3.12-slim-bullseye

# Install uv.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Copy pyproject.toml
WORKDIR /app
ADD pyproject.toml uv.lock ./

# Install the application dependencies.
RUN uv sync --frozen --no-cache --no-install-project

# Copy the application into the container.
COPY . /app


# Run the application.
CMD ["/app/.venv/bin/fastapi", "run", "app/main.py", "--port", "80"]
