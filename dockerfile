FROM PYTHON: 3.11-slim
WORKDIR /app
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY app/ ./app/

# Criar usuário
RUN addgroup --system appgroup
RUN adduser --system --ingroup appgroup appuser
  
#inicializar o contâiner
USER appuser
EXPOSE 8080
CMD ["uvicorn","app.main:app","--host","0.0.0.0","--port","8080"]
