import webbrowser
from pydantic import Field
from instructor import OpenAISchema

class Function(OpenAISchema):
    """
    Opens a specified URL in the default web browser.
    """
    url: str = Field(
        ...,
        example="https://www.example.com",
        descriptions="URL to open in the web browser."
    )

    class Config:
        title = "open_in_browser"

    @classmethod
    def execute(cls, url: str) -> str:
        try:
            webbrowser.open(url)
            return f"Successfully opened {url} in the default web browser."
        except Exception as e:
            return f"Error opening {url} in the web browser: {e}"
