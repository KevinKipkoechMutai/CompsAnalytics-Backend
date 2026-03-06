from datetime import datetime

from sqlalchemy import DateTime, Integer, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from .database import Base


class User(Base):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    user_name: Mapped[str | None] = mapped_column(String)
    phone_no: Mapped[str | None] = mapped_column(String)
    email: Mapped[str] = mapped_column(String, unique=True, index=True)
    password_digest: Mapped[str] = mapped_column(String)
    gender: Mapped[str | None] = mapped_column(String)
    avatar: Mapped[str | None] = mapped_column(String)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class Transaction(Base):
    __tablename__ = "transactions"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    transaction_code: Mapped[int | None] = mapped_column(Integer)
    amount: Mapped[int | None] = mapped_column(Integer)
    account_number: Mapped[int | None] = mapped_column(Integer)
    account_name: Mapped[str | None] = mapped_column(String)
    payment_method: Mapped[str | None] = mapped_column(String)
    user_name: Mapped[str | None] = mapped_column(String)
    account_id: Mapped[int | None] = mapped_column(Integer)
    user_id: Mapped[int | None] = mapped_column(Integer)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class Property(Base):
    __tablename__ = "properties"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    image: Mapped[str | None] = mapped_column(String)
    lr_no: Mapped[str | None] = mapped_column(String)
    location: Mapped[str | None] = mapped_column(String)
    category: Mapped[str | None] = mapped_column(String)
    analysis: Mapped[str | None] = mapped_column(String)
    description: Mapped[str | None] = mapped_column(Text)
    title: Mapped[str | None] = mapped_column(String)
    size: Mapped[int | None] = mapped_column(Integer)
    value: Mapped[str | None] = mapped_column(String)
    user_id: Mapped[int | None] = mapped_column(Integer)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class Account(Base):
    __tablename__ = "accounts"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    account_name: Mapped[str | None] = mapped_column(String)
    tokens: Mapped[int | None] = mapped_column(Integer)
    account_number: Mapped[int | None] = mapped_column(Integer)
    account_email: Mapped[str | None] = mapped_column(String)
    password_digest: Mapped[str | None] = mapped_column(String)
    user_id: Mapped[int | None] = mapped_column(Integer)
    acc_no: Mapped[str | None] = mapped_column(String)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class ComparableProperty(Base):
    __tablename__ = "comparable_properties"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    location: Mapped[str | None] = mapped_column(String)
    size: Mapped[int | None] = mapped_column(Integer)
    category: Mapped[str | None] = mapped_column(String)
    value: Mapped[int | None] = mapped_column(Integer)
    title: Mapped[str | None] = mapped_column(String)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class Notification(Base):
    __tablename__ = "notifications"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    notification_type: Mapped[int | None] = mapped_column(Integer)
    title: Mapped[str | None] = mapped_column(String)
    description: Mapped[str | None] = mapped_column(Text)
    date_and_time: Mapped[datetime | None] = mapped_column(DateTime)
    status: Mapped[int | None] = mapped_column(Integer, default=0)
    action: Mapped[str | None] = mapped_column(String)
    icon: Mapped[str | None] = mapped_column(String)
    priority: Mapped[int | None] = mapped_column(Integer, default=0)
    user_id: Mapped[int | None] = mapped_column(Integer)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
