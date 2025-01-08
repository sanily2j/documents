import openai
import os

# Initialize OpenAI API
openai.api_key = 'your-api-key'

def scan_codebase(directory):
    codebase_summary = ""
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".py"):
                with open(os.path.join(root, file), 'r') as f:
                    code = f.read()
                    response = openai.Completion.create(
                        engine="davinci-codex",
                        prompt=f"Analyze the following code and provide an overview:\n\n{code}",
                        max_tokens=1500
                    )
                    codebase_summary += response.choices[0].text.strip() + "\n\n"
    return codebase_summary

# Example directory path
directory_path = "/path/to/your/codebase"

# Scan codebase and generate overview
codebase_overview = scan_codebase(directory_path)
print(codebase_overview)
