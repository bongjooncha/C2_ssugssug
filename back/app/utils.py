import hashlib
import secrets

def get_password_hash(password: str) -> str:
    """서버 측에서 비밀번호를 다시 salt 처리하고 해시"""
    salt = secrets.token_hex(8)
    hashed_password = hashlib.sha256(f"{password}{salt}".encode()).hexdigest()
    return f"{salt}${hashed_password}"

def verify_password(plain_password: str, hashed_password: str) -> bool:
    """비밀번호 검증"""
    salt, stored_hash = hashed_password.split('$')
    calculated_hash = hashlib.sha256(f"{plain_password}{salt}".encode()).hexdigest()
    return calculated_hash == stored_hash 