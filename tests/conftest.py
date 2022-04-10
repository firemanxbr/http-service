'''
Tests configuration
'''
import pytest
from starlette.testclient import TestClient
from app.api import app

@pytest.fixture(scope="module")
def test_client():
    '''
    Fixture provides a defined, reliable and consistent
    context for the test
    '''
    client = TestClient(app)
    yield client
