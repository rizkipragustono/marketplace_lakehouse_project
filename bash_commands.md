- curl -LfO 'https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml'
- mkdir -p ./dags ./logs ./plugins
- echo -e "AIRFLOW_UID=$(id -u)\nAIRFLOW_GID=0" > .env

- docker compose up -d
- docker compose up --build
- docker compose down
- docker compose down -v
- docker compose ps
- docker compose logs -f

- git init
- git remote add origin git@github.com:rizkipragustono/marketplace_lakehouse_project.git
<!-- - git config --global core.autocrlf input -->
- git config --global core.autocrlf true

- ssh-keygen -t ed25519 -C "your_email@example.com"
- cat ~/.ssh/id_ed25519.pub | clip
- ssh-add ~/.ssh/id_ed25519
