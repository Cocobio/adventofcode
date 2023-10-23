import sys

score = 0
score2 = 0

for line in sys.stdin:
    line = line.strip()

    if len(line) == 0:
        break

print(score)
print(score2)
