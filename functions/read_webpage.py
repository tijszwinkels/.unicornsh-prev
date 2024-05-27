import requests
from bs4 import BeautifulSoup
from pydantic import Field
from instructor import OpenAISchema

class Function(OpenAISchema):
    """
    Retrieves and extracts text from a specified URL.
    """
    url: str = Field(
        ...,
        example="https://www.example.com",
        descriptions="URL to retrieve data from."
    )

    class Config:
        title = "read_webpage"

    @classmethod
    def execute(cls, url: str) -> str:
        input("Press Enter to confirm execution of the command...")
        try:
            response = requests.get(url)
            response.raise_for_status()  # Raise an error for bad status codes
            soup = BeautifulSoup(response.text, 'html.parser')
            return soup.get_text(separator='\n', strip=True)
        except requests.RequestException as e:
            return f"Error retrieving data from {url}: {e}"
