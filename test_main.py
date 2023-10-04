# write a test case for main.py
import pytest
from fastapi.testclient import TestClient
from main import *

client = TestClient(app)

def test_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello World"}

def test_say_hello():
    name = "Alice"
    response = client.get(f"/say_hello/{name}")
    assert response.status_code == 200
    assert response.json() == {"message": f"Hello {name}"}
    