'''
An API using FastAPI
'''
from typing import Optional
from fastapi import FastAPI
from fastapi.responses import RedirectResponse, JSONResponse
from git import Repo


app = FastAPI(
    title="HTTP Service like a boss",
    description="**API** 123",
    version="0.1.0",
    terms_of_service="https://github.com/firemanxbr/http-service",
    contact={
        "name": "Marcelo Barbosa",
        "url": "https://github.com/firemanxbr",
        "email": "mr.marcelo.barbosa@gmail.com",
    },
    license_info={
        "name": "MIT License",
        "url": "https://github.com/firemanxbr/http-service/blob/main/LICENSE",
    },
)


@app.get("/")
async def index():
    '''
    The main route that will redirect to the /docs of swagger
    '''
    return RedirectResponse("/docs")


@app.get("/helloworld")
async def camel_case(name: Optional[str] = None):
    '''
    Route with static return, "Hello Stranger", or
    camel-case given a space
    '''
    output = "Hello Stranger"

    if name:
        name = ''.join(' ' + a if a.isupper() else a for a in name)
        output = f"Hello{name}"

    return output

@app.get("/versionz", response_class=JSONResponse)
async def versionz():
    '''
    Route with git hash and name of project
    '''
    repo = Repo(".")
    commit_hash = repo.git.rev_parse("HEAD")
    project_name = repo.working_dir.split('/')[-1:]

    return [{"commit_hash": commit_hash, "project_name": project_name}]
