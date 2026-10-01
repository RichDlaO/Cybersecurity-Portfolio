# Script: update_allow_list.py
# Description: Algorithm for file updates in Python to manage IP access lists.

# Define the file path and the list of IP addresses to remove
import_file = 'allow_list.txt'
remove_list = ["192.168.97.225", "192.168.158.170", "192.168.201.40", "192.168.58.57"]

# 1. Open the file that contains the allow list.
with open(import_file, 'r') as file:
    # 2. Read the file contents.
    ip_addresses = file.read()

# 3. Convert the string into a list.
ip_addresses = ip_addresses.split()

# 4. Iterate through the remove list & 5. Remove IP addresses.
for element in remove_list:
    if element in ip_addresses:
        ip_addresses.remove(element)

# 6. Update the file with the revised list of IP addresses.
ip_addresses_str = '\n'.join(ip_addresses)

with open(import_file, 'w') as file:
    file.write(ip_addresses_str)

print("Allow list successfully updated.")
