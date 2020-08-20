import sys

nums = []
for x in range(22):
    nums.append([])
count = 0
for rawline in sys.stdin.readlines():
    line = rawline.strip(' \r\n')
    nums[count].append(line)
    count = count + 1
    if count == 22:
        count = 0

for line in nums:
    for v in line:
        print '%g\t' % (float(v)*1000) ,
    print ''

# print nums
