'''
The main file of HTTP Service application
'''
import os
import uvicorn
from uvicorn.config import LOGGING_CONFIG

PORT = os.getenv("HTTP_SERVICE_PORT", default="8080")

if __name__ == "__main__":
    CUSTOM_START = '%(asctime)s %(levelprefix)s %(client_addr)s'
    CUSTOM_END = CUSTOM_START + ' - "%(request_line)s" %(status_code)s'
    DATE_FORMAT = "%Y-%m-%d %H:%M:%S"

    LOGGING_CONFIG["formatters"]["access"]["fmt"] = CUSTOM_END
    LOGGING_CONFIG["formatters"]["default"]["fmt"] = "%(asctime)s %(levelprefix)s %(message)s"

    LOGGING_CONFIG["formatters"]["default"]["datefmt"] = DATE_FORMAT
    LOGGING_CONFIG["formatters"]["access"]["datefmt"] = DATE_FORMAT

    uvicorn.run("app.api:app", host="0.0.0.0", port=int(PORT), reload=True)
