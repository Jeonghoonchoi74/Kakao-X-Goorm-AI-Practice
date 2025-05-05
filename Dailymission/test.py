import pyautogui
import time

print("🖱️ 마우스를 좌상단으로 옮기고 3초 기다리세요...")
time.sleep(3)
x1, y1 = pyautogui.position()
print(f"📍 좌상단 좌표: ({x1}, {y1})")

print("🖱️ 마우스를 우하단으로 옮기고 3초 기다리세요...")
time.sleep(3)
x2, y2 = pyautogui.position()
print(f"📍 우하단 좌표: ({x2}, {y2})")

print(f"🔲 crop_box = ({x1}, {y1}, {x2 - x1}, {y2 - y1})")
