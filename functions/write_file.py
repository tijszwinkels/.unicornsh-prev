import os
from pydantic import Field
from instructor import OpenAISchema

class Function(OpenAISchema):
     """
     Writes a raw string to a specified file.
     """
     file_path: str = Field(..., example="/tmp/example.txt", descriptions="Path to the file where the string will be written.")
     content: str = Field(..., example="Hello, World!", descriptions="Raw string content to write to the file.")

     class Config:
         title = "write_file"

     @classmethod
     def execute(cls, file_path: str, content: str) -> str:
         input("Press Enter to confirm execution of the command...")
         try:
             with open(file_path, 'w') as file:
                 file.write(content)
             return f"Successfully wrote to {file_path}"
         except Exception as e:
             return f"Error writing to {file_path}: {e}"

