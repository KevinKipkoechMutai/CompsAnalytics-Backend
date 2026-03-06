import secrets
from datetime import datetime

from fastapi import Depends, FastAPI, HTTPException, Request, Response, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from passlib.context import CryptContext
from sqlalchemy.orm import Session
from starlette.middleware.sessions import SessionMiddleware

from .database import Base, engine, get_db
from .models import Account, ComparableProperty, Notification, Property, Transaction, User
from .schemas import (
    AccountIn,
    ComparablePropertyIn,
    LoginInput,
    NotificationIn,
    PropertyIn,
    TransactionIn,
    UserCreate,
    ValuationInput,
)

Base.metadata.create_all(bind=engine)

app = FastAPI(title="CompsAnalytics Backend (FastAPI)")
app.add_middleware(SessionMiddleware, secret_key="replace-with-env-secret")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
    allow_credentials=True,
)

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


@app.get("/users")
def users_index(db: Session = Depends(get_db)):
    return db.query(User).all()


@app.post("/signup", status_code=status.HTTP_201_CREATED)
def users_create(payload: UserCreate, request: Request, db: Session = Depends(get_db)):
    existing = db.query(User).filter(User.email == payload.email).first()
    if existing:
        raise HTTPException(status_code=422, detail="Email already exists")

    user = User(
        user_name=payload.user_name,
        phone_no=payload.phone_no,
        email=payload.email,
        password_digest=pwd_context.hash(payload.password),
        gender=payload.gender,
        avatar=payload.avatar,
    )
    db.add(user)
    db.commit()
    db.refresh(user)
    request.session["user_id"] = user.id
    return user


@app.get("/me")
def users_show(request: Request, db: Session = Depends(get_db)):
    user_id = request.session.get("user_id")
    if not user_id:
        raise HTTPException(status_code=401, detail="Not authorized")
    user = db.get(User, user_id)
    if not user:
        raise HTTPException(status_code=401, detail="Not authorized")
    return user


@app.post("/login")
def sessions_create(payload: LoginInput, request: Request, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == payload.email).first()
    if user and pwd_context.verify(payload.password, user.password_digest):
        request.session["user_id"] = user.id
        return user
    raise HTTPException(status_code=401, detail="Invalid email or password")


@app.delete("/logout", status_code=status.HTTP_204_NO_CONTENT)
def sessions_destroy(request: Request):
    request.session.clear()
    return Response(status_code=204)


@app.get("/properties")
def properties_index(db: Session = Depends(get_db)):
    return db.query(Property).all()


@app.post("/properties", status_code=status.HTTP_201_CREATED)
def properties_create(payload: PropertyIn, db: Session = Depends(get_db)):
    obj = Property(**payload.model_dump())
    db.add(obj)
    db.commit()
    db.refresh(obj)
    return obj


@app.get("/properties/{property_id}")
def properties_show(property_id: int, db: Session = Depends(get_db)):
    obj = db.get(Property, property_id)
    if not obj:
        raise HTTPException(status_code=404, detail="Property not found")
    return obj


@app.delete("/properties/{property_id}", status_code=status.HTTP_204_NO_CONTENT)
def properties_destroy(property_id: int, db: Session = Depends(get_db)):
    obj = db.get(Property, property_id)
    if not obj:
        raise HTTPException(status_code=404, detail="Property not found")
    db.delete(obj)
    db.commit()
    return Response(status_code=204)


@app.post("/value")
def valuation_create(payload: ValuationInput):
    property_data = payload.property
    comparable_values = []
    comparable_sizes = []

    for comp in payload.comparable_properties:
        if property_data.location == comp.location and property_data.category == comp.category:
            if comp.value is not None and comp.size:
                comparable_values.append(comp.value)
                comparable_sizes.append(comp.size)

    valuation = None
    if comparable_values and comparable_sizes and property_data.size:
        comparable_value_analysis = sum(comparable_values) / len(comparable_values)
        comparable_size_analysis = sum(comparable_sizes) / len(comparable_sizes)
        comparable_valuation_rate = comparable_value_analysis / comparable_size_analysis
        valuation = comparable_valuation_rate * property_data.size

    return {
        "title": property_data.title,
        "valuation": valuation,
        "time": datetime.utcnow().isoformat(),
        "document_analysed": len(comparable_values),
    }


@app.get("/accounts")
def accounts_index(db: Session = Depends(get_db)):
    return db.query(Account).all()


@app.post("/accounts", status_code=status.HTTP_201_CREATED)
def accounts_create(payload: AccountIn, db: Session = Depends(get_db)):
    acc = Account(**payload.model_dump())
    db.add(acc)
    db.commit()
    db.refresh(acc)
    return acc


@app.post("/account/default", status_code=status.HTTP_201_CREATED)
def accounts_default(payload: AccountIn, db: Session = Depends(get_db)):
    existing = db.query(Account).filter(Account.user_id == payload.user_id).first()
    if existing:
        raise HTTPException(status_code=401, detail="Already Has an account")

    default_acc = Account(
        account_name=payload.account_name,
        account_email=payload.account_email,
        user_id=payload.user_id,
        acc_no=secrets.token_hex(10),
        tokens=100,
    )
    db.add(default_acc)
    db.commit()
    db.refresh(default_acc)
    return default_acc


@app.get("/transactions")
def transactions_index(db: Session = Depends(get_db)):
    return db.query(Transaction).all()


@app.post("/transactions", status_code=status.HTTP_201_CREATED)
def transactions_create(payload: TransactionIn, db: Session = Depends(get_db)):
    obj = Transaction(**payload.model_dump())
    db.add(obj)
    db.commit()
    db.refresh(obj)
    return obj


@app.get("/notifications")
def notifications_index(db: Session = Depends(get_db)):
    return db.query(Notification).all()


@app.post("/notifications", status_code=status.HTTP_201_CREATED)
def notifications_create(payload: NotificationIn, db: Session = Depends(get_db)):
    obj = Notification(**payload.model_dump())
    db.add(obj)
    db.commit()
    db.refresh(obj)
    return obj


@app.patch("/notifications/{notification_id}")
def notifications_update(notification_id: int, payload: NotificationIn, db: Session = Depends(get_db)):
    obj = db.get(Notification, notification_id)
    if not obj:
        raise HTTPException(status_code=404, detail="Notification not found")
    for key, value in payload.model_dump().items():
        setattr(obj, key, value)
    db.commit()
    db.refresh(obj)
    return obj


@app.delete("/notifications/{notification_id}", status_code=status.HTTP_204_NO_CONTENT)
def notifications_destroy(notification_id: int, db: Session = Depends(get_db)):
    obj = db.get(Notification, notification_id)
    if not obj:
        raise HTTPException(status_code=404, detail="Notification not found")
    db.delete(obj)
    db.commit()
    return Response(status_code=204)


@app.get("/health")
def healthcheck():
    return JSONResponse({"status": "ok"})
