FROM python:3.9

# Set the working directory
WORKDIR /app/backend

# Install system dependencies
COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install app dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files into the container
COPY . /app/backend

# Expose the application port
EXPOSE 8000

# Run the Django development server to keep the container running
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
