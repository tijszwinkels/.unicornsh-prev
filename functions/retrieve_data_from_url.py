import requests
from pydantic import Field
from instructor import OpenAISchema

class Function(OpenAISchema):
    """
    Retrieves data from a specified URL and returns it.
    """
    url: str = Field(
        ...,
        example="https://www.example.com",
        descriptions="URL to retrieve data from."
    )

    class Config:
        title = "retrieve_data_from_url"

    @classmethod
    def execute(cls, url: str) -> str:
        input("Press Enter to confirm execution of the command...")
        try:
            response = requests.get(url)
            response.raise_for_status()  # Raise an error for bad status codes
            return response.text
        except requests.RequestException as e:
            return f"Error retrieving data from {url}: {e}"
