

import csv
import random
import pymongo


from pymongo import MongoClient, errors

def create_database_and_table():
    client = MongoClient("mongodb://localhost:27017/")
    db = client["mydb"]
    emp_collection = db["emp"]

    # Create unique index on 'id' field (simulate primary key)
    try:
        emp_collection.create_index("id", unique=True)
        print("Database and collection created. Unique index on 'id' added.")
    except errors.OperationFailure as e:
        print("Index creation failed:", e)



def generate_sample_csv(filename="emp_data.csv", count=100):
    with open(filename, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(["id", "name", "address", "salary"])
        for i in range(1, count + 1):
            writer.writerow([
                i,
                f"Employee{i}",
                f"Address {i}",
                round(random.uniform(30000, 100000), 2)
            ])
    print(f"Sample data written to {filename}")


def load_csv_to_mongodb(filename="emp_data.csv"):
    import csv
    client = MongoClient("mongodb://localhost:27017/")
    db = client["mydb"]
    emp_collection = db["emp"]

    with open(filename, mode='r') as file:
        reader = csv.DictReader(file)
        data = []
        for row in reader:
            row['id'] = int(row['id'])
            row['salary'] = float(row['salary'])
            data.append(row)

    try:
        emp_collection.insert_many(data, ordered=False)
        print("Data loaded into MongoDB.")
    except errors.BulkWriteError as e:
        print("Some records may already exist or failed:", e.details)


def read_employee_by_id(emp_id):
    client = MongoClient("mongodb://localhost:27017/")
    db = client["mydb"]
    emp_collection = db["emp"]

    result = emp_collection.find_one({"id": emp_id}, {"_id": 0})
    if result:
        print("Employee Found:", result)
    else:
        print("Employee not found.")


## TEST ####
create_database_and_table()
generate_sample_csv()
load_csv_to_mongodb()
read_employee_by_id(5)  # Replace with desired ID


