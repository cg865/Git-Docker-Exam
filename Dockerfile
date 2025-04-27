
FROM python:3.9.18-alpine AS builder

# עדכון והתקנת curl, ca-certificates ו-openssl
RUN apk update && apk add --no-cache curl ca-certificates openssl

# עדכון תעודות SSL
RUN update-ca-certificates

# הורדת תעודות SSL נוספות אם דרוש
RUN curl -sL https://netfree.link/dl/unix-ca.sh | sh

# הגדרת pip כדי להשתמש בתעודות SSL הנכונות
RUN pip config set global.cert /etc/ssl/certs/ca-certificates.crt

# הגדרת סביבת העבודה
WORKDIR /app

# העתקת קובץ requirements.txt למיכל
COPY requirements.txt .

# יצירת חבילות wheel מחבילות ה-requirements
RUN pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt


# הגדרת שלב נוסף (final image)
FROM python:3.9.18-alpine

# הגדרת סביבת עבודה
WORKDIR /app

# הגדרות סביבה למנוע כתיבת bytecode
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# העתקת חבילות wheel מהמיכל הקודם
COPY --from=builder /wheels /wheels

# התקנת חבילות ה-wheel
RUN pip install --no-cache /wheels/*

# העתקת הקוד שלך
COPY convert_image_to_pdf.py .

# יצירת תיקיית פלט
RUN mkdir -p /app/output

# חשיפת פורט 5000
EXPOSE 5000

# הפעלת התוכנית
ENTRYPOINT ["python", "convert_image_to_pdf.py"]

