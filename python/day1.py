import heapq
import sys

max = 0
acc = 0
N = 3

mins = [0]*N

for line in sys.stdin:
    line = line.strip()

    if len(line) == 0:
        if acc > max:
            max = acc
        heapq.heappush(mins, acc)
        heapq.heappop(mins)
        acc = 0
    else:
        acc += int(line)

print(max)
print(sum(mins))
