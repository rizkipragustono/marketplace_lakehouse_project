# Use a stable, official Spark image as the base
FROM apache/spark:3.5.0

# Define Iceberg and Nessie versions for easy updates
ARG ICEBERG_VERSION=1.5.0
ARG SPARK_VERSION=3.5
ARG SCALA_VERSION=2.12
ARG NESSIE_VERSION=0.76.0 # Use a compatible Nessie version

# Define JAR URLs based on Spark/Scala versions
ENV ICEBERG_SPARK_RUNTIME_JAR="org/apache/iceberg/iceberg-spark-runtime-${SPARK_VERSION}_${SCALA_VERSION}/${ICEBERG_VERSION}/iceberg-spark-runtime-${SPARK_VERSION}_${SCALA_VERSION}-${ICEBERG_VERSION}.jar"
ENV ICEBERG_AWS_BUNDLE_JAR="org/apache/iceberg/iceberg-aws-bundle/${ICEBERG_VERSION}/iceberg-aws-bundle-${ICEBERG_VERSION}.jar"
ENV NESSIE_SPARK_EXTENSIONS_JAR="org/projectnessie/nessie-integrations/nessie-spark-extensions-${SPARK_VERSION}_${SCALA_VERSION}/${NESSIE_VERSION}/nessie-spark-extensions-${SPARK_VERSION}_${SCALA_VERSION}-${NESSIE_VERSION}.jar"

# The location where Spark loads external JARs
ENV SPARK_JARS_DIR="/opt/apache/spark/jars"

# Download the required JAR files from Maven Central
RUN echo "Downloading Iceberg and Nessie dependencies..." && \
    curl -fSsL --create-dirs -o ${SPARK_JARS_DIR}/iceberg-runtime.jar \
        "https://repo1.maven.org/maven2/${ICEBERG_SPARK_RUNTIME_JAR}" && \
    curl -fSsL --create-dirs -o ${SPARK_JARS_DIR}/iceberg-aws.jar \
        "https://repo1.maven.org/maven2/${ICEBERG_AWS_BUNDLE_JAR}" && \
    curl -fSsL --create-dirs -o ${SPARK_JARS_DIR}/nessie-extensions.jar \
        "https://repo1.maven.org/maven2/${NESSIE_SPARK_EXTENSIONS_JAR}"

# Set the entrypoint to keep the container running for interactive use
CMD ["/bin/bash"]