#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import uvicorn
from fastapi import FastAPI, Request, Response
from app.router import RegisterRouterList

# init app
app = FastAPI(redoc_url="/redoc", docs_url="/apidoc", title="Something FastAPI")

# load router
for item in RegisterRouterList:
    app.include_router(item.router)

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8080)
