import log_analysis as t9
import os

# Task9 폴더 내에 logs.txt, summary.txt 경로 할당당
log_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "logs.txt")
summary_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "summary.txt")

def check_file():
    try:
        with open(log_path, "x") as file:
            print("파일 생성 완료")
    except FileExistsError:
        print("파일이 이미 존재")

def write_file():
    input_text = input("로그 입력: ")
    while (input_text != ""):
        input_text = input_text.split("\n")
        with open(log_path, "a") as file:
            for text in input_text:
                file.write(text + "\n")
        input_text = input("로그 입력: ")

check_file()
write_file()

log_lines = t9.load_logs(log_path)

log_data = t9.parse_logs(log_lines)

# 사용자 이름 리스트 출력
user_names = set()
for date, users in log_data.items():
    user_names.update(users.keys())
print("로그 데이터 내 사용자 이름 리스트: ", list(user_names))

user_name = input("사용자 이름: ")
user_activity = t9.get_user_activity(log_data, user_name)

t9.save_summary(user_activity, summary_path)
print("summary.txt 쓰기 완료")
