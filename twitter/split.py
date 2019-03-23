import sys

twitter_length = 140

message = sys.stdin.readlines()[0].strip()
texts = []

for i in range(0, 100):
  text = message[i*twitter_length:(i+1)*twitter_length]
  if len(text) == 0:
    continue

print(texts)

