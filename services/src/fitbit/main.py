import os

def write_to_table():
    print(os.environ.get('TABLE_NAME'))

print("I am running in aws ecs cluster")
write_to_table()