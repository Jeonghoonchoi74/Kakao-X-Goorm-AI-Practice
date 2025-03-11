def load_logs(filename: str) -> list:
    try:
        with open(filename, "r") as file:
            log_lines = [line.strip() for line in file.readlines()]
        return log_lines
    except FileNotFoundError:
        return []

def parse_logs(log_lines: list) -> dict:
    logs = {}
    for line in log_lines:
        if line == "":
            continue
        # 예시 로그 포맷: "2025-03-10 user123 login"
        date, user_id, activity = line.split()
        if date not in logs: 
            logs[date] = {}
        if user_id not in logs[date]:
            logs[date][user_id] = []
        logs[date][user_id].append(activity)
    return logs

def get_user_activity(log_data: dict, user_id: str) -> dict:
    user_logs = {}
    if user_id not in log_data:
        print ("사용자가 존재하지 않습니다.")
        return user_logs
    else:
        for date, users in log_data.items():
            if user_id in users:
                user_logs[date] = users[user_id]
        return user_logs

def save_summary(log_data: dict, filename: str) -> None:
    with open(filename, "w") as file:
        for date, activities in log_data.items():
            file.write(f"{date}: {activities}\n")