import json

# Assuming your JSON data is in a file called 'data.json'
with open('Grocery_Stores.json', 'r') as file:
    data = json.load(file)

# Add a store_id to each entry, starting from 1
for i, entry in enumerate(data, start=1):
    entry["store_id"] = i

# Write the updated data back to a file
with open('updated_data.json', 'w') as file:
    json.dump(data, file, indent=4)
