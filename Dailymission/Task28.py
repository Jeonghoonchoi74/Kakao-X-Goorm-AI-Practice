def calculate_shots(n, healths):
    total_shots = 0
    damage_index = 0
    
    for i in range(n):
        enemy_health = healths[i]
        
        while enemy_health > 0:
            damage = (damage_index % 4) + 1
            enemy_health -= damage
            damage_index += 1
            total_shots += 1
    
    return total_shots

# 입력 처리
n = int(input())
healths = list(map(int, input().split()))

# 결과 출력
result = calculate_shots(n, healths)
print(result)
