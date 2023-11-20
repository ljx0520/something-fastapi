#!/usr/bin/env python
# -*- coding: UTF-8 -*-

from fastapi import APIRouter

router = APIRouter(
    prefix="/demo",
    tags=["Demo"]
)


@router.get("/echo/{text}")
async def queryParamReceive(text: str):
    """
    Demo: Query Param Receive
    """
    return {
        "msg": text
    }
