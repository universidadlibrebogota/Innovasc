import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .api import auth, ajustes, categorias, productos, metrics, uploads

app = FastAPI(title="InovaASC Backend (Python)")

origin_regex = os.getenv("CORS_ORIGIN_REGEX", r"https://.*\.githubpreview\.dev")

app.add_middleware(
    CORSMiddleware,
    allow_origin_regex=origin_regex,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def root():
    return {"ok": True, "service": "InovaASC Backend"}

app.include_router(auth.router)
app.include_router(ajustes.router)
app.include_router(categorias.router)
app.include_router(productos.router)
app.include_router(metrics.router)
app.include_router(uploads.router)
