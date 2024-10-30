import email
from bs4 import BeautifulSoup

# Open and read the .eml file
with open("raw.eml", "r") as f:
    msg = email.message_from_file(f)

# Initialize variable to store HTML content
html_content = None

# Parse each part of the email to find HTML content
for part in msg.walk():
    # Check if the part is HTML
    if part.get_content_type() == "text/html":
        html_content = part.get_payload(decode=True).decode(
            part.get_content_charset(), errors="ignore")
        break

# Clean and format HTML (if found)
if html_content:
    soup = BeautifulSoup(html_content, "html.parser")
    pretty_html = soup.prettify()

    with open("formatted.html", "w") as f:
        f.write(pretty_html)
else:
    print("No HTML content found in the email.")
