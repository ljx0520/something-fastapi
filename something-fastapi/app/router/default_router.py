#!/usr/bin/env python
# -*- coding: UTF-8 -*-
from fastapi import APIRouter

router = APIRouter(tags=["Default"])


@router.get("/")
async def index():
    """
    Default router
    """
    return {
        "code": 200,
        "msg": "Hello World!"
    }
