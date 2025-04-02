FROM python:3.10

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY src/ .

EXPOSE 8080

ENV PORT=8080

ENV PYTHONUNBUFFERED=1

CMD ["python", "app.py"]
