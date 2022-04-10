'''
Tests cases
'''
from starlette.testclient import TestClient
from app.api import app

client = TestClient(app)

# pylint: disable=unused-argument
def test_index(test_client):
    '''
    Test for index endpoint '/'
    '''
    response = client.get("/")
    assert response.status_code == 200

def test_helloworld(test_client):
    '''
    Test for helloworld endpoint '/helloworld'
    '''
    response = client.get('/helloworld')
    assert response.status_code == 200
    assert response.json() == {"output": "Hello Stranger"}

def test_camelcase(test_client):
    '''
    Test for camel-case endpoint '/helloworld?name=AlfredENeumann'
    '''
    response = client.get('/helloworld?name=AlfredENeumann')
    assert response.status_code == 200
    assert response.json() == {"output": "Hello Alfred E Neumann"}

def test_versionz(test_client):
    '''
    Test for versionz endpoint '/versionz'
    '''
    response = client.get('/versionz')
    assert response.status_code == 200
    assert response.json()["project_name"] == ["http-service"]
    assert len(response.json()["commit_hash"]) == 40
