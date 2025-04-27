FROM python:3.9.18-alpine AS builder

WORKDIR /app


COPY requirements.txt .
RUN pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt


FROM python:3.9.18-alpine


WORKDIR /app


ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY --from=builder /wheels /wheels
RUN pip install --no-cache /wheels/*

COPY convert_image_to_pdf.py .

RUN mkdir -p /app/output

EXPOSE 5000

ENTRYPOINT ["python", "convert_image_to_pdf.py"]
