import sys
import img2pdf
import os

pdfname = os.getenv("PDF_NAME", default="output")

filepath = sys.argv[1]
imgs = []

if os.path.isdir(filepath):
    for fname in os.listdir(filepath):
        if not fname.lower().endswith(('.jpg', '.jpeg', '.png')):
            continue
        path = os.path.join(filepath, fname)
        if os.path.isfile(path):
            imgs.append(os.path.abspath(path))
else:
    if filepath.lower().endswith(('.jpg', '.jpeg', '.png')) and os.path.isfile(filepath):
        imgs.append(os.path.abspath(filepath))

if not imgs:
    print("No valid image files found.")
    sys.exit(1)

# Now write the PDF
with open(f"./output/{pdfname}.pdf", "wb") as f:
    f.write(img2pdf.convert(imgs))

