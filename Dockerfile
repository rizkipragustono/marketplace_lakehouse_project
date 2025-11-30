FROM apache/airflow:3.1.3

# Switch to the airflow user (good practice)
USER airflow

# Set the AIRFLOW_HOME environment variable
ENV AIRFLOW_HOME=/opt/airflow

# Copy and install the requirements file
# This is a common pattern to leverage Docker caching.
COPY requirements.txt .

# Install any required Python packages/dependencies that your DAGs need
# The '--no-cache-dir' and '--upgrade pip' are standard best practices
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy your DAGs (Directed Acyclic Graphs) into the image
# This is how Airflow knows what workflows to run.
COPY dags/ /opt/airflow/dags/

# Copy your custom plugins (if any)
COPY plugins/ /opt/airflow/plugins/