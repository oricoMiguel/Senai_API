FROM python:3.11-slim

WORKDIR /app

# 1. Instalar dependências do sistema e atualizar pip
RUN pip install --upgrade pip

# 2. Criar usuário e grupo primeiro
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# 3. Copiar e instalar dependências de Python
# (Isso aproveita o cache do Docker se o requirements não mudar)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copiar o código definindo o dono como o usuário criado
COPY --chown=appuser:appgroup app/ ./app/

# 5. Trocar para o usuário não-root
USER appuser

EXPOSE 8080

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
