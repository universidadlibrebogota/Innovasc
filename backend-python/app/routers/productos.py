from fastapi import APIRouter, Depends
from app.core.security import get_current_user, require_role

router = APIRouter(prefix="/productos", tags=["productos"],
                   dependencies=[Depends(get_current_user)])
# Para admins: dependencies=[Depends(require_role("admin"))]
