from os import environ
import subprocess
from urllib.parse import urlparse
from pathlib import Path
def read_token():
    token = Path("/run/secrets/token").read_text()
    environ["SURGE_TOKEN"] = token
    return token

def validate(url):
    result = urlparse(url)
    return all([result.scheme, result.netloc, result.path])

def surge():
    dir_ = environ.get("build", "./")
    project = environ["SURGE_PROJECT"]
    if not validate(project):
        project = f"{project}.surge.sh"
    token = read_token()
    
    result = subprocess.run(["surge", dir_, project, "--token", token], stdout=subprocess.PIPE)
    
    output = result.stdout.decode(encoding="utf-8")
    
    import re
    
    deploy_url = re.search(r"Success! - Published to (.+)", output)
    if deploy_url:
        url, *_ = deploy_url.groups()
        file_ = Path("/surge/deployUrl")
        file_.parent.mkdir(parents=True)
        file_.touch(exist_ok=True)
        file_.write_text(url)


if __name__ == "__main__":
    surge()
