# import json

# def change_key_in_json(input_file_path, output_file_path, old_key, new_key):
#     # Read the JSON data from the input file
#     with open(input_file_path, 'r') as file:
#         data = json.load(file)
    
#     # Update the key in each entry
#     for entry in data:
#         if old_key in entry:
#             entry[new_key] = entry.pop(old_key)
    
#     # Write the updated data back to the output file
#     with open(output_file_path, 'w') as file:
#         json.dump(data, file, indent=4)

# # Replace with your actual file paths and keys
# input_file = "Grocery_Stores.json"
# output_file = "Updated_Grocery_Stores.json"
# old_key_name = "Store Name"
# new_key_name = "store_name"

# # Call the function with the file paths and keys
# change_key_in_json(input_file, output_file, old_key_name, new_key_name)

# print(f"File has been updated. New file is saved as '{output_file}'.")

# import json

# # Load the JSON data from a file
# with open('recipes.json', 'r') as file:
#     data = json.load(file)

# # Check if the data is a list of recipes or a single recipe
# # If the JSON is an array of objects, iterate through them
# if isinstance(data, list):
#     for recipe in data:
#         # Add the isFavorite key with a default value of 0
#         recipe['isFavorite'] = 0
# else:
#     # If the JSON is a single object, just add the key to that object
#     data['isFavorite'] = 0

# # Save the modified data back to the file
# with open('recipes.json', 'w') as file:
#     json.dump(data, file, indent=4)

# import json

# # Load the JSON file
# file_path = 'recipes_with_images.json'  # Replace with the actual file path
# with open(file_path, 'r') as file:
#     data = json.load(file)

# # Modify the 'image_name' field to add ".jpeg" at the end
# for recipe in data:
#     if 'image_name' in recipe:
#         recipe['image_name'] += ".jpeg"

# # Save the modified data back to the JSON file
# with open(file_path, 'w') as file:
#     json.dump(data, file, indent=4)

# print("Modification completed.")


# import json

# # Load the JSON file
# file_path = 'c:/Users/Umar/school/courses/5.fall_23/cs_440/440-Group-3-Fall-2023/Code/Smart_Grocery/assets/data/recipes_with_images.json'  # Replace with the actual file path
# with open(file_path, 'r') as file:
#     data = json.load(file)

# # Modify the 'image_name' field to add ".jpeg" at the end
# id = 0
# for recipe in data:
#     if 'recipe_id' in recipe:
#         recipe['recipe_id'] = id
#         id = id + 1

# # Save the modified data back to the JSON file
# with open(file_path, 'w') as file:
#     json.dump(data, file, indent=4)

# print("Modification completed.")


import json

# Load the JSON file
file_path = 'c:/Users/Umar/school/courses/5.fall_23/cs_440/440-Group-3-Fall-2023/Code/Smart_Grocery/assets/data/Grocery_Stores.json'  # Replace with the actual file path
with open(file_path, 'r') as file:
    data = json.load(file)

# Modify the 'image_name' field to add ".jpeg" at the end

# for store in data:
#     if 'store_name' in store:

values = [item['store_name'] for item in data if 'store_name' in item]        

unique_values = set(values)

print('Number of unique values:', unique_values)



# Save the modified data back to the JSON file
# with open(file_path, 'w') as file:
#     json.dump(data, file, indent=4)

# print("Modification completed.")
