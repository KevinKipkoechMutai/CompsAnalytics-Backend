from datetime import datetime

from pydantic import BaseModel, ConfigDict, EmailStr


class UserCreate(BaseModel):
    user_name: str | None = None
    phone_no: str | None = None
    email: EmailStr
    password: str
    gender: str | None = None
    avatar: str | None = None


class UserOut(BaseModel):
    id: int
    user_name: str | None = None
    phone_no: str | None = None
    email: EmailStr
    gender: str | None = None
    avatar: str | None = None

    model_config = ConfigDict(from_attributes=True)


class LoginInput(BaseModel):
    email: EmailStr
    password: str


class PropertyIn(BaseModel):
    image: str | None = None
    lr_no: str | None = None
    location: str | None = None
    category: str | None = None
    analysis: str | None = None
    description: str | None = None
    title: str | None = None
    size: int | None = None
    value: str | None = None
    user_id: int | None = None


class PropertyOut(PropertyIn):
    id: int

    model_config = ConfigDict(from_attributes=True)


class AccountIn(BaseModel):
    account_name: str | None = None
    tokens: int | None = None
    account_email: str | None = None
    user_id: int | None = None


class AccountOut(AccountIn):
    id: int
    acc_no: str | None = None

    model_config = ConfigDict(from_attributes=True)


class TransactionIn(BaseModel):
    transaction_code: int | None = None
    amount: int | None = None
    account_number: int | None = None
    account_name: str | None = None
    payment_method: str | None = None
    user_name: str | None = None
    account_id: int | None = None
    user_id: int | None = None


class TransactionOut(TransactionIn):
    id: int

    model_config = ConfigDict(from_attributes=True)


class ComparablePropertyIn(BaseModel):
    location: str | None = None
    size: int | None = None
    category: str | None = None
    value: int | None = None
    title: str | None = None


class ComparablePropertyOut(ComparablePropertyIn):
    id: int

    model_config = ConfigDict(from_attributes=True)


class NotificationIn(BaseModel):
    notification_type: int
    title: str
    description: str
    date_and_time: datetime
    status: int | None = 0
    action: str | None = None
    icon: str | None = None
    priority: int | None = 0
    user_id: int | None = None


class NotificationOut(NotificationIn):
    id: int

    model_config = ConfigDict(from_attributes=True)


class ValuationInput(BaseModel):
    property: ComparablePropertyIn
    comparable_properties: list[ComparablePropertyIn]
