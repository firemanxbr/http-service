'''
The main file of HTTP Service application
'''
import os
import uvicorn

PORT = os.getenv("HTTP_SERVICE_PORT", default="8080")

if __name__ == "__main__":
    uvicorn.run("app.api:app", host="0.0.0.0", port=int(PORT), reload=True)
