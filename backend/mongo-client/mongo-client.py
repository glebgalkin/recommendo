import os
from pymongo import MongoClient

client = MongoClient(
    "mongodb+srv://iorecommendo:ROTIKmoi1015!@cluster0.vx235dx.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0")


def lambda_handler(event, context):
    db = client['recommendo']

    # Access the collection
    collection = db['posts']

    doc = {
        "_id": "custom_user_id_789",
        "name": "Gleb Galkin",
        "email": "gelb@recommendo.com",
        "age": 26
    }

    # Insert the document
    result = collection.insert_one(doc)

    # Print the ID of the inserted document
    print("Inserted document id:", result.inserted_id)

    return client.db.command("ping")


if __name__ == "__main__":
    print(lambda_handler(1, 2))
